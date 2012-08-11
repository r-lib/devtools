#' Return a vector of names of attached packages
#' @export
loaded_packages <- function() {
  names <- search()
  names <- names[grepl("^package:", names)]
  sub("^package:", "", names)
}
