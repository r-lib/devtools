#' Find missing s3 exports.
#'
#' The method is heuristic - looking for objs with a period in their name.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
missing_s3 <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  ns <- parseNamespaceFile(basename(pkg$path), dirname(pkg$path))

  exports <- paste(ns$S3methods[, 1], ns$S3methods[, 2], sep = ".")

  load_all(pkg)
  objs <- ls(env_name(pkg))
  s3_objs <- objs[grepl(".", objs, fixed = TRUE)]

  setdiff(s3_objs, exports)
}
