# Need to check for existence so load_all doesn't override known rtools location
if (!exists("set_rtools_path")) {
  set_rtools_path <- NULL
  get_rtools_path <- NULL
  local({
    rtools_paths <- NULL
    set_rtools_path <<- function(rtools) {
      stopifnot(is.rtools(rtools))
      path <- file.path(rtools$path, version_info[[rtools$version]]$path)

      rtools_paths <<- path
    }
    get_rtools_path <<- function() {
      rtools_paths
    }
  })
}

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
#' @param debug if \code{TRUE} prints a lot of additional information to
#'   help in debugging.
#' @return Either a visible \code{TRUE} if rtools is found, or an invisible
#'   \code{FALSE} with a diagnostic \code{\link{message}}.
#'   As a side-effect the internal package variable \code{rtools_path} is
#'   updated to the paths to rtools binaries.
#' @export
find_rtools <- function(debug = FALSE) {
  # Non-windows users don't need rtools
  if (.Platform$OS.type != "windows") return(TRUE)

  # First try the path
  from_path <- scan_path_for_rtools(debug)
  if (is_compatible(from_path)) {
    set_rtools_path(from_path)
    return(TRUE)
  }

  if (!is.null(from_path)) {
    # Installed
    if (is.null(from_path$version)) {
      # but not from rtools
      if (debug) "gcc and ls on path, assuming set up is correct\n"
      return(TRUE)
    } else {
    # Installed, but not compatible
      message("WARNING: Rtools ", from_path$version, " found on the path",
        " at ", from_path$path, " is not compatible with R ", getRversion(), ".\n\n",
        "Please download and install ", rtools_needed(), " from ", rtools_url,
        ", remove the incompatible version from your PATH, then run find_rtools().")
      return(invisible(FALSE))
    }
  }

  # Not on path, so try registry
  registry_candidates <- scan_registry_for_rtools(debug)

  if (length(registry_candidates) == 0) {
    # Not on path or in registry, so not installled
    message("WARNING: Rtools is required to build R packages, but is not ",
      "currently installed.\n\n",
      "Please download and install ", rtools_needed(), " from ", rtools_url,
      " and then run find_rtools().")
    return(invisible(FALSE))
  }

  from_registry <- Find(is_compatible, registry_candidates)
  if (is.null(from_registry)) {
    # In registry, but not compatible.
    versions <- vapply(registry_candidates, function(x) x$version, character(1))
    message("WARNING: Rtools is required to build R packages, but no version ",
      "of Rtools compatible with R ", getRversion(), " was found. ",
      "(Only the following incompatible version(s) of Rtools were found:",
      paste(versions, collapse = ","), ")\n\n",
      "Please download and install ", rtools_needed(), " from ", rtools_url,
      " and then run find_rtools().")
    return(invisible(FALSE))
  }

  installed_ver <- installed_version(from_registry$path, debug = debug)
  if (is.null(installed_ver)) {
    # Previously installed version now deleted
    message("WARNING: Rtools is required to build R packages, but the ",
      "version of Rtools previously installed in ", from_registry$path,
      " has been deleted.\n\n",
      "Please download and install ", rtools_needed(), " from ", rtools_url,
      " and then run find_rtools().")
    return(invisible(FALSE))
  }

  if (installed_ver != from_registry$version) {
    # Installed version doesn't match registry version
    message("WARNING: Rtools is required to build R packages, but no version ",
      "of Rtools compatible with R ", getRversion(), " was found. ",
      "Rtools ", from_registry$version, " was previously installed in ",
      from_registry$path, " but now that directory contains Rtools ",
      installed_ver, ".\n\n",
      "Please download and install ", rtools_needed(), " from ", rtools_url,
      " and then run find_rtools().")
    return(invisible(FALSE))
  }

  # Otherwise it must be ok :)
  set_rtools_path(from_registry)
  TRUE
}

scan_path_for_rtools <- function(debug = FALSE) {
  if (debug) cat("Scanning path...\n")

  # First look for ls and gcc
  ls_path <- Sys.which("ls")
  if (ls_path == "") return(NULL)
  if (debug) cat("ls :", ls_path, "\n")

  gcc_path <- Sys.which("gcc")
  if (gcc_path == "") return(NULL)
  if (debug) cat("gcc:", gcc_path, "\n")

  # We have a candidate installPath
  install_path <- dirname(dirname(ls_path))
  install_path2 <- dirname(dirname(dirname(gcc_path)))
  if (install_path2 != install_path) return(NULL)

  version <- installed_version(install_path, debug = debug)
  if (debug) cat("Version:", version, "\n")

  rtools(install_path, version)
}

scan_registry_for_rtools <- function(debug = FALSE) {
  if (debug) cat("Scanning registry...\n")

  keys <- NULL
  try(keys <- utils::readRegistry("SOFTWARE\\R-core\\Rtools",
    hive = "HLM", view = "32-bit", maxdepth = 2), silent = TRUE)
  if (is.null(keys)) return(NULL)

  rts <- vector("list", length(keys))

  for(i in seq_along(keys)) {
    version <- names(keys)[[i]]
    key <- keys[[version]]
    if (!is.list(key) || is.null(key$InstallPath)) next;
    install_path <- normalizePath(key$InstallPath,
      mustWork = FALSE, winslash = "/")

    if (debug) cat("Found", install_path, "for", version, "\n")
    rts[[i]] <- rtools(install_path, version)
  }

  Filter(Negate(is.null), rts)
}

installed_version <- function(path, debug) {
  if (!file.exists(file.path(path, "Rtools.txt"))) return(NULL)

  # Find the version path
  version_path <- file.path(path, "VERSION.txt")
  if (debug) {
    cat("VERSION.txt\n")
    cat(readLines(version_path), "\n")
  }
  if (!file.exists(version_path)) return(NULL)

  # Rtools is in the path -- now crack the VERSION file
  contents <- NULL
  try(contents <- readLines(version_path), silent = TRUE)
  if (is.null(contents)) return(NULL)

  # Extract the version
  contents <- gsub("^\\s+|\\s+$", "", contents)
  version_re <- "Rtools version (\\d\\.\\d\\d)[0-9.]+$"

  if (!grepl(version_re, contents)) return(NULL)

  m <- regexec(version_re, contents)
  regmatches(contents, m)[[1]][2]
}

is_compatible <- function(rtools) {
  if (is.null(rtools)) return(FALSE)
  if (is.null(rtools$version)) return(FALSE)

  stopifnot(is.rtools(rtools))
  info <- version_info[[rtools$version]]
  if (is.null(info)) return(FALSE)

  r_version <- getRversion()
  r_version >= info$version_min && r_version <= info$version_max
}

rtools <- function(path, version) {
  structure(list(version = version, path = path), class = "rtools")
}
is.rtools <- function(x) inherits(x, "rtools")

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
    version_max = "3.0.0",
    path = c("bin", "gcc-4.6.3/bin")
  ),
  "3.0" = list(
    version_min = "2.15.2",
    version_max = "3.0.0",
    path = c("bin", "gcc-4.6.3/bin")
  )
)

rtools_needed <- function() {
  r_version <- getRversion()

  for(i in rev(seq_along(version_info))) {
    version <- names(version_info)[i]
    info <- version_info[[i]]
    ok <- r_version >= info$version_min && r_version <= info$version_max
    if (ok) return(paste("Rtools", version))
  }
  "the appropriate version of Rtools"
}
