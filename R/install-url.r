#' Install a package from a url
#'
#' This function is vectorised so you can install multiple packages in 
#' a single command.
#'
#' @param url location of package on internet
#' @export
#' @family package installation
install_url <- function(url, name = NULL) {
  if (is.null(name)) {
    name <- rep(list(NULL), length(url))
  }
  
  mapply(install_url_single, url, name)
}

#' @importFrom RCurl getBinaryURL
install_url_single <- function(url, name = NULL) {
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
  
  # Install
  install(unbundle)
}
