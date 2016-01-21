context("install_dev_remotes")
test_that("install_dev_remotes returns if no remotes specified", {
  expect_equal(install_dev_remotes("testTest"), NULL)
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
    "Unknown remote type: hadley")
  expect_error(dev_remote_type("SVN2::testthat"),
    "Unknown remote type: SVN2")
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

test_that("different_sha returns TRUE if remote or local sha is NA not found", {
  expect_true(different_sha(remote_sha = NA, local_sha = "4a2ea2"))
  expect_true(different_sha(remote_sha = "4a2ea2", local_sha = NA))
  expect_true(different_sha(remote_sha = NA, local_sha = NA))
})
test_that("different_sha returns TRUE if remote_sha and local_sha are different", {
  expect_true(different_sha(remote_sha = "5b3fb3", local_sha = "4a2ea2"))
})
test_that("different_sha returns FALSE if remote_sha and local_sha are the same", {
  expect_false(different_sha(remote_sha = "4a2ea2", local_sha = "4a2ea2"))
})
test_that("local_sha returns NA if package is not installed", {
  expect_equal(local_sha("tsrtarst"), NA)
})
test_that("remote_sha.github_remote returns NA if remote doesn't exist", {
  expect_equal(remote_sha(github_remote("arst/arst")), NA)
})
test_that("remote_sha.github_remote returns expected value if remote does exist", {
  expect_equal(remote_sha(github_remote("hadley/devtools@v1.8.0")), "ad9aac7b9a522354e1ff363a86f389e32cec181b")
})
