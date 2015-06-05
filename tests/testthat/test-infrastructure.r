context("Infrastructure")

test_that("use_data", {
  on.exit(unlink(c("testUseData/data", "testUseData/R/sysdata.rda"),
                 recursive = TRUE, force = TRUE), add = TRUE)

  # Add data to pacakge
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

    load_all("testUseData")
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
