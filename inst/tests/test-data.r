context("Data")

test_that("data available without namespace", {
  load_all("testData")

  expect_equal(a, 1)
  expect_equal(b, 2)
  expect_equal(testData, 3)

  unload("testData")
})

test_that("data available with namespace", {
  load_all("testData", export_all = FALSE)

  expect_equal(a, 1)
  expect_equal(b, 2)
  expect_false(exists("testData"))

  unload("testData")
})
