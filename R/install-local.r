#' Install a package from a local file
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param path path to local directory, or compressed file (tar, zip, tar.gz
#'   tar.bz2, tgz2 or tbz)
#' @inheritParams install_url
#' @export
#' @examples
#' \dontrun{
#' dir <- tempfile()
#' dir.create(dir)
#' pkg <- download.packages("testthat", dir)
#' install_local(pkg[, 2])
#' }
install_local <- function(path, subdir = NULL, ...) {
  invisible(lapply(path, install_local_single, subdir = subdir, ...))
}

install_local_single <- function(path, subdir = NULL, before_install = NULL, ..., quiet = FALSE) {
  stopifnot(file.exists(path))
  if (!quiet) {
    message("Installing package from ", path)
  }

  pkg_path <- source_pkg(path, subdir = subdir, before_install = before_install)
  on.exit(unlink(outdir, recursive = TRUE), add = TRUE)

  # Finally, run install
  install(pkg_path, quiet = quiet, ...)
}
