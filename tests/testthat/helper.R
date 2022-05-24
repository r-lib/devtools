# This is a VERY trimmed down version of create_local_thing from usethis
local_package_create <- function(envir = parent.frame()) {
  dir <- withr::local_tempdir(.local_envir = envir)

  usethis::ui_silence({
    create_package(dir, rstudio = FALSE, open = FALSE, check_name = FALSE)
  })

  dir
}
