#' Run .onLoad and .onAttach, if needed
#'
run_loadhooks <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)
  pkgenv <- pkg_env(pkg)

  # Run .onLoad if it's defined. Set a flag .__loaded in the
  # namespace environment.
  if (exists(".onLoad", nsenv, inherits = FALSE) &&
     !exists(".__loaded", nsenv, inherits = FALSE)) {
    nsenv$.onLoad()
    nsenv$.__loaded <- TRUE
  }

  # Run .onAttach if it's defined. Note that the .__attached flag
  # is stored in the package environment, not namespace environment
  # because the attachment happens when the package environment is
  # created and attached (set as a parent of global environment).
  if (exists(".onAttach", nsenv, inherits = FALSE) &&
     !exists(".__attached", pkgenv, inherits = FALSE)) {
    nsenv$.onAttach()
    pkgenv$.__attached <- TRUE
  }
}
