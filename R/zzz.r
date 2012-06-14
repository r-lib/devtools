.onAttach <- function(...) {
  # Assume that non-windows users have paths set correctly
  if (.Platform$OS.type != "windows") return()
  
  # Check if Rtools is already set up
  if (all(on_path("ls.exe", "gcc.exe"))) return()
  
  # Look for rtools
  rtools_path <- rtools()
  if (is.null(rtools_path)) return()
  
  # Look for gcc
  if (current_ver() == "2.15") {
    gcc_bin <- file.path(rtools_path, "gcc-4.6.3", "bin")
  } else {
    gcc_bin <- file.path(rtools_path, "MinGW", "bin")
    if (.Platform$r_arch == "x64") {
      gcc_bin <- c(gcc_bin, file.path(rtools_path, "MinGW64", "bin"))
    }
  }
  
  rtools_bin <- file.path(rtools_path, "bin")
  paths <- normalizePath(c(rtools_bin, gcc_bin))
  new_paths <- setdiff(paths, get_path())
  
  if (length(new_paths) == 0) return()
  
  packageStartupMessage("Rtools not in path, adding automatically.")
  add_path(new_paths)
}

rtools_url <- "http://cran.r-project.org/bin/windows/Rtools/"

rtools <- function() {
  # Look in registry
  key <- NULL
  try(key <- utils::readRegistry("SOFTWARE\\R-core\\Rtools", 
    hive = "HLM", view = "32-bit"), silent = TRUE)
    
  if (!is.null(key)) {
    version_match <- key$`Current Version` == current_ver()
    
    if (!version_match) {
      packageStartupMessage("Version of Rtools does not match R version. ", 
        "Please reinstall Rtools from ", rtools_url, ".")
      return()
    }
    
    return(key$InstallPath)
  }
  
  # Look in default location
  default_path <- normalizePath("c:\\Rtools\\bin", mustWork = FALSE)
  if (file.exists(default_path)) return(default_path)
  
  # Give up
  packageStartupMessage("Rtools not installed.  Please install from", 
    rtools_url, ".")  
  invisible(NULL)
}

current_ver <- function() {
  minor <- strsplit(version$minor, ".", fixed = TRUE)[[1]]
  paste(version$major, ".", minor[1], sep = "")
}

.onLoad <- function(libname, pkgname) {
  op <- options()
  op.devtools <- list(
    devtools.path="~/R-dev",
    github.user="hadley"
  )
  toset <- !(names(op.devtools) %in% names(op))
  if(any(toset)) options(op.devtools[toset])
}

on_path <- function(...) {
  unname(Sys.which(c(...)) != "")
}

