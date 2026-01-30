#' Find missing s3 exports
#'
#' The method is heuristic - looking for objs with a period in their name.
#'
#' @template devtools
#' @export
missing_s3 <- function(pkg = ".") {
  pkg <- as.package(pkg)
  loaded <- load_all(pkg$path)

  # Find all S3 methods in package
  objs <- ls(envir = loaded$env)
  is_s3 <- function(x) roxygen2::is_s3_method(x, env = loaded$env)
  s3_objs <- Filter(is_s3, objs)

  # Find all S3 methods in NAMESPACE
  ns <- pkgload::parse_ns_file(pkg$path)
  exports <- paste(ns$S3methods[, 1], ns$S3methods[, 2], sep = ".")

  setdiff(s3_objs, exports)
}
