load_code <- function(pkg, env = pkg_env(pkg)) {
  pkg <- as.package(pkg)
  path_r <- file.path(pkg$path, "R")

  if (is.null(pkg$collate)) {
    paths <- find_code(path_r)
  } else {
    paths <- file.path(path_r, parse_collate(pkg$collate))
  }

  plyr::l_ply(paths, sys.source, envir = env, chdir = TRUE)
  invisible(paths)
}


parse_collate <- function(string) {
  gsub("^'|'$", "", strsplit(string, "'\\s'")[[1]])
}

find_code <- function(path) {
  code_paths <- dir(path, "\\.[Rr]$", full = TRUE)  
  with_locale("C", sort(code_paths))
}

