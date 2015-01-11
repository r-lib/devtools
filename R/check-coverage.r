#' Check test coverage for a package.
#'
#' This function runs \code{\link[covr]{package_coverage}} to track and
#' calculate test coverage for a package.
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information
#' @param ... additional arguments passed to \code{\link[covr]{package_coverage}}
#' @seealso \code{\link[covr]{package_coverage}}
#' @export
check_coverage <- function(pkg = ".", ...) {
  check_covr()
  pkg <- as.package(pkg)

  covr::package_coverage(pkg$path, ...)
}

check_covr <- function() {
  if (!requireNamespace("covr", quietly = TRUE)) {
    stop("Please install covr", call. = FALSE)
  }
}
