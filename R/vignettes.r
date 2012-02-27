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
  
  path_vig <- file.path(pkg$path, "inst", "doc")
  if (!file.exists(path_vig)) return()
  
  in_dir(path_vig, {
    vigs <- dir(pattern = "\\.Rnw$", full.names = TRUE)
    capture.output(lapply(vigs, Sweave))
    
    tex <- dir(pattern = "\\.tex$", full.names = TRUE)
    in_dir(path_vig, lapply(tex, tools::texi2dvi, pdf = TRUE, quiet = TRUE))
  })
  
  invisible(TRUE)
}
