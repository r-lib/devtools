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

test_that("use_package", {
  # use tests/testthat/testData as testing package
  path_to_test_desc <- file.path("testData", "DESCRIPTION")
  old_desc <- read_dcf(path_to_test_desc)

  # be sure to return the description to original state on exit
  on.exit(write_dcf(path_to_test_desc, old_desc))

  # create all possible input scenarios
  types <- c("Imports", "Suggests", "Depends")
  package <- "utils"
  versions <- c("default", "true", "other")
  comparators <- c(">=", ">", "==", "<=", "<")
  pkg <- "testData"

  test_cases <-
    expand.grid(
      package = package,
      type = types,
      pkg = pkg,
      version = versions,
      compare = comparators,
      stringsAsFactors = FALSE
    )

  # for each test case, we expect:
  # 1. calls to use_package to be idempotent
  # 2. the DESCRIPTION to only be modified in the appropriate place
  apply(
    X = test_cases, MARGIN = 1, FUN = function(x) {
      x <- as.list(x)
      x$version <- switch(x$version,
                          default = NULL,
                          true = TRUE,
                          other = "3.0.0")

      on.exit(write_dcf(path_to_test_desc, old_desc))

      # expect a message with all calls, but don't specify what the message says
      # perform twice so that we can check for idempotency
      replicate(2, expect_message(do.call(use_package, x), regexp = NULL))

      new_desc <- read_dcf(path_to_test_desc)

      # DESCRIPTION file doesn't have the typical "Depends: R (>= x.y.z)" so
      # we don't have to exclude it from the intersection
      new_desc_names <- names(new_desc)
      overlapping_fields <-
        intersect(new_desc_names, names(old_desc))
      expect_equal(new_desc[overlapping_fields], old_desc[overlapping_fields])

      # check the new field:
      modified_field <- setdiff(new_desc_names, overlapping_fields)
      expect_equal(modified_field, x$type) # implicitly checks type and length

      # check field value:
      expect_equal(new_desc[[x$type]],
                   build_package_txt(x$package, x$version, x$compare))
    }
  )

  # test error is thrown with invalid `version`:
  expect_error(use_package(package, types[1], pkg, "invalid", ">="))
})
