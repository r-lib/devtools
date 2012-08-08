context("Attribute")

test_that("Package environment has correct 'path' attribute", {
  load_all("namespace")
  pkgenv <- as.environment("package:namespace")

  wd <- normalizePath(file.path(getwd(), "namespace"))
  pkg_path <- attr(pkgenv, "path")

  expect_identical(wd, pkg_path)
  unload("namespace")
})
