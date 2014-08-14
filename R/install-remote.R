#' Install a remote package.
#'
#' This:
#' \enumerate{
#'   \item downloads source bundle
#'   \item decompresses & checks that it's a package
#'   \item adds metadata to DESCRIPTION
#'   \item calls install
#' }
#' @noRd
install_remote <- function(remote, ..., quiet = FALSE) {
  bundle <- tempfile(fileext = paste0(".", remote$type))
  if (!quiet) {
    message(pkg$message)
  }
  download(bundle, remote$url, remote$config)
  on.exit(unlink(bundle), add = TRUE)

  pkg_path <- source_pkg(bundle, subdir = remote$meta$subdir)
  on.exit(unlink(pkg_path, recursive = TRUE), add = TRUE)

  meta <- remote$meta
  names(meta) <- paste0("Github", first_upper(names(meta)))
  add_metadata(pkg_path, meta)

  install(pkg_path, ..., quiet = quiet)
}

# Add metadata
add_metadata <- function(pkg_path, meta) {
  path <- file.path(pkg_path, "DESCRIPTION")
  desc <- read_dcf(path)

  desc <- modifyList(desc, meta)

  write_dcf(path, desc)
}
