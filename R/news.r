#' Show package news
#' 
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
show_news <- function(pkg, ...) {
  pkg <- as.package(pkg)
  news_path <- file.path(pkg$path, "NEWS")
  news(..., db = tools:::.news_reader_default(news_path))
}