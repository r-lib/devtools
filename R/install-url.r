#' Install a package from a url
#'
#' This function is vectorised so you can install multiple packages in 
#' a single command.
#'
#' @param url location of package on internet. The url should point to a 
#'   zip file, a tar file or a bzipped/gzipped tar file.
#' @param name optional package name, used to provide more informative
#'   messages
#' @param subdir subdirectory within url bundle that contains the R package.
#' @param ... Other arguments passed on to \code{\link{install.packages}}.
#' @export
#' @family package installation
install_url <- function(url, name = NULL, subdir = NULL, ...) {
  if (is.null(name)) {
    name <- rep(list(NULL), length(url))
  }
  
  invisible(mapply(install_url_single, url, name, subdir = subdir, ...))
}

#' @importFrom RCurl getBinaryURL
install_url_single <- function(url, name = NULL, subdir = NULL, ...) {
  if (is.null(name)) {
    name <- basename(url)
  }

  message("Installing ", name, " from ", dirname(url))
  bundle <- file.path(tempdir(), name)
  
  # Download package file
  content <- getBinaryURL(url, .opts = list(
    followlocation = TRUE, ssl.verifypeer = FALSE))
  writeBin(content, bundle)
  on.exit(unlink(bundle), add = TRUE)
  
  unbundle <- decompress(bundle)
  on.exit(unlink(unbundle), add = TRUE)
  
  pkg_path <- if (is.null(subdir)) unbundle else file.path(unbundle, subdir)
  
  # Check it's an R package
  if (!file.exists(file.path(pkg_path, "DESCRIPTION"))) {
    stop("Does not appear to be an R package", call. = FALSE)
  }

  config_path <- file.path(pkg_path, "configure")
  if (file.exists(config_path)) {
    Sys.chmod(config_path, "777")
  }
  
  # Install
  install(pkg_path, ...)
}
