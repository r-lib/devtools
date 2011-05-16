check_doc <- function(pkg, start = NULL) {
  pkg <- as.package(pkg)
  
  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full = TRUE)
  files <- sort(files)
  
  lapply(files, function(x) {
    print(tools::checkRd(x))
  })
  invisible()
}