#' Was devtools installed with tests?
#'
#' @keywords internal
#' @export
has_tests <- function() {
  system.file("test", package = "devtools") != ""
}
