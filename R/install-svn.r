#' Install a package from a SVN repository
#'
#' This function requires \code{svn} to be installed on your system in order to
#' be used.
#'
#' It is vectorised so you can install multiple packages with
#' a single command.
#'
#' @inheritParams install_git
#' @param subdir A sub-directory withing a svn repository that may contain the
#'   package we are interested in installing. By default, this
#'   points to the 'trunk' directory.
#' @param args A character vector providing extra arguments to pass on to
#    svn.
#' @param branch Name of branch or tag to use, if not trunk.
#' @param ... Other arguments passed on to \code{\link{install}}
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_svn("https://github.com/hadley/stringr")
#' install_svn("https://github.com/hadley/httr", branch = "oauth")
#'}
install_svn <- function(url, subdir = NULL, branch = NULL, args = character(0),
  ...) {

  remotes <- lapply(url, svn_remote, subdir = subdir, branch = branch,
    args = args)

  install_remotes(remotes, ...)
}

svn_remote <- function(url, subdir = NULL, branch = NULL, args = character(0)) {
  remote("svn",
    url = url,
    subdir = subdir,
    branch = branch,
    args = args
  )
}

#' @export
remote_download.svn_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading svn repo ", x$url)
  }

  bundle <- tempfile()
  svn_binary_path <- svn_path()

  args <- c('co')
  if (!is.null(x$branch)) {
    url <- file.path(x$url, "branches", x$branch)
  } else {
    url <- file.path(x$url, "trunk")
  }
  args <- c(args, x$args, url, bundle)

  message(shQuote(svn_binary_path), " ", paste0(args, collapse = " "))
  request <- system2(svn_binary_path, args, stdout = FALSE, stderr = FALSE)

  # This is only looking for an error code above 0-success
  if (request > 0) {
    stop("There seems to be a problem retrieving this SVN-URL.", call. = FALSE)
  }

  bundle
}

#' @export
remote_metadata.svn_remote <- function(x, bundle = NULL, source = NULL) {
  list(
    RemoteType = "svn",
    RemoteUrl = x$url,
    RemoteSubdir = x$subdir,
    RemoteArgs = if (length(x$args) > 0) paste0(deparse(x$args), collapse = " ")
  )
}

svn_path <- function(svn_binary_name = NULL) {
  # Use user supplied path
  if (!is.null(svn_binary_name)) {
    if (!file.exists(svn_binary_name)) {
      stop("Path ", svn_binary_name, " does not exist", .call = FALSE)
    }
    return(svn_binary_name)
  }

  # Look on path
  svn_path <- Sys.which("svn")[[1]]
  if (svn_path != "") return(svn_path)

  # On Windows, look in common locations
  if (.Platform$OS.type == "windows") {
    look_in <- c(
      "C:/Program Files/Svn/bin/svn.exe",
      "C:/Program Files (x86)/Svn/bin/svn.exe"
    )
    found <- file.exists(look_in)
    if (any(found)) return(look_in[found][1])
  }

  stop("SVN does not seem to be installed on your system.", call. = FALSE)
}
