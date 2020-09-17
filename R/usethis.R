# Some helpers around usethis functions

# we need to import some usethis function so the namespace is loaded when
# devtools is loaded, but not attached.
#' @importFrom usethis use_test
NULL

# Need to import defer because the local_ function uses it unqualified
#' @importFrom withr defer
local_proj <- withr::local_(function(path = ".", force = FALSE) {
  utils::capture.output(
    res <- usethis::proj_set(path = path, force = force)
  )
  res
})

usethis_use_testthat <- function(pkg) {
  utils::capture.output({
    local_proj(pkg$path)
    res <- usethis::use_testthat()
  })
  res
}

usethis_use_directory <- function(pkg, path, ignore = FALSE) {
  utils::capture.output({
    local_proj(pkg$path)
    res <- usethis::use_directory(path, ignore)
  })
  res
}

usethis_use_git_ignore <- function(pkg, ignores, ignore = FALSE) {
  utils::capture.output({
    local_proj(pkg$path)
    res <- usethis::use_git_ignore(ignores)
  })
  res
}
