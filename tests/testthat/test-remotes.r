context("install_dev_remotes")
test_that("install_dev_remotes returns if no remotes specified", {
  expect_equal(install_dev_remotes("testTest/"), NULL)
})

test_that("dev_remote_type works with implicit types", {
  expect_equal(dev_remote_type("hadley/testthat"),
    list(list(repository = "hadley/testthat", type = "github", fun = install_github)))

  simple_github <-
    list(
      list(repository = "hadley/testthat", type = "github", fun = install_github),
      list(repository = "klutometis/roxygen", type = "github", fun = install_github)
    )

  expect_equal(dev_remote_type("hadley/testthat,klutometis/roxygen"), simple_github)
  expect_equal(dev_remote_type("hadley/testthat,\n  klutometis/roxygen"), simple_github)
  expect_equal(dev_remote_type("hadley/testthat,\n\tklutometis/roxygen"), simple_github)
})

test_that("dev_remote_type errors", {
  expect_equal(dev_remote_type(""), NULL)

  expect_error(dev_remote_type("git::testthat::blah"),
    "Malformed remote specification 'git::testthat::blah'")
  expect_error(dev_remote_type("hadley::testthat"),
    "Malformed remote specification 'hadley::testthat'")
  expect_error(dev_remote_type("SVN2::testthat"),
    "Malformed remote specification 'SVN2::testthat'")
})

test_that("dev_remote_type works with explicit types", {
  expect_equal(dev_remote_type("github::hadley/testthat"),
    list(list(repository = "hadley/testthat", type = "github", fun = install_github)))

  simple_github <-
    list(
      list(repository = "hadley/testthat", type = "github", fun = install_github),
      list(repository = "klutometis/roxygen", type = "github", fun = install_github)
    )

  expect_equal(dev_remote_type("github::hadley/testthat,klutometis/roxygen"), simple_github)
  expect_equal(dev_remote_type("hadley/testthat,github::klutometis/roxygen"), simple_github)
  expect_equal(dev_remote_type("github::hadley/testthat,github::klutometis/roxygen"), simple_github)

  expect_equal(dev_remote_type("svn::https://github.com/hadley/testthat,\n  git::https://github.com/klutometis/roxygen.git"),
    list(
      list(repository = "https://github.com/hadley/testthat", type = "svn", fun = install_svn),
      list(repository = "https://github.com/klutometis/roxygen.git", type = "git", fun = install_git)
    ))
})
