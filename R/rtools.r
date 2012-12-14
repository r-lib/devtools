
scan_path_for_rtools <- function() {
  # First confirm ls.exe is in Rtools
  ls_path <- Sys.which("ls.exe")
  if (ls_path == "") return(NULL)

  # We have a candidate installPath
  install_path <- dirname(dirname(ls_path))
  if (!file.exists(file.path(install_path, "Rtools.txt"))) return(NULL)

  # Find the version path
  version_path <- file.path(install_path, "VERSION.txt")
  if (!file.exists(version_path)) return(NULL)

  # Further verify that gcc is in Rtools
  gcc_path <- Sys.which("gcc.exe")
  if (gcc_path == "") return(NULL)

  install_path2 <- dirname(dirname(dirname(gcc_path)))
  if (install_path2 != install_path) return(NULL)

  # Rtools is in the path -- now crack the VERSION file
  contents <- NULL
  try(contents <- readLines(version_path), silent = TRUE)
  if (is.null(contents)) return(NULL)

  # Extract the version
  contents <- gsub("^\\s+|\\s+$", "", contents)
  version_re <- "Rtools version (\\d\\.\\d\\d)[0-9.]+$"

  if (!grepl(version_re, contents)) return(NULL)

  m <- regexec(version_re, contents)
  version <- regmatches(contents, m)[[1]][2]

  rtools_info(version, install_path)
}

scan_registry_for_rtools <- function() {
  # Look in registry
  keys <- NULL
  try(keys <- utils::readRegistry("SOFTWARE\\R-core\\Rtools",
    hive = "HLM", view = "32-bit", maxdepth = 2), silent = TRUE)
  if (is.null(keys)) return(NULL)

  for(version in names(keys)) {
    key <- keys[[version]]
    if (!is.list(key) || is.null(key$InstallPath)) next;
    install_path <- normalizePath(key$InstallPath,
      mustWork = FALSE, winslash = "/")

    ok <- rtools_ok(version, install_path)
    if (ok) return(rtools_info(version, install_path))
  }

  NULL
}

rtools_ok <- function(version, install_path) {
  if (!file.exists(install_path)) return(FALSE)

  info <- version_info[[version]]
  if (is.null(info)) return(FALSE)

  r_version <- getRversion()
  r_version >= info$version_min && r_version <= info$version_max
}

rtools_info <- function(version, install_path) {
  # Check version corresponds to known version
  info <- version_info[[version]]
  if (is.null(info)) {
    return(NULL)
  }

  # Check R version matches R tools version
  r_version <- getRversion()
  if (r_version < info$version_min || r_version > info$version_max) {
    packageStartupMessage(paste("WARNING: Rtools version ", version,
      " found at ", install_path, "is not compatible with the version of R",
      " you are currently running.\n\n",
      "Please download and install the appropriate version of ",
      "Rtools from ", rtools_url, sep = ""))
    return(NULL)
  }

  file.path(install_path, info$path)
}

# Rtools metadata --------------------------------------------------------------
rtools_url <- "http://cran.r-project.org/bin/windows/Rtools/"
version_info <- list(
  "2.11" = list(
    version_min = "2.10.0",
    version_max = "2.11.1",
    path = c("bin", "perl/bin", "MinGW/bin")
  ),
  "2.12" = list(
    version_min = "2.12.0",
    version_max = "2.12.2",
    path = c("bin", "perl/bin", "MinGW/bin", "MinGW64/bin")
  ),
  "2.13" = list(
    version_min = "2.13.0",
    version_max = "2.13.2",
    path = c("bin", "MinGW/bin", "MinGW64/bin")
  ),
  "2.14" = list(
    version_min = "2.13.0",
    version_max = "2.14.2",
    path = c("bin", "MinGW/bin", "MinGW64/bin")
  ),
  "2.15" = list(
    version_min = "2.14.2",
    version_max = "2.15.1",
    path = c("bin", "gcc-4.6.3/bin")
  ),
  "2.16" = list(
    version_min = "2.15.2",
    version_max = "2.16.2",
    path = c("bin", "gcc-4.6.3/bin")
  )
)
