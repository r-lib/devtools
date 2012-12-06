context("Load: collate")

test_that("If collate absent, load in alphabetical order", {
  load_all("collate-absent")

  expect_equal(a, 3)

  unload("collate-absent")
})

test_that("Warned about files missing from collate, but they're still loaded", {
  expect_message(load_all("collate-missing"), "a.r")

  expect_equal(a, 1)
  expect_equal(b, 2)

  unload("collate-missing")
})

test_that("Extra files in collate don't error, but warn", {
  expect_message(load_all("collate-extra"), "b.r")

  expect_equal(a, 1)

  unload("collate-extra")
})
