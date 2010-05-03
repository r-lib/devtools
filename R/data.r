load_data <- function(pkg) {
  pkg <- as.package(pkg)
  
  path_data <- file.path(pkg$path, "data")
  if (!file.exists(path_data)) return(invisible())
  
  paths <- dir(path_data, "\\.[rR]da(ta)?$", full = TRUE)

  objs <- unlist(plyr::llply(paths, load, globalenv()))
  invisible(objs)
}
