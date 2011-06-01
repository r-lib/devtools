#' Detach and reload package.
#' 
reload <- function(pkg) {
  pkg <- as.package(pkg)
  name <- env_name(pkg)
  
  if (name %in% search()) {
    detach(name, character.only = TRUE, force = TRUE)
  }
  require(pkg$package, character.only = TRUE)
  
}