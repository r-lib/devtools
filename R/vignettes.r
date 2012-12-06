#' Build package vignettes.
#'
#' Sweave and latex package vignettes.  Sweaving and latexing is carried
#' out in a temporary directory so that compilation artefacts don't pollute
#' the source package - only the final pdf is copied to \file{inst/doc}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @seealso \code{\link{clean_vignettes}} to remove the pdfs in
#'   \file{inst/doc} created from vignettes
#' @export
build_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message("Building ", pkg$package, " vignettes")

  vigs <- find_vignettes(pkg)

  # First warn about vignettes in deprecated location
  if (length(vigs$doc_files) > 0) {
    files <- basename(vigs$doc_files)
    warning("The following vignettes were found (and ignored) in inst/doc:",
      paste(files, collapse = ", "), ". Vignettes should now live in ",
      "vignettes/")
  }

  # Next, build all vignettes in /vignette
  if (length(vigs$vig_files) == 0) return()

  # Set up temporary build location
  temp <- tempfile()
  dir.create(temp)
  dir.create(vigs$doc_path, recursive = TRUE, showWarnings = FALSE)
  on.exit(unlink(temp, recursive = TRUE))

  in_dir(temp, {
    capture.output(lapply(vigs$vig_files, Sweave))
    tex <- dir(pattern = "\\.tex$", full.names = FALSE)
    lapply(tex, tools::texi2dvi, pdf = TRUE, quiet = TRUE)

    pdfs <- dir(temp, "\\.pdf$")
    message("Copying ", paste(pdfs, collapse = ", "), " to inst/doc/")
    file.copy(pdfs, vigs$doc_path)
  })

  invisible(TRUE)
}

#' Clean built vignettes.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
clean_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message("Cleaning built vignettes from ", pkg$package)

  vigs <- find_vignettes(pkg)
  pdfs <- dir(vigs$doc_path, "\\.pdf$", full.names = TRUE)

  to_remove <- file_name(pdfs) %in% file_name(vigs$vig_files)
  if (any(to_remove)) {
    message("Removing ", paste(basename(pdfs[to_remove]), collapse = ", "))
    file.remove(pdfs[to_remove])
  }

  invisible(TRUE)
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
