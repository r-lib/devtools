#' Run .onLoad if needed
#'
#' This is run before copying objects from the namespace to the package
#' environment. In a normal install + load, the namespace would be
#' locked between these stages, but we don't do that with load_all.
#'
#' A variable called \code{onLoad} is created in the package's
#' devtools metdata to indicate that it's attached.
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
run_onload <- function(pkg = ".") {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  metadata <- dev_meta(pkg$package)
  # Run .onLoad if it's defined. Set a flag 'onLoad' in the metadata
  if (exists(".onLoad", nsenv, inherits = FALSE) &&
     is.null(metadata$onLoad)) {
    nsenv$.onLoad()
    metadata$onLoad <- TRUE
  }
}

#' Run .onAttach if needed
#'
#' This is run after copying objects from the namespace to the package
#' environment. In a normal install + load, the namespace would be
#' locked between these stages, but we don't do that with load_all.
#'
#' A variable called \code{onAttach} is created in the package's
#' devtools metdata to indicate that it's attached.
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @importFrom httr parsed_content
run_onattach <- function(pkg = ".") {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  metadata <- dev_meta(pkg$package)
  # Run .onAttach if it's defined. Set a flag 'onAttach' in the metadata
  if (exists(".onAttach", nsenv, inherits = FALSE) &&
     is.null(metadata$onAttach)) {
    nsenv$.onAttach()
    metadata$onAttach <- TRUE
  }
}
