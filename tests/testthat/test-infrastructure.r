context("Infrastructure")

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

test_that("add_desc_package only modifies 'field' section of DESCRIPTION", {
  # use tests/testthat/testData as testing package
  path_to_test_desc <- file.path("testData", "DESCRIPTION")
  old_desc <- read_dcf(path_to_test_desc)

  # be sure to return the description to original state on exit
  on.exit(write_dcf(path_to_test_desc, old_desc))

  # add testPackage to the "Imports" of the testData package
  import_text <- "testPackage (>= 1.0.0)"
  output <- add_desc_package("testData", "Imports", import_text)
  new_desc <- read_dcf(path_to_test_desc)

  expect_true(output) # check that add_desc_package still returns boolean
  expect_equal(old_desc, new_desc[which(names(new_desc) != "Imports")]) # make sure only Imports section is modified
  expect_equal(new_desc[["Imports"]], import_text) # make sure Import section is properly modified
})

test_that("add_desc_package is idempotent", {
  # use tests/testthat/testData as testing package
  path_to_test_desc <- file.path("testData", "DESCRIPTION")
  old_desc <- read_dcf(path_to_test_desc)

  # be sure to return the description to original state on exit
  on.exit(write_dcf(path_to_test_desc, old_desc))

  # add testPackage to the Imports: of the testData package;
  # do it twice and check that the description file is the same as in
  # the second time.
  import_text <- "testPackage (>= 1.0.0)"

  # first time function is being called... It should return TRUE.
  expect_true(add_desc_package("testData", "Imports", import_text))
  first_output <- read_dcf(path_to_test_desc)

  # function should report that nothing changed
  expect_false(add_desc_package("testData", "Imports", import_text))
  second_output <- read_dcf(path_to_test_desc)

  # finally, check for idempotency.
  expect_equal(first_output, second_output)
})

test_that("use_package throws error with invalid 'version' argument", {
  # test error is thrown with invalid `version`;
  # use the tests/testthat/testData/ as test package.
  expect_error(use_package("utils", "Imports", "testData", "invalid"))
})
