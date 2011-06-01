#' Detach and reload package.
#' 
#' @export
reload <- function(pkg) {
  pkg <- as.package(pkg)
  name <- env_name(pkg)
  
  if (is.loaded(pkg)) unload(pkg)
  require(pkg$package, character.only = TRUE)
  
}

is.loaded <- function(pkg) {
  env_name(pkg) %in% search()
}

unload <- function(pkg) {
  detach(env_name(pkg), character.only = TRUE, force = TRUE, unload = TRUE)
}