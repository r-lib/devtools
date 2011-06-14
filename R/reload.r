#' Detach and reload package.
#' 
#' See the caveats in \code{\link{detach}} for the many reasons why this 
#' might not work. If in doubt, quit R and restart.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
reload <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  message("Reloading installed ", pkg$package)
  name <- env_name(pkg)
  
  if (is.loaded(pkg)) unload(pkg)
  require(pkg$package, character.only = TRUE, quiet = TRUE)
  
}

is.loaded <- function(pkg = NULL) {
  env_name(pkg) %in% search()
}

unload <- function(pkg = NULL) {
  detach(env_name(pkg), character.only = TRUE, force = TRUE, unload = TRUE)
}