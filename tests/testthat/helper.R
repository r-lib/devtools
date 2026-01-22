# This is a VERY trimmed down version of create_local_thing from usethis
local_package_create <- function(envir = parent.frame()) {
  dir <- withr::local_tempdir(.local_envir = envir)

  withr::local_options(usethis.quiet = TRUE)
  create_package(dir, rstudio = FALSE, open = FALSE, check_name = FALSE)

  dir
}

local_package_copy <- function(path, env = parent.frame()) {
  temp_path <- withr::local_tempdir(.local_envir = env)

  dir_copy(path, temp_path, overwrite = TRUE)
  temp_path
}
