#' Build package vignettes.
#'
#' Sweave and latex package vignettes.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
build_vignettes <- function(pkg = NULL) {
  
  pkg <- as.package(pkg)
  message("Building ", pkg$package, " vignettes")
  vig_pat <- "\\.(Rnw|Snw|Rtex|Stex)$"
  
  ## look in vignettes and in deprecated inst/doc
  path_vig <- file.path(pkg$path, "vignettes")
  old_path_vig <- file.path(pkg$path, "inst", "doc")

  ## list files in both directories
  vigs <- dir(pattern = vig_pat, path = path_vig, full.names = FALSE)
  old_vigs <- dir(pattern = vig_pat, path = old_path_vig, full.names = FALSE)

  ## if nothing, exit
  if (!length(vigs) && !length(old_vigs)) return()

  ## check for identical names in both directories
  duplicates <- intersect(vigs, old_vigs)
  if(length(duplicates)){
    warning("The following duplicates were ignored in inst/doc/: ", paste(duplicates, collapse=" "))
    old_vigs <- setdiff(old_vigs, duplicates)
  }
  ## process vignettes
  if(length(vigs)){
    in_dir(path_vig, {
      capture.output(lapply(vigs, Sweave))
      tex <- dir(pattern = "\\.tex$", full.names = FALSE)
      lapply(tex, tools::texi2dvi, pdf = TRUE, quiet = TRUE)
    })
  }
  
  ## process inst/doc
  if(length(old_vigs)){
    in_dir(old_path_vig, {
      capture.output(lapply(old_vigs, Sweave))
      tex <- dir(pattern = "\\.tex$", full.names = FALSE)
      lapply(tex, tools::texi2dvi, pdf = TRUE, quiet = TRUE)
    })
  }
    
  invisible(TRUE)
}
