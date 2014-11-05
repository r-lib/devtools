# Run devtools-specific checks on a built package
# (Don't export for now, since we'll want to think about whether this
# should be run on package source dirs or just built tar.gz files)
# @pkg A package object
# @built_path The path to a tar.gz file of the built source package
check_devtools <- function(pkg = ".", built_path = NULL) {
  pkg <- as.package(pkg)
  message("Running additional devtools checks for ", pkg$package)

  check_dev_versions(pkg)
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
