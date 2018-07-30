# Some helpers around usethis functions

#' @importFrom withr defer
local_proj <- withr::local_(function(path = ".", force = FALSE, quiet = FALSE) utils::capture.output(usethis::proj_set(path = path, force = force, quiet = quiet)))

usethis_use_directory <- function(pkg, path, ignore = FALSE) {
  capture.output({
    local_proj(pkg$path)
    usethis::use_directory(path, ignore)
  })
}

usethis_use_git_ignore <- function(pkg, ignores, ignore = FALSE) {
  capture.output({
    local_proj(pkg$path)
    usethis::use_git_ignore(ignores)
  })
}
