# Create the devtools metadata environment.
# @param a namespace environment in which to create the metadata env
create_dev_meta <- function(env) {
  env$.__DEVTOOLS__ <- new.env(parent = emptyenv())
}

#' Return devtools metadata environment
#'
#' @param name The name of a loaded package
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
dev_meta <- function(name) {
  ns <- .Internal(getRegisteredNamespace(as.name(name)))
  if (is.null(ns)) {
    stop("Namespace not found for ", name, ". Is it loaded?")
  }

  x <- ns$.__DEVTOOLS__

  if (is.null(x)) {
    stop("No devtools metadata found for ", name,
      ". Was it loaded with devtools?")
  }

  x
}
