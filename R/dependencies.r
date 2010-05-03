load_deps <- function(pkg) {
  pkg <- as.package(pkg)
  
  deps <- parse_deps(pkg$depends)
  plyr::l_ply(deps, require, character.only = TRUE, quietly = TRUE, 
    warn.conflicts = FALSE)
  
  invisible(deps)
}

parse_deps <- function(string) {
  library(stringr)
  
  # Remove version specifications
  string <- str_replace(string, "\\s*\\(.*?\\)", "")
  
  # Split into pieces and remove R dependency
  pieces <- str_split(string, ", ")[[1]]
  pieces[pieces != "R"]
}
