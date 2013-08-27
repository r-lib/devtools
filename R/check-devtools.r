# Run devtools-specific checks on a built package
# (Don't export for now, since we'll want to think about whether this
# should be run on package source dirs or just built tar.gz files)
# @pkg A package object
# @built_path The path to a tar.gz file of the built source package
check_devtools <- function(pkg = ".", built_path) {
  pkg <- as.package(pkg)
  message("Checking ", pkg$package, " with devtools")

  check_pkg_extra_files(pkg$package, built_path)
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
    message("\n  Non-standard files found:\n    ",
      paste(files, collapse="\n    "),
      "\n  Did you intend to include these files?",
      "\n  If yes, do nothing. If no, remove them or add them to .Rbuildignore.\n")

  } else {
    message("OK")
  }

  invisible()
}
