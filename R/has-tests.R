#' Was devtools installed with tests?
#'
#' @keywords internal
#' @export
has_tests <- function() {
  test_path <- tryCatch(
    path_package("devtools", "tests"),
    error = function(e) NULL
  )

  !is.null(test_path)
}
