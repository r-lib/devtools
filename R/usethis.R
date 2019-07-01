# Some helpers around usethis functions

# we need to import some usethis function so the namespace is loaded when
# devtools is loaded, but not attached.
#' @importFrom usethis use_test
NULL

#' @importFrom withr defer
local_proj <- withr::local_(function(path = ".", force = FALSE) utils::capture.output(usethis::proj_set(path = path, force = force)))

usethis_use_testthat <- function(pkg) {
  utils::capture.output({
    local_proj(pkg$path)
    usethis::use_testthat()
  })
}

usethis_use_directory <- function(pkg, path, ignore = FALSE) {
  utils::capture.output({
    local_proj(pkg$path)
    usethis::use_directory(path, ignore)
  })
}

usethis_use_git_ignore <- function(pkg, ignores, ignore = FALSE) {
  utils::capture.output({
    local_proj(pkg$path)
    usethis::use_git_ignore(ignores)
  })
}
