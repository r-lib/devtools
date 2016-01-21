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
  stopifnot(is.remote(remote))

  bundle <- remote_download(remote, quiet = quiet)
  on.exit(unlink(bundle), add = TRUE)

  source <- source_pkg(bundle, subdir = remote$subdir)
  on.exit(unlink(source, recursive = TRUE), add = TRUE)

  add_metadata(source, remote_metadata(remote, bundle, source))

  # Because we've modified DESCRIPTION, its original MD5 value is wrong
  clear_description_md5(source)

  install(source, ..., quiet = quiet)
}

install_remotes <- function(remotes, ...) {
  invisible(vapply(remotes, install_remote, ..., FUN.VALUE = logical(1)))
}

# Add metadata
add_metadata <- function(pkg_path, meta) {
  path <- file.path(pkg_path, "DESCRIPTION")
  desc <- read_dcf(path)

  desc <- modifyList(desc, meta)

  write_dcf(path, desc)
}

# Modify the MD5 file - remove the line for DESCRIPTION
clear_description_md5 <- function(pkg_path) {
  path <- file.path(pkg_path, "MD5")

  if (file.exists(path)) {
    text <- readLines(path)
    text <- text[!grepl(".*\\*DESCRIPTION$", text)]

    writeLines(text, path)
  }
}

remote <- function(type, ...) {
  structure(list(...), class = c(paste0(type, "_remote"), "remote"))
}
is.remote <- function(x) inherits(x, "remote")

different_sha <- function(remote = NULL,
                          remote_sha = NULL,
                          local_sha = NULL) {
  if (is.null(remote_sha)) {
    remote_sha <- remote_sha(remote)
  }

  if (is.null(local_sha)) {
    local_sha <- local_sha(remote_package_name(remote))
  }

  different <- isTRUE(remote_sha != local_sha)
  different <- different || is.na(different)
  if (!different) {
     message(
       "Skipping install for ", sub("_remote", "", class(remote)[1L]), " remote,",
       " the SHA1 has not changed since last install.\n",
       "  Use `force = TRUE` to force installation")
  }
  different
}

local_sha <- function(name) {
  if (!is_installed(name)) {
    return(NA)
  }
  packageDescription(name)$RemoteSha
}

remote_download <- function(x, quiet = FALSE) UseMethod("remote_download")
remote_metadata <- function(x, bundle = NULL, source = NULL) UseMethod("remote_metadata")
remote_package_name <- function(remote, ...) UseMethod("remote_package_name")
remote_sha <- function(remote, ...) UseMethod("remote_sha")
