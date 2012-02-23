.onAttach <- function(...) {
  # Assume that non-windows users have paths set correctly
  if (.Platform$OS.type != "windows") return()
  
  # Check if Rtools is already set up
  if (all(on_path("ls.exe", "gcc.exe"))) return()
  
  # Look for default installation directories
  rtools <- normalizePath("c:\\Rtools\\bin", mustWork = FALSE)
  
  if (.Platform$r_arch == "x64") {
    mingw <- normalizePath("C:\\Rtools\\MinGW64\\bin", mustWork = FALSE)    
  } else {
    mingw <- normalizePath("C:\\Rtools\\MinGW\\bin", mustWork = FALSE)
  }

  if (!file.exists(rtools)) {
    packageStartupMessage(
      "Rtools not on path and not installed in default location.")
    return()
  }

  paths <- strsplit(Sys.getenv("PATH"), ";")[[1]]
  paths <- normalizePath(paths, mustWork = FALSE)

  in_path <- any(paths == rtools)
  if (!in_path) {
    packageStartupMessage("Rtools not in path, adding automatically.")
    path <- paste(c(rtools, mingw, paths), collapse = ";")
    Sys.setenv(PATH = path)
  }
}

on_path <- function(...) {
  unname(Sys.which(c(...)) != "")
}
