#' Git checks.
#'
#' This function performs Git checks checks prior to release. It is called
#' automatically by \code{\link{release}()}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information.
#' @keywords internal
git_checks <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message("Running Git checks for ", pkg$package)

  check_uncommitted(pkg)
  check_sync_status(pkg)
}

check_uncommitted <- function(pkg) {
  check_status(!git_uncommitted(pkg$path),
               "uncommitted files",
               "All files should be committed before release. Please add and commit."
  )
}

check_sync_status <- function(pkg) {
  check_status(!git_sync_status(pkg$path, check_ahead = FALSE),
               "if synched with remote branch",
               "Local branch should contain all commits of remote branch before release. Please pull."
  )
}
