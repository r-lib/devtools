#' Build package vignettes.
#'
#' Sweave and latex package vignettes.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @seealso \code{\link{clean_vignettes}} to remove the pdfs in
#'   \file{inst/doc} created from vignettes
#' @export
#' @importFrom tools texi2pdf
#' @importFrom utils Sweave
#' @seealso \code{\link{clean_vignettes}} to remove build tex/pdf files.
build_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message("Building ", pkg$package, " vignettes")

  vigs <- find_vignettes(pkg)

  # First warn about vignettes in deprecated location
  if (length(vigs$doc_files) > 0) {
    files <- basename(vigs$doc_files)
    warning("The following vignettes were found (and ignored) in inst/doc: ",
      paste(files, collapse = ", "), ". Vignettes should now live in ",
      "vignettes/", call. = FALSE)
  }

  # Next, build all vignettes in /vignette
  if (length(vigs$vig_files) == 0) return()

  in_dir(vigs$vig_path, {
    capture.output(lapply(vigs$vig_files, Sweave))
    tex <- dir(pattern = "\\.tex$", full.names = FALSE)
    lapply(tex, texi2pdf, quiet = TRUE, clean = TRUE)

    pdfs <- dir(pattern = "\\.pdf$")
    message("Moving ", paste(pdfs, collapse = ", "), " to inst/doc/")
    file.rename(pdfs, file.path(vigs$doc_path, pdfs))
  })

  invisible(TRUE)
}

#' Clean built vignettes.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param tex if \code{TRUE} also removes the tex file created by Sweave.
#' @export
clean_vignettes <- function(pkg = ".", tex = TRUE) {
  pkg <- as.package(pkg)
  message("Cleaning built vignettes from ", pkg$package)

  vigs <- find_vignettes(pkg)

  pdfs <- ext_variations(vigs$vig_files, "pdf")
  candidates <- file.path(vigs$doc_path, pdfs)

  if (tex) {
    build_artefacts <- ext_variations(vigs$vig_files, "tex")
    candidates <- c(candidates, file.path(vigs$vig_path, build_artefacts))
  }

  to_remove <- candidates[file.exists(candidates)]

  if (length(to_remove) > 0) {
    message("Removing ", paste(basename(to_remove), collapse = ", "))
    file.remove(to_remove)
  }

  invisible(TRUE)
}

ext_variations <- function(path, valid_ext) {
  c(outer(file_name(path), valid_ext, FUN = paste, sep = "."))
}

#' @importFrom tools file_path_sans_ext
file_name <- function(x) {
  if (length(x) == 0) return(NULL)
  file_path_sans_ext(basename(x))
}

find_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  vig_match <- "\\.(Rnw|Snw|Rtex|Stex)$"

  doc_path <- file.path(pkg$path, "inst", "doc")
  doc_files <- dir(doc_path, vig_match, full.names = TRUE)
  names(doc_files) <- basename(doc_files)

  vig_path <- file.path(pkg$path, "vignettes")
  vig_files <- dir(vig_path, vig_match, full.names = TRUE)
  names(vig_files) <- basename(vig_files)

  list(
    doc_path = doc_path, doc_files = doc_files,
    vig_path = vig_path, vig_files = vig_files
  )
}
