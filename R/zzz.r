.onLoad <- function(...) {
  if (!os() == "win") return()
  
  rtools <- normalizePath("c:\\Rtools\\bin", mustWork = FALSE)
  if (!file.exists(rtools)) {
    message("Rtools not installed.")
    return()
  }

  paths <- strsplit(Sys.getenv("PATH"), ";")[[1]]
  paths <- normalizePath(paths, mustWork = FALSE)

  in_path <- any(paths == rtools)
  if (!in_path) {
    message("Rtools not in path, adding automatically.")
    path <- paste(c(rtools, paths), collapse = ";")
    Sys.setenv(PATH = path)
  }
}