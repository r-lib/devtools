# Run devtools-specific checks on a built package
# (Don't export for now, since we'll want to think about whether this
# should be run on package source dirs or just built tar.gz files)
# @pkg A package object
# @built_path The path to a tar.gz file of the built source package
check_devtools <- function(pkg = ".", built_path = NULL) {
  pkg <- as.package(pkg)
  message("Checking ", pkg$package, " with devtools")

  if (!is.null(built_path)) {
    check_pkg_extra_files(pkg$package, built_path)
  }
  check_dev_versions(pkg)
}


# This checks for extra files in a built package source .tar.gz file
#
# @param pkgname The name of the package
# @param built_path An R source package tar.gz file
check_pkg_extra_files <- function(pkgname, built_path) {
  message("Checking for any extra files in built .tar.gz file... ",
    appendLF = FALSE)

  # Get unique second-level paths of all files in the tar.gz file.
  # If file is "gtable/man/gtable.Rd", second-level path is "man"
  files <- untar(built_path, compressed = "gzip", list = TRUE)
  files <- sub(paste("^", pkgname, "/", sep=""), "", files)
  files <- sub("/.*$", "", files)
  files <- unique(files)

  # These are the files that are officially required in a source package,
  # according to "Writing R Extensions"
  req_files <- c("DESCRIPTION", "R", "data", "demo", "exec", "inst",
    "man", "po", "src", "tests")
  # Files that are optional in a source package, according to the doc
  opt_files <- c("INDEX", "NAMESPACE", "configure", "cleanup", "LICENSE",
    "LICENCE", "NEWS", ".Rinstignore")

  # These are other common files in a source package
  other_files <- c("", "build", "CHANGELOG", "INSTALL", "README",
    "README.md", "vignettes")

  # Now remove all the OK paths from the list; what remains are bad paths
  files <- files[!(files %in% c(req_files, opt_files, other_files))]

  if (length(files) > 0) {
    message(
      "\n  Non-standard files found:",
      "\n    ", paste(files, collapse="\n    "),
      "\n  Did you intend to include these files?",
      "\n  If yes, do nothing. If no, remove them or add them to .Rbuildignore."
    )

  } else {
    message("OK")
  }

  invisible()
}

check_dev_versions <- function(pkg = ".") {
  message("Checking for dependencies on development versions... ",
    appendLF = FALSE)

  deps <- pkg_deps(pkg, NA)
  deps <- deps[!is.na(deps$version), , drop = FALSE]

  parsed <- lapply(deps$version, function(x) unlist(numeric_version(x)))
  patch_ver <- vapply(parsed, function(x) x[[length(x)]], integer(1))

  is_dev <- patch_ver >= 9000
  if (!any(is_dev)) {
    message("OK")
    return(invisible(TRUE))
  }

  message(
    "\n  Depends on devel versions of: ",
    "\n    ", paste0(deps$name[is_dev], collapse = ", "),
    "\n  Release these packages to CRAN and bump version number.")

  return(invisible(FALSE))
}
