#' Run .onLoad if needed
#'
#' This is run before copying objects from the namespace to the package
#' environment. In a normal install + load, the namespace would be
#' locked between these stages, but we don't do that with load_all.
#'
#' devtools creates a variable called .__loaded in the namespace
#' to indicate that it's attached.
run_onload <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  # Run .onLoad if it's defined. Set a flag .__loaded in the
  # namespace environment.
  if (exists(".onLoad", nsenv, inherits = FALSE) &&
     !exists(".__loaded", nsenv, inherits = FALSE)) {
    nsenv$.onLoad()
    nsenv$.__loaded <- TRUE
  }
}

#' Run .onAttach if needed
#'
#' This is run after copying objects from the namespace to the package
#' environment. In a normal install + load, the namespace would be
#' locked between these stages, but we don't do that with load_all.
#'
#' devtools creates a variable called .__attached in the namespace
#' to indicate that it's attached.
run_onattach <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  if (exists(".onAttach", nsenv, inherits = FALSE) &&
     !exists(".__attached", nsenv, inherits = FALSE)) {
    nsenv$.onAttach()
    nsenv$.__attached <- TRUE
  }
}
