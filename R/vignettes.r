#' Build package vignettes.
#'
#' Builds package vignettes using the same algorithm that \code{R CMD build}
#' does. This means includes non-Sweave vignettes, using make  files (if
#' present), and copying over extra files. You need to ensure that these
#' files are not included in the built package - ideally they should not
#' be checked into source, or at least excluded with \code{.Rbuildignore}
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @seealso \code{\link{clean_vignettes}} to remove the pdfs in
#'   \file{inst/doc} created from vignettes
#' @export
#' @seealso \code{\link{clean_vignettes}} to remove build tex/pdf files.
build_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  vigns <- tools::pkgVignettes(dir = pkg$path)
  if (length(vigns$doc) == 0) return()

  message("Building ", pkg$package, " vignettes")
  tools::buildVignettes(dir = pkg$path, tangle = TRUE)
  copy_vignettes(pkg)

  invisible(TRUE)
}

#' Clean built vignettes.
#'
#' This uses a fairly rudimentary algorithm where any files in \file{inst/doc}
#' with a name that exists in \file{vignettes} are removed.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
clean_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  vigns <- tools::pkgVignettes(dir = pkg$path)
  if (basename(vigns$dir) != "vignettes") return()

  message("Cleaning built vignettes from ", pkg$package)

  doc_path <- file.path(pkg$path, "inst", "doc")

  vig_candidates <- dir(doc_path, full.names = TRUE)
  vig_rm <- vig_candidates[file_name(vig_candidates) %in% file_name(vigns$docs)]

  extra_candidates <- file.path(doc_path, basename(find_vignette_extras(pkg)))
  extra_rm <- extra_candidates[file.exists(extra_candidates)]

  to_remove <- c(vig_rm, extra_rm)
  if (length(to_remove) > 0) {
    message("Removing ", paste(basename(to_remove), collapse = ", "))
    file.remove(to_remove)
  }

  invisible(TRUE)
}

ext_variations <- function(path, valid_ext) {
  unique(c(outer(file_name(path), valid_ext, FUN = paste, sep = ".")))
}

file_name <- function(x) {
  if (length(x) == 0) return(NULL)
  tools::file_path_sans_ext(basename(x))
}
