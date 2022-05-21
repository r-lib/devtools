# This is a trimmed down version of create_local_thing from usethis
# https://github.com/jimhester/usethis/blob/de8aa116820a8e54f2f952b341039985d78d0352/tests/testthat/helper.R#L28-L68
create_local_package <- function() {
  old_project <- asNamespace("usethis")$proj_get_() # this could be `NULL`, i.e. no active project
  old_wd <- getwd()
  dir <- file_temp()

  withr::defer(envir = parent.frame(), {
    proj_set(old_project, force = TRUE)
    setwd(old_wd)
    dir_delete(dir)
  })

  usethis::ui_silence({
    create_package(dir, rstudio = FALSE, open = FALSE, check_name = FALSE)
    proj_set(dir)
  })

  proj_dir <- proj_get()
  setwd(proj_dir)

  invisible(proj_dir)
}

local_package_copy <- function(path, env = parent.frame()) {
  temp_path <- withr::local_tempdir(.local_envir = env)

  dir_copy(path, temp_path, overwrite = TRUE)
  temp_path
}
