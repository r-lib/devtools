context("Install from GitLab")

test_that("install_gitlab", {

  skip_on_cran()
  skip_if_offline()

  Sys.unsetenv("R_TESTS")

  lib <- tempfile()
  on.exit(unlink(lib, recursive = TRUE), add = TRUE)
  dir.create(lib)
  libpath <- .libPaths()
  on.exit(.libPaths(libpath), add = TRUE)
  .libPaths(lib)

  install_gitlab("jimhester/falsy", lib = lib, quiet = TRUE)

  expect_silent(packageDescription("falsy", lib.loc = lib))
  expect_equal(
    packageDescription("falsy", lib.loc = lib)$RemoteRepo,
    "falsy")
})

test_that("error if not username, warning if given as argument", {

  skip_on_cran()
  skip_if_offline()

  Sys.unsetenv("R_TESTS")

  lib <- tempfile()
  on.exit(unlink(lib, recursive = TRUE), add = TRUE)
  dir.create(lib)

  expect_error(
    install_gitlab("falsy", lib = lib, quiet = TRUE)
  )
})

test_that("remote_download.gitlab_remote messages", {

  mockery::stub(remote_download.gitlab_remote, "download_gitlab", TRUE)
  expect_message(
    remote_download.gitlab_remote(
      remote("gitlab",
        host = "https://gitlab.com",
        username = "cran",
        repo = "falsy",
        ref = "master"
      )
    ),
    "Downloading GitLab repo"
  )
})

test_that("remote_metadata.gitlab_remote", {

  skip_on_cran()
  skip_if_offline()

  expect_equal(
    remote_metadata.gitlab_remote(
      remote("gitlab",
        host = "https://gitlab.com",
        username = "jimhester",
        repo = "falsy",
        ref = "1.0"
      )
    )$RemoteSha,
    "0f39d9eb735bf16909831c0bb129063dda388375"
  )

})
