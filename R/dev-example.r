#' Run a examples for an in-development function.
#'
#' @inheritParams run_examples
#' @param topic Name or topic (or name of Rd) file to run examples for
#' @export
#' @family example functions
#' @examples
#' \dontrun{
#' # Runs installed example:
#' library("ggplot2")
#' example("ggplot")
#'
#' # Runs develoment example:
#' load_all("ggplot2")
#' dev_example("ggplot")
#' }
dev_example <- function(topic) {
  path <- find_topic(topic)

  if (is.null(path)) {
    stop("Can't find development example for topic ", topic, call. = FALSE)
  }

  pkg <- as.package(names(path)[[1]])
  load_all(pkg)

  run_example(path)
}
