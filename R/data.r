load_data <- function(pkg, env = pkg_env(pkg)) {
  pkg <- as.package(pkg)
  
  path_data <- file.path(pkg$path, "data")
  if (!file.exists(path_data)) return(invisible())
  
  paths <- dir(path_data, "\\.[rR]da(ta)?$", full = TRUE)
  paths <- changed_files(paths)

  objs <- unlist(plyr::llply(paths, load, envir = env))
  invisible(objs)
}
