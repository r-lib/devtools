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
  cat_rule(paste0("Running Git checks for ", pkg$package))

  git_check_uncommitted(pkg)
  git_check_sync_status(pkg)
  cat_rule()
}

git_check_uncommitted <- function(pkg) {
  check_status(
    !git_uncommitted(pkg$path),
    "uncommitted files",
    "All files should be tracked and committed before release. Please add and commit."
  )
}

git_check_sync_status <- function(pkg) {
  check_status(
    !git_sync_status(pkg$path, check_ahead = FALSE),
    "synchronisation with remote branch",
    "Local branch should contain all commits of remote branch before release. Please pull."
  )
}
