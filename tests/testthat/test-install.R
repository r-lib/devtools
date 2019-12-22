context("Install")

library(mockery)

pkg <- test_path("testReadme")
pkg_path <- normalizePath(pkg)

test_that("install_deps passes optional args to remotes::install_deps", {
  mck <- mock(NULL, cycle = TRUE)
  stub(install_deps, "remotes::install_deps", mck)

  type <- "foo"

  install_deps(pkg, type = type)

  expect_called(mck, 1)
  expect_args(mck, 1, pkg_path, dependencies = NA, type = type)
})

test_that("install_deps passes dependency = NA to remotes::install_deps", {
  mck <- mock(NULL, cycle = TRUE)
  stub(install_deps, "remotes::install_deps", mck)

  install_deps(pkg)

  expect_called(mck, 1)
  expect_args(mck, 1, pkg_path, dependencies = NA)
})

test_that("install_dev_deps passes optional args to remotes::install_deps", {
  mck <- mock(NULL, cycle = TRUE)
  stub(install_dev_deps, "remotes::install_deps", mck)

  type <- "foo"

  install_dev_deps(pkg, type = type)

  expect_called(mck, 1)
  expect_args(mck, 1, pkg_path, dependencies = TRUE, type = type)
})

test_that("install_dev_deps passes dependency = TRUE to remotes::install_deps", {
  mck <- mock(NULL, cycle = TRUE)
  stub(install_dev_deps, "remotes::install_deps", mck)

  install_dev_deps(pkg)

  expect_called(mck, 1)
  expect_args(mck, 1, pkg_path, dependencies = TRUE)
})
