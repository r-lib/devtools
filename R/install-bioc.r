#' Install a package from a Bioconductor repository
#'
#' This function requires \code{git} to be installed on your system in order to
#' be used.
#'
#' It is vectorised so you can install multiple packages with
#' a single command.
#'
#' '
#' @inheritParams install_git
#' @param repo Repository address in the format
#'   \code{[username:password@@][release/]repo[#commit]}. Valid values for
#'   the release are \sQuote{devel} (the default if none specified),
#'   \sQuote{release} or numeric release numbers (e.g. \sQuote{3.3}).
#' @param mirror The bioconductor git mirror to use
#' @param ... Other arguments passed on to \code{\link{install}}
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_bioc("SummarizedExperiment")
#' install_bioc("release/SummarizedExperiment")
#' install_bioc("3.3/SummarizedExperiment")
#' install_bioc("SummarizedExperiment#abc123")
#' install_bioc("user:password@release/SummarizedExperiment")
#' install_bioc("user:password@devel/SummarizedExperiment")
#' install_bioc("user:password@SummarizedExperiment#abc123")
#'}
install_bioc <- function(repo, mirror = getOption("BioC_git", "https://git.bioconductor.org/packages"), ..., quiet = FALSE) {
  remotes <- lapply(repo, bioc_remote, mirror = mirror)

  install_remotes(remotes, ..., quiet = quiet)
}

# Parse concise git repo specification: [username:password@][branch/]repo[#commit]
parse_bioc_repo <- function(path) {
  user_pass_rx <- "(?:([^:]+):([^:@]+)@)?"
  release_rx <- "(?:(devel|release|[0-9.]+)/)?"
  repo_rx <- "([^/@#]+)"
  commit_rx <- "(?:[#]([a-zA-Z0-9]+))?"
  bioc_rx <- sprintf("^(?:%s%s%s%s|(.*))$", user_pass_rx, release_rx, repo_rx, commit_rx)

  param_names <- c("username", "password", "release", "repo", "commit", "invalid")
  replace <- stats::setNames(sprintf("\\%d", seq_along(param_names)), param_names)
  params <- lapply(replace, function(r) gsub(bioc_rx, r, path, perl = TRUE))
  if (params$invalid != "")
    stop(sprintf("Invalid bioc repo: %s", path))

  params <- params[sapply(params, nchar) > 0]

  if (!is.null(params$release) && !is.null(params$commit)) {
    stop("release and commit should not both be specified")
  }

  params
}

bioc_remote <- function(repo, mirror = getOption("BioC_git", "https://git.bioconductor.org/packages")) {
  meta <- parse_bioc_repo(repo)

  branch <- bioconductor_branch(meta$release, meta$commit)

  if (!is.null(meta$username) && !is.null(meta$password)) {
    meta$credentials <- git2r::cred_user_pass(meta$username, meta$password)
  }

  remote("bioc",
         mirror = mirror,
         repo = meta$repo,
         url = paste0(mirror, "/", meta$repo),
         release = meta$release %||% "release",
         commit = meta$commit,
         branch = branch,
         credentials = meta$credentials
  )
}

#' @export
remote_download.bioc_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading Bioconductor repo ", x$url)
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
remote_metadata.bioc_remote <- function(x, bundle = NULL, source = NULL) {
  if (!is.null(bundle)) {
    r <- git2r::repository(bundle)
    sha <- git_repo_sha1(r)
  } else {
    sha <- NULL
  }

  list(
    RemoteType = "git",
    RemoteUrl = x$url,
    RemoteRef = x$ref,
    RemoteSha = sha
  )
}

#' @export
remote_package_name.bioc_remote <- function(remote, ...) {
  remote$repo
}

#' @export
remote_sha.bioc_remote <- function(remote, ...) {
  # If the remote ref is the same as the sha it is a pinned commit so just
  # return that.
  if (!is.null(remote$ref) &&
      grepl(paste0("^", remote$ref), remote$sha)) {
    return(remote$sha)
  }

  tryCatch({
    res <- git2r::remote_ls(remote$url, credentials=remote$credentials, ...)

    found <- grep(pattern = paste0("/", remote$branch), x = names(res))

    if (length(found) == 0) {
      return(NA)
    }

    unname(res[found[1]])
  }, error = function(e) NA_character_)
}

bioconductor_branch <- function(release, commit) {
  if (!is.null(commit)) {
    commit
  } else {
    if (is.null(release)) {
      release <- "devel"
    }
    if (release == "release") {
      release <- bioconductor_release()
    }
    switch(
      tolower(release),
      devel = "master",
      paste0("RELEASE_",  gsub("\\.", "_", release))
    )
  }
}

bioconductor_release <- memoise::memoise(function() {
  tmp <- tempfile()
  download.file("http://bioconductor.org/config.yaml", tmp, quiet = TRUE)

  gsub("release_version:[[:space:]]+\"([[:digit:].]+)\"", "\\1",
       grep("release_version:", readLines(tmp), value = TRUE))
})

format.bioc_remote <- function(x, ...) {
  "Bioc"
}
