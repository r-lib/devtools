pkg_env <- function(pkg) {
  pkg <- as.package(pkg)
  name <- env_name(pkg)
  
  if (!(name %in% search())) {
    attach(new.env(parent = emptyenv()), name = name)
  }
  
  as.environment(name)
}

clear_pkg_env <- function(pkg) {
  name <- env_name(pkg)
  
  if (name %in% search()) {
    detach(name, character.only = TRUE)
  }  
}

env_name <- function(pkg) {
  pkg <- as.package(pkg)
  str_c("devel:", pkg$package)
}