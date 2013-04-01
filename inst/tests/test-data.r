context("Data")

test_that("data available when lazydata not true", {
  load_all("testData")

  # a and b are in data/ and shouldn't be available yet
  # sysdata_export and sysdata_nonexport are in R/sysdata.rda, and should be available
  expect_false(exists("a"))
  expect_false(exists("b"))
  expect_equal(sysdata_export, 3)
  expect_equal(sysdata_nonexport, 4)

  # Load the data objects (into the local environment)
  data(a, envir = environment())
  data(b, envir = environment())
  expect_equal(a, 1)
  expect_equal(b, 2)

  unload("testData")

  # Objects loaded with data() should still be available
  expect_equal(a, 1)
  expect_equal(b, 2)
  # Objects loaded in sysdata.rda shouldn't be available
  expect_false(exists("sysdata_export"))
  expect_false(exists("sysdata_nonexport"))
})


test_that("data available when lazydata is true", {
  load_all("testDataLazy")

  # a and b are in data/ and should be available because of lazydata
  # sysdata_export and sysdata_nonexport are in R/sysdata.rda, and should be available
  expect_equal(a, 1)
  expect_equal(b, 2)
  expect_equal(sysdata_export, 3)
  expect_equal(sysdata_nonexport, 4)

  unload("testDataLazy")
})


test_that("data available when lazydata not true, and export_all is FALSE", {
  load_all("testData", export_all = FALSE)

  # a and b are in data/ and shouldn't be available yet
  # sysdata_export is exported; sysdata_nonexport isn't
  expect_false(exists("a"))
  expect_false(exists("b"))
  expect_equal(sysdata_export, 3)
  expect_false(exists("sysdata_nonexport"))

  # Load the data objects (into the local environment)
  data(a, envir = environment())
  data(b, envir = environment())
  expect_equal(a, 1)
  expect_equal(b, 2)

  # Shouldn't be able to load objects in R/sysdata.rda with data()
  expect_warning(data(sysdata_export, envir = environment()))
  expect_false(exists("sysdata_nonexport"))

  unload("testData")
})


test_that("data available when lazydata is true, and export_all is FALSE", {
  load_all("testDataLazy", export_all = FALSE)

  # a and b are in data/ and should be available because of lazydata
  # sysdata_export is exported; sysdata_nonexport isn't
  expect_equal(a, 1)
  expect_equal(b, 2)
  expect_equal(sysdata_export, 3)
  expect_false(exists("sysdata_nonexport"))

  # Shouldn't be able to load objects in R/sysdata.rda with data()
  expect_warning(data(sysdata_export, envir = environment()))
  expect_false(exists("sysdata_nonexport"))

  unload("testDataLazy")
})
