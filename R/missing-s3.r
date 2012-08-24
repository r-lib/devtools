#' Find missing s3 exports.
#'
#' The method is heuristic - looking for objs with a period in their name.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
missing_s3 <- function(pkg = ".") {
  pkg <- as.package(pkg)
  ns <- parse_ns_file(pkg)

  exports <- paste(ns$S3methods[, 1], ns$S3methods[, 2], sep = ".")

  load_all(pkg)
  objs <- ls(ns_env(pkg))
  s3_objs <- objs[grepl(".", objs, fixed = TRUE)]

  setdiff(s3_objs, exports)
}
