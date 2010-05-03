load_code <- function(pkg, env = pkg_env(pkg)) {
  pkg <- as.package(pkg)
  path_r <- file.path(pkg$path, "R")

  if (is.null(pkg$collate)) {
    paths <- find_code(path_r)
  } else {
    paths <- file.path(path_r, parse_collate(pkg$collate))
  }
  paths <- changed_files(paths)

  plyr::l_ply(paths, sys.source, envir = env, chdir = TRUE)
  
  # Load .onLoad if it's defined
  if (exists(".onLoad", env) && !exists("__loaded", env)) {
    env$.onLoad()
    env$`__loaded` <- TRUE
  }
  
  invisible(paths)
}


parse_collate <- function(string) {
  con <- textConnection(string)
  on.exit(close(con))
  scan(con, "character", sep = " ", quiet = TRUE)
}

find_code <- function(path) {
  code_paths <- dir(path, "\\.[Rr]$", full = TRUE)  
  with_locale("C", sort(code_paths))
}

