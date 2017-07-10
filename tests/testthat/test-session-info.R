context("package_info")

test_that("package_info errors if an input package is not installed", {
  expect_error(package_info(c("foo", "bar")),
    "`pkgs` 'foo', 'bar' are not installed")
})
