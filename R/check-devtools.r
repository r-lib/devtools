#' Custom devtools release checks.
#'
#' This function performs additional checks prior to release. It is called
#' automatically by \code{\link{release}()}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information.
#' @keywords internal
#' @export
release_checks <- function(pkg = ".", built_path = NULL) {
  pkg <- as.package(pkg)
  message("Running additional devtools checks for ", pkg$package)

  check_version(pkg)
  check_dev_versions(pkg)
  check_vignette_titles(pkg)
  check_news_md(pkg)
}

check_dev_versions <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message("Checking for dependencies on development versions... ",
    appendLF = FALSE)

  dep_list <- pkg[tolower(standardise_dep(TRUE))]
  deps <- do.call("rbind", unname(compact(lapply(dep_list, parse_deps))))
  deps <- deps[!is.na(deps$version), , drop = FALSE]

  parsed <- lapply(deps$version, function(x) unlist(numeric_version(x)))

  lengths <- vapply(parsed, length, integer(1))
  last_ver <- vapply(parsed, function(x) x[[length(x)]], integer(1))

  is_dev <- lengths == 4 & last_ver >= 9000
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
    "\n  Version (", pkg$version, ") should have exactly three components"
  )

  return(invisible(FALSE))

}

check_vignette_titles <- function(pkg = ".") {
  pkg <- as.package(pkg)

  vigns <- tools::pkgVignettes(dir = pkg$path)
  if (length(vigns$docs) == 0) return()

  message("Checking vignette titles... ", appendLF = FALSE)
  has_Vignette_Title <- function(v, n) {
    h <- readLines(v, n = n)
    any(grepl("Vignette Title", h))
  }
  v <- stats::setNames(vigns$docs, basename(vigns$docs))
  has_VT <- vapply(v, has_Vignette_Title, logical(1), n = 30)

  if (!any(has_VT)) {
    message("OK")
    return(invisible(TRUE))
  }

  message(
    "WARNING",
    "\n  placeholder 'Vignette Title' detected in 'title' field and/or ",
    "\n  'VignetteIndexEntry' for these vignettes:\n",
    paste(" ", names(has_VT)[has_VT], collapse = "\n")
  )

  return(invisible(FALSE))

}

check_news_md <- function(pkg) {
  pkg <- as.package(pkg)

  news_path <- file.path(pkg$path, "NEWS.md")
  if (!file.exists(news_path))
    return()

  message("Checking that NEWS.md is not ignored... ", appendLF = FALSE)

  ignore_path <- file.path(pkg$path, ".Rbuildignore")
  if (!file.exists(ignore_path)) {
    ignore_lines <- character()
  } else {
    ignore_lines <- readLines(ignore_path)
  }

  has_news <- grepl("NEWS\\.md", ignore_lines, fixed = TRUE) |
              grepl("NEWS.md", ignore_lines, fixed = TRUE)

  if (!any(has_news)) {
    message("OK")
    return(invisible(TRUE))
  }

  message(
    "WARNING",
    "\n  NEWS.md is in .Rbuildignore. It is now supported by CRAN ",
    "\n  so can be included in the package."
  )

  return(invisible(FALSE))

}
