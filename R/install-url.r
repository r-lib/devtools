#' Install a package from a url
#'
#' @param url location of package on internet
#' @export
install_url <- function(url, name = NULL) {
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
