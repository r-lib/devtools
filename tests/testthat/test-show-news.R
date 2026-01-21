test_that("find_news() finds NEWS in all expected locations", {
  pkg <- local_package_create()

  dir_create(pkg, "inst")
  file_create(pkg, "inst", "NEWS")
  expect_equal(path_rel(find_news(pkg), pkg), path("inst/NEWS"))

  file_create(pkg, "NEWS")
  expect_equal(path_rel(find_news(pkg), pkg), path("NEWS"))

  file_create(pkg, "NEWS.md")
  expect_equal(path_rel(find_news(pkg), pkg), path("NEWS.md"))

  file_create(pkg, "inst", "NEWS.Rd")
  expect_equal(path_rel(find_news(pkg), pkg), path("inst/NEWS.Rd"))
})

test_that("fails when NEWS is missing or improperly formatted", {
  skip_on_cran()

  pkg <- local_package_create()
  expect_snapshot(show_news(pkg), error = TRUE)

  dir_create(pkg, "inst")
  file_create(pkg, "inst", "NEWS.Rd")

  expect_snapshot(show_news(pkg), error = TRUE)
})
