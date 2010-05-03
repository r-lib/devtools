load_c <- function(pkg) {
  pkg <- as.package(pkg)
  
  path_src <- file.path(pkg$path, "src")
  if (!file.exists(path_src)) return(invisible())
  
  paths <- dir(path_src, "\\.(so|dll)$", full = TRUE)

  l_ply(paths, dyn.load)
  invisible(paths)
}