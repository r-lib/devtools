test_that("package_file() gives useful errors", {
  expect_snapshot(error = TRUE, {
    package_file(path = 1)
    package_file(path = "doesntexist")
    package_file(path = "/")
  })
})

test_that("create argument is deprecated", {
  path <- create_local_package()
  expect_snapshot(x <- as.package(path, create = TRUE))
})
