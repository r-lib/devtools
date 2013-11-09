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

  if (!file.info(path)$isdir) {
    bundle <- path
    outdir <- tempfile(pattern = "devtools")
    dir.create(outdir)
    on.exit(unlink(outdir, recursive = TRUE), add = TRUE)

    path <- decompress(path, outdir)
  } else {
    bundle <- NULL
  }

  pkg_path <- if (is.null(subdir)) path else file.path(path, subdir)

  # Check it's an R package
  if (!file.exists(file.path(pkg_path, "DESCRIPTION"))) {
    stop("Does not appear to be an R package (no DESCRIPTION)", call. = FALSE)
  }

  # Check configure is executable if present
  config_path <- file.path(pkg_path, "configure")
  if (file.exists(config_path)) {
    Sys.chmod(config_path, "777")
  }
  
  # Call before_install for bundles (if provided)
  if (!is.null(bundle) && !is.null(before_install))
    before_install(bundle, pkg_path)

  # Finally, run install
  install(pkg_path, quiet = quiet, ...)
}
