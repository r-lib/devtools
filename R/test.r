test <- function(pkg) {
  pkg <- as.package(pkg)
  
  path_test <- file.path(pkg$path, "inst", "tests")
  if (!file.exists(path_test)) return()
  
  test_dir(path_test)
}