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
  descriptions <- lapply(c(1,2), function(call_repetition) {
    if (call_repetition == 1) {
      # first time function is being called... It should return TRUE.
      expect_true(add_desc_package("testData", "Imports", import_text))
    } else {
      # function should report that nothing changed
      expect_false(add_desc_package("testData", "Imports", import_text))
    }

    return(read_dcf(path_to_test_desc))
    })

  # finally, check for idempotency.
  expect_equal(descriptions[1], descriptions[2])
})

test_that("use_package throws error with invalid 'version' argument", {
  # test error is thrown with invalid `version`;
  # use the tests/testthat/testData/ as test package.
  expect_error(use_package("utils", "Imports", "testData", "invalid"))
})

# Set up a grid of the potential inputs to use_package and individual test
# them for correctness and behaviour. These are only partial tests, since the
# checks for idempotency, error-throwing, and making sure *only* the indicated
# fields are affected, are all handled above.
test_that("use_package can modify Imports, Suggests and Depends", {
  # use tests/testthat/testData as testing package
  path_to_test_desc <- file.path("testData", "DESCRIPTION")
  old_desc <- read_dcf(path_to_test_desc)

  # be sure to return the description to original state on exit
  on.exit(write_dcf(path_to_test_desc, old_desc))

  # create all possible input scenarios
  types <- c("Imports", "Suggests", "Depends")
  package <- "utils"
  pkg <- "testData"
  versions <- list(NULL, TRUE, "3.0.0")

  # we expect use_package to be able to add:
  # utils, utils (>= 3.2.3) and utils (>= 3.0.0) to
  # Imports, Suggests, and Depends DESCRIPTION sections:
  sapply(types, function(type) {
    sapply(versions, function(version) {

      on.exit(write_dcf(path_to_test_desc, old_desc))

      # expect a message with each call
      expect_message(use_package(package, type, pkg, version), regexp = NULL)

      # check that section was properly modified; note, that we don't have
      # to check that other sections are NOT being modified since we assume
      # that this behaviour is being preserved by add_desc_package().
      new_desc <- read_dcf(path_to_test_desc)
      expect_equal(new_desc[[type]], build_package_txt(package, version))
    })
  })
})



