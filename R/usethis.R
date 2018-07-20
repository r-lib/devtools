# Some helpers around usethis functions

#' @importFrom withr defer
local_proj <- withr::local_(usethis::proj_set)

usethis_use_directory <- function(pkg, dir, ignore = FALSE) {
  capture.output({
    local_proj(pkg$path)
    usethis::use_directory(dir, ignore)
  })
}
