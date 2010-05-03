load_dependencies <- function(pkg) {
  pkgs <- parse_packages(pkg$depends)
  lapply(pkg, require, character.only = TRUE, quietly = TRUE, 
    warn.conflicts = FALSE)
}

parse_packages <- function(string) {
  stringr::str_split(string, ", ")[[1]]
}
