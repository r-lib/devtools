#' Return devtools metadata environment
#'
#' @param name The name of a loaded package
#' @param create If the metadata environment does not exist, create it?
#'   For internal use only.
#' @examples
#' # Load the test package in directory "load-hooks"
#' load_all(devtest("load-hooks"))
#'
#' # Get metdata for the package
#' # (The name of the package in DESCRIPTION is "loadhooks")
#' x <- dev_meta("loadhooks")
#' as.list(x)
#'
#' # Clean up.
#' unload(devtest("load-hooks"))
#' @export
dev_meta <- function(name, create = FALSE) {
  ns <- .Internal(getRegisteredNamespace(as.name(name)))
  if (is.null(ns)) {
    stop("Namespace not found for ", name, ". Is it loaded?")
  }

  if (is.null(ns$.__DEVTOOLS__)) {
    if (create) {
      ns$.__DEVTOOLS__ <- new.env(parent = ns)
    } else {
      stop("No devtools metadata found for ", name,
        ". Was it loaded with devtools?")
    }
  }

  ns$.__DEVTOOLS__
}
