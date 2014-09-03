#' Install a package from a git repository
#'
#' It is vectorised so you can install multiple packages with
#' a single command.
#'
#' @param url Location of package. The url should point to a public or
#'   private repository.
#' @param branch Name of branch or tag to use, if not master.
#' @param subdir A sub-directory withing a git repository that may
#'   contain the package we are interested in installing.
#' @param args A character vector providing extra arguments to pass on to
#    git.
#' @param ... passed on to \code{\link{install}}
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_git("git://github.com/hadley/stringr.git")
#' install_git("git://github.com/hadley/stringr.git", branch = "stringr-0.2")
#'}
install_git <- function(url, subdir = NULL, branch = NULL, args = character(0),
                        ...) {

  remotes <- lapply(url, git_remote, subdir = subdir, branch = branch,
    args = args)

  install_remotes(remotes, ...)
}

git_remote <- function(url, subdir = NULL, branch = NULL, args = character(0)) {
  remote("git",
    url = url,
    subdir = subdir,
    branch = branch,
    args = args
  )
}

#' @export
remote_download.git_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading git repo ", x$url)
  }

  bundle <- tempfile()

  args <- c('clone', '--depth', '1', '--no-hardlinks')
  if (!is.null(x$branch)) args <- c(args, "--branch", x$branch)
  args <- c(args, x$args, x$url, bundle)
  git(paste0(args, collapse = " "), quiet = quiet)

  bundle
}

#' @export
remote_metadata.git_remote <- function(x, bundle = NULL, source = NULL) {
  list(
    RemoteType = "git",
    RemoteUrl = x$url,
    RemoteSubdir = x$subdir,
    RemoteRef = x$ref,
    RemoteSha = git_remote_sha1(x$url),
    RemoteArgs = if (length(x$args) > 0) paste0(deparse(x$args), collapse = " ")
  )
}

git_remote_sha1 <- function(url, ref = "master") {
  refs <- git(paste("ls-remote", url, ref))

  refs_df <- read.delim(text = refs, stringsAsFactors = FALSE, sep = "\t",
    header = FALSE)
  names(refs_df) <- c("sha", "ref")

  refs_df$sha[1]
}
