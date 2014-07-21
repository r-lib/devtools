#' Install a package from a SVN repository
#'
#' This function requires \code{svn} to be installed on your system in order to
#' be used.
#'
#' It is vectorised so you can install multiple packages with
#' a single command.
#'
#' @inheritParams install_svn_single
#' @param branch  Name of branch or tag to use, if not trunk.
#' @param ...        Other arguments passed on to \code{\link{install}}
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_svn("https://github.com/hadley/devtools")
#' install_svn("https://github.com/hadley/devtools", branch = "clean-source")
#' install_svn(c("https://github.com/hadley/devtools", "https://github.com/hadley/stringr"))
#'}
install_svn <- function(svn_url, name = NULL, subdir = "trunk",
  branch = NULL, svn_args = character(0), svn_binary = NULL, ...) {

  if (is.null(name)) {
    name <- rep(list(NULL), length(svn_url))
  }

  invisible(mapply(install_svn_single, svn_url, name,
    MoreArgs = list(
      subdir = subdir,
      svn_args = svn_args,
      svn_binary = svn_binary,
      branch = branch,
      ...
    )
  ))
}

#' Install a single package from a svn repository
#'
#' This function allows you to install a single package from a svn repository.
#'
#' See \code{\link{install_svn}} for more information about the paraemeters.
#'
#' @param svn_url Location of package. The url should point to a public or
#'                private repository.
#' @param name    Optional package name, used to provide more informative
#'                messages.
#' @param subdir A sub-directory withing a svn repository that may contain the
#'               package we are interested in installing. By default, this
#'               points to the 'trunk' directory.
#' @param svn_args A character vector providing extra arguments to pass on to
#                  svn.
#' @param svn_binary A custom svn-binary to use instead of default system's svn
#'                   version.
#' @param ... passed on to \code{\link{install}}
#' @keywords internal
install_svn_single <- function(svn_url, name = NULL, subdir = "trunk",
  branch = NULL, svn_args = character(), svn_binary = NULL, ...) {

  if (is.null(name)) {
    name <- basename(svn_url)
  }

  message("Preparing installation of ", name, " using the SVN-URL: ", svn_url)

  # Unique temporary file-name.
  bundle <- tempfile()

  # \code{svn_path} will handle the NULL and return the system default.
  svn_binary_path <- svn_path(svn_binary)

  # Clone the package file from the svn repository.
  # @TODO: Handle configs, this currently only supports public repos
  #        and repositories with the public SSH key set.
  args <- c('co')
  if (!is.null(branch)) {
      subdir = file.path("branches", branch)
  }
  args <- c(args, svn_args, svn_url, bundle)

  message(shQuote(svn_binary_path), paste0(args, collapse = " "))
  request <- system2(svn_binary_path, args, stdout = FALSE, stderr = FALSE)

  # This is only looking for an error code above 0-success
  if (request > 0) {
    stop("There seems to be a problem retrieving this SVN-URL.", call. = FALSE)
  }

  install_local_single(bundle, subdir = subdir, ...)
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
