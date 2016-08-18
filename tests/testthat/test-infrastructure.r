context("Infrastructure")

test_that("use_* functions consistently", {
  pkg <- "infrastructure"
  unlink(pkg, recursive = TRUE)
  withr::with_output_sink(tempfile(), create(pkg))

  use_test("test1", pkg = pkg)
  use_package_doc(pkg = pkg)
  use_vignette("test2", pkg = pkg)

  use_rcpp(pkg = pkg)
  use_travis(pkg = pkg, browse = FALSE)
  use_coverage(pkg = pkg)
  use_appveyor(pkg = pkg)

  x <- 1:100
  use_data(x, pkg = pkg)
  use_data_raw(pkg = pkg)

  use_readme_rmd(pkg = pkg)
  use_readme_md(pkg = pkg)
  use_news_md(pkg = pkg)

  use_revdep(pkg = pkg)
  use_cran_comments(pkg = pkg)
  use_code_of_conduct(pkg = pkg)

  use_mit_license(pkg = pkg)

  # Suppress R CMD check note
  file.rename("infrastructure/.travis.yml", "infrastructure/travis.yml")
  file.rename("infrastructure/.Rbuildignore", "infrastructure/Rbuildignore")
})

test_that("use_data", {
  on.exit(unlink(c("testUseData/data", "testUseData/R/sysdata.rda"),
                 recursive = TRUE, force = TRUE), add = TRUE)

  # Add data to package
  local({
    expect_false(exists("global_test_data_item_to_save", .GlobalEnv))
    .GlobalEnv$global_test_data_item_to_save <- 42L
    on.exit(rm(list = "global_test_data_item_to_save", pos = .GlobalEnv), add = TRUE)

    local_test_data_item_to_save <- global_test_data_item_to_save
    system_test_data_item_to_save <- global_test_data_item_to_save

    expect_message(use_data(global_test_data_item_to_save, pkg = "testUseData"),
                   "Saving")
    expect_message(use_data(local_test_data_item_to_save, pkg = "testUseData"),
                   "Saving")
    expect_message(use_data(system_test_data_item_to_save, pkg = "testUseData",
                            internal = TRUE),
                   "Saving")
    expect_error(use_data(global_test_data_item_to_save, pkg = "testUseData"),
                 "overwrite = TRUE")
    expect_error(use_data(local_test_data_item_to_save, pkg = "testUseData"),
                 "overwrite = TRUE")
    expect_error(use_data(system_test_data_item_to_save, pkg = "testUseData", internal = TRUE),
                 "overwrite = TRUE")

    expect_message(use_data(global_test_data_item_to_save, pkg = "testUseData",
                            overwrite = TRUE),
                   "Saving")
    expect_message(use_data(local_test_data_item_to_save, pkg = "testUseData",
                            overwrite = TRUE),
                   "Saving")
    expect_message(use_data(system_test_data_item_to_save, pkg = "testUseData",
                            internal = TRUE, overwrite = TRUE),
                   "Saving")
  })

  # Test data is in package
  local({
    expect_false(exists("global_test_data_item_to_save"))
    expect_false(exists("local_test_data_item_to_save"))
    expect_false(exists("system_test_data_item_to_save"))

    expect_warning(load_all("testUseData"),
      "Objects listed as exports, but not present in namespace: sysdata_export")

    on.exit(unload("testUseData"), add = TRUE)

    expect_false(exists("global_test_data_item_to_save"))
    expect_false(exists("local_test_data_item_to_save"))
    expect_equal(system_test_data_item_to_save, 42L)

    data(global_test_data_item_to_save, envir = environment())
    data(local_test_data_item_to_save, envir = environment())
    expect_equal(global_test_data_item_to_save, 42L)
    expect_equal(local_test_data_item_to_save, 42L)
  })
})
