#' Git checks.
#'
#' This function performs Git checks checks prior to release. It is called
#' automatically by [release()].
#'
#' @template devtools
#' @keywords internal
git_checks <- function(pkg = ".") {
  pkg <- as.package(pkg)
  cli::cat_rule(paste0("Running Git checks for ", pkg$package))

  git_report_branch(pkg)
  git_check_uncommitted(pkg)
  cli::cat_rule()
}

git_report_branch <- function(pkg) {
  cat("Current branch:", git_branch(pkg$path), "\n")
}

git_check_uncommitted <- function(pkg) {
  check_status(
    !git_uncommitted(pkg$path),
    "uncommitted files",
    "All files should be tracked and committed before release. Please add and commit."
  )
}
