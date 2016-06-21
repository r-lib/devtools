context("Checking that check_max_r_version() updates R version")

testthat("R version gets updated", {
  temp <- tempdir()
  file.copy("testMaxR/DESCRIPTION", temp)
  pkg <- as.package(temp)

  check_max_r_version(pkg)
  desc_path <- file.path(pkg$path, "DESCRIPTION")
  desc <- read_dcf(desc_path)

  old_deps <- parse_deps(desc$Depends, remove_r = FALSE)
  current_version <- old_deps[old_deps$name == "R", "version"]

  devtools_desc <- read_dcf(system.file("DESCRIPTION", package = "devtools"))
  devtools_deps <- parse_deps(devtools_desc$Depends, remove_r = FALSE)
  devtools_version <- devtools_deps[devtools_deps$name == "R", "version"]

  expect_equal(devtools_version, current_version)

  unlink(temp, recursive = TRUE, force = TRUE)
})
