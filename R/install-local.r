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

install_local_single <- function(path, subdir = NULL, ..., quiet = FALSE) {
  stopifnot(file.exists(path))
  if (!quiet) {
    message("Installing package from ", path)
  }

  if (!file.info(path)$isdir) {
    path <- decompress(path)
    on.exit(unlink(path), add = TRUE)
  }

  if (is.null(subdir))
    subdir <- '.'

  description_file <- list.files(path = file.path(path, subdir),
                                 pattern = '^DESCRIPTION$',
                                 full.names = TRUE)

  if (length(description_file) == 0) {
    stop("Does not appear to be an R package (no DESCRIPTION)", call. = FALSE)
  }
  if (length(description_file) > 1) {
    warning(sprintf("Multiple DESCRIPTION files found in: %s. Using first",
                    paste(subdir, collapse=", ")))
    description_file <- description_file[1]
  }

  pkg_path <- dirname(description_file)

  # Double-check
  stopifnot(file.exists(file.path(pkg_path, "DESCRIPTION")))

  # Check configure is executable if present
  config_path <- file.path(pkg_path, "configure")
  if (file.exists(config_path)) {
    Sys.chmod(config_path, "777")
  }

  # Finally, run install
  install(pkg_path, local = TRUE, quiet = quiet, ...)
}
