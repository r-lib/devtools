#' Check package documentation.
#'
#' @export
check_doc <- function(pkg) {
  pkg <- as.package(pkg)
  
  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full = TRUE)
  files <- sort(files)
  
  lapply(files, function(x) {
    print(tools::checkRd(x))
  })
  invisible()
}