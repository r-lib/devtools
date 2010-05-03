load_deps <- function(pkg) {
  pkg <- as.package(pkg)
  
  deps <- parse_deps(pkg$depends)
  plyr::l_ply(deps, require, character.only = TRUE, quietly = TRUE, 
    warn.conflicts = FALSE)
  
  invisible(deps)
}

parse_deps <- function(string) {
  stringr::str_split(string, ", ")[[1]]
}
