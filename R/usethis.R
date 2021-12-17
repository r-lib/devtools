# Some helpers around usethis functions

# we need to import some usethis function so the namespace is loaded when
# devtools is loaded, but not attached.
#' @importFrom usethis use_test
NULL

usethis_use_testthat <- function(pkg) {
  usethis::local_project(pkg$path, quiet = FALSE)
  usethis::use_testthat()
}

usethis_use_directory <- function(pkg, path, ignore = FALSE) {
  usethis::local_project(pkg$path, quiet = TRUE)
  usethis::use_directory(path, ignore)
}

usethis_use_git_ignore <- function(pkg, ignores, ignore = FALSE) {
  usethis::local_project(pkg$path, quiet = TRUE)
  usethis::use_git_ignore(ignores)
}
