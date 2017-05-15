#' Install a package from a git repository
#'
#' It is vectorised so you can install multiple packages with
#' a single command. You do not need to have git installed.
#'
#' @param url Location of package. The url should point to a public or
#'   private repository.
#' @param subdir A sub-directory within a git repository that may
#'   contain the package we are interested in installing.
#' @param branch Name of branch or tag to use, if not master.
#' @param credentials A git2r credentials object passed through
#'   to \code{\link[git2r]{clone}}.
#' @param args DEPRECATED. A character vector providing extra arguments to
#'   pass on to git.
#' @param ... passed on to \code{\link{install}}
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_git("git://github.com/hadley/stringr.git")
#' install_git("git://github.com/hadley/stringr.git", branch = "stringr-0.2")
#'}
install_git <- function(url, subdir = NULL, branch = NULL, credentials = NULL,
  args = character(0), ...) {
  if (!missing(args))
    warning("`args` is deprecated", call. = FALSE)

  remotes <- lapply(url, git_remote, subdir = subdir,
                    branch = branch, credentials=credentials)

  install_remotes(remotes, ...)
}

git_remote <- function(url, subdir = NULL, branch = NULL, credentials=NULL) {
  remote("git",
    url = url,
    subdir = subdir,
    branch = branch,
    credentials = credentials
  )
}

#' @export
remote_download.git_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading git repo ", x$url)
  }

  bundle <- tempfile()
  git2r::clone(x$url, bundle, credentials=x$credentials, progress = FALSE)

  if (!is.null(x$branch)) {
    r <- git2r::repository(bundle)
    git2r::checkout(r, x$branch)
  }

  bundle
}

#' @export
remote_metadata.git_remote <- function(x, bundle = NULL, source = NULL) {
  if (!is.null(bundle)) {
    r <- git2r::repository(bundle)
    sha <- git_repo_sha1(r)
  } else {
    sha <- NULL
  }

  list(
    RemoteType = "git",
    RemoteUrl = x$url,
    RemoteSubdir = x$subdir,
    RemoteRef = x$ref,
    RemoteSha = sha
  )
}

#' @export
remote_package_name.git_remote <- function(remote, ...) {
  tmp <- tempfile()
  on.exit(unlink(tmp))
  description_path <- paste0(collapse = "/", c(remote$subdir, "DESCRIPTION"))

  # Try using git archive --remote to retrieve the DESCRIPTION, if the protocol
  # or server doesn't support that return NULL
  res <- try(silent = TRUE,
    system_check(git_path(),
      args = c("archive", "-o", tmp, "--remote", remote$url,
        if (is.null(remote$branch)) "HEAD" else remote$branch,
        description_path),
      quiet = TRUE))

  if (inherits(res, "try-error")) {
    return(NA)
  }

  # git archive return a tar file, so extract it to tempdir and read the DCF
  utils::untar(tmp, files = description_path, exdir = tempdir())

  read_dcf(file.path(tempdir(), description_path))$Package
}

#' @export
remote_sha.git_remote <- function(remote, ...) {
  # If the remote ref is the same as the sha it is a pinned commit so just
  # return that.
  if (!is.null(remote$ref) &&
    grepl(paste0("^", remote$ref), remote$sha)) {
    return(remote$sha)
  }

  tryCatch({
    res <- git2r::remote_ls(remote$url, ...)

    branch <- remote$branch %||% "master"

    found <- grep(pattern = paste0("/", branch), x = names(res))

    if (length(found) == 0) {
      return(NA)
    }

    unname(res[found[1]])
  }, error = function(e) NA_character_)
}

#' @export
format.git_remote <- function(x, ...) {
  "Git"
}
