#' Find missing s3 exports
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `missing_s3()` is deprecated because roxygen2 now provides the same
#' functionality. Run `devtools::document()` and look for
#' `"Missing documentation for S3 method"` warnings.
#'
#' @template devtools
#' @export
#' @keywords internal
missing_s3 <- function(pkg = ".") {
  lifecycle::deprecate_warn("2.5.0", "missing_s3()")
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
