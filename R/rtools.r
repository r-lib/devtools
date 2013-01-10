rtools_paths <- NULL

#' Find rtools.
#'
#' To build binary packages on windows, Rtools (found at
#' \url{http://cran.r-project.org/bin/windows/Rtools/}) needs to be on
#' the path. The default installation process does not add it, so this
#' script finds it (looking first on the path, then in the registry).
#' It also checks that the version of rtools matches the version of R.
#'
#' @section Acknowledgements:
#'   This code borrows heavily from RStudio's code for finding rtools.
#'   Thanks JJ!
#' @return Invisible \code{TRUE} if rtools is found, \code{FALSE} otherwise. If
#'   rtools is found, as a side-effect it updates the internal package variable
#'   \code{rtools_path}.  If not found, an informative message will also be
#'   displayed.
#' @export
find_rtools <- function() {
  # Non-windows users don't need rtools
  if (.Platform$OS.type != "windows") return(invisible(TRUE))

  # First look in path
  from_path <- scan_path_for_rtools()
  if (is_compatible(from_path)) {
    rtools_paths <<- from_path$path
    return(invisible(TRUE))
  }

  # Then try registry
  from_registry <- scan_registry_for_rtools()
  if (!is.null(from_registry)) { # returns single compatible install
    rtools_paths <<- from_registry$path
    return(invisible(TRUE))
  }

  # Not installed
  if (is.null(from_path) && is.null(from_registry)) {
    message("Rtools not installed :(. Please install from ", rtools_url,
      " then run find_rtools()")
  } else {
    # Installed, but not compatible
    message("WARNING: Rtools version ", from_path$version, " found at ",
      from_path$path, " is not compatible with the version of R",
      " you are currently running.\n\n",
      "Please download and install the appropriate version of ",
      "Rtools from ", rtools_url, " and then run find_rtools()")
  }
  invisible(FALSE)
}

rtools <- function(path, version) {
  structure(list(version = version, path = path), class = "rtools")
}
is.rtools <- function(x) inherits(x, "rtools")

scan_path_for_rtools <- function() {
  # First look for ls.exe
  ls_path <- Sys.which("ls")
  if (ls_path == "") return(NULL)

  # We have a candidate installPath
  install_path <- dirname(dirname(ls_path))
  if (!file.exists(file.path(install_path, "Rtools.txt"))) return(NULL)

  # Find the version path
  version_path <- file.path(install_path, "VERSION.txt")
  if (!file.exists(version_path)) return(NULL)

  # Further verify that gcc is in Rtools
  gcc_path <- Sys.which("gcc")
  if (gcc_path == "") return(NULL)

  # Check that gcc and ls install paths match
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

  rtools(install_path, version)
}

scan_registry_for_rtools <- function() {
  keys <- NULL
  try(keys <- utils::readRegistry("SOFTWARE\\R-core\\Rtools",
    hive = "HLM", view = "32-bit", maxdepth = 2), silent = TRUE)
  if (is.null(keys)) return(NULL)

  for(version in names(keys)) {
    key <- keys[[version]]
    if (!is.list(key) || is.null(key$InstallPath)) next;
    install_path <- normalizePath(key$InstallPath,
      mustWork = FALSE, winslash = "/")

    rt <- rtools(version, install_path)
    if (is_compatible(rt)) rt
  }

  NULL
}

is_compatible <- function(rtools) {
  if (is.null(rtools)) return(FALSE)

  stopifnot(is.rtools(rtools))
  info <- version_info[[rtools$version]]
  if (is.null(info)) return(FALSE)

  r_version <- getRversion()
  r_version >= info$version_min && r_version <= info$version_max
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
