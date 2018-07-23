# Some helpers around usethis functions

#' @importFrom withr defer
local_proj <- withr::local_(function(path = ".", force = FALSE, quiet = FALSE) utils::capture.output(usethis::proj_set(path = path, force = force, quiet = quiet)))

usethis_use_directory <- function(pkg, dir, ignore = FALSE) {
  local_proj(pkg$path)
  usethis::use_directory(dir, ignore)
}
