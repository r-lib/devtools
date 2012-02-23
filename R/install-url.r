#' Install a package from a url
#'
#' This function is vectorised so you can install multiple packages in 
#' a single command.
#'
#' @param url location of package on internet
#' @param name optional package name, used to provide more informative
#'   messages
#' @param ... Other arguments passed on to \code{\link{install.packages}}.
#' @export
#' @family package installation
install_url <- function(url, name = NULL, ...) {
  if (is.null(name)) {
    name <- rep(list(NULL), length(url))
  }
  
  invisible(mapply(install_url_single, url, name, ...))
}

#' @importFrom RCurl getBinaryURL
install_url_single <- function(url, name = NULL, ...) {
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
  
  # Check it's an R package
  if (!file.exists(file.path(unbundle, "DESCRIPTION"))) {
    stop("Does not appear to be an R package", call. = FALSE)
  }

  config_path <- file.path(unbundle, "configure")
  if (file.exists(config_path)) {
    Sys.chmod(config_path, "777")
  }
  
  # Install
  install(unbundle, ...)
}
