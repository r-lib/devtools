#' Custom devtools release checks.
#'
#' This function performs additional checks prior to release. It is called
#' automatically by \code{\link{release}()}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information. If the \code{DESCRIPTION}
#'   file does not exist, it is created using \code{\link{create_description}}.
#' @keywords internal
#' @export
release_checks <- function(pkg = ".", built_path = NULL) {
  pkg <- as.package(pkg)
  message("Running additional devtools checks for ", pkg$package)

  check_version(pkg)
  check_dev_versions(pkg)
}

check_dev_versions <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message("Checking for dependencies on development versions... ",
    appendLF = FALSE)

  deps <- package_deps(pkg$package, NA)
  deps <- deps[!is.na(deps$installed), , drop = FALSE]

  parsed <- lapply(deps$installed, function(x) unlist(numeric_version(x)))

  lengths <- vapply(parsed, length, integer(1))
  last_ver <- vapply(parsed, function(x) x[[length(x)]], integer(1))

  is_dev <- lengths == 4 && last_ver >= 9000
  if (!any(is_dev)) {
    message("OK")
    return(invisible(TRUE))
  }

  message(
    "WARNING",
    "\n  Depends on devel versions of: ",
    "\n    ", paste0(deps$name[is_dev], collapse = ", "),
    "\n  Release these packages to CRAN and bump version number.")

  return(invisible(FALSE))
}

check_version <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message("Checking version number... ",
    appendLF = FALSE)

  ver <- unlist(numeric_version(pkg$version))
  if (length(ver) == 3) {
    message("OK")
    return(invisible(TRUE))
  }
  message(
    "WARNING",
    "\n  Version number should have exactly three components"
  )

  return(invisible(FALSE))

}
