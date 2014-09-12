#' Find missing s3 exports.
#'
#' The method is heuristic - looking for objs with a period in their name.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
missing_s3 <- function(pkg = ".") {
  if (!requireNamespace("roxygen2", quietly = TRUE)) {
    stop("Please install roxygen2.", call. = FALSE)
  }
  pkg <- as.package(pkg)
  loaded <- load_all(pkg)

  # Find all S3 methods in package
  objs <- ls(envir = loaded$env)
  is_s3 <- function(x) roxygen2::is_s3_method(x, envir = loaded$env)
  s3_objs <- Filter(is_s3, objs)

  # Find all S3 methods in NAMESPACE
  ns <- parse_ns_file(pkg)
  exports <- paste(ns$S3methods[, 1], ns$S3methods[, 2], sep = ".")

  setdiff(s3_objs, exports)
}
