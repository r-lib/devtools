test_that("gist containing single file works unambiguously", {
  skip_if_offline()
  skip_on_cran()
  # TODO remove the CI skips once remotes is on CRAN
  skip_on_ci()
  withr::local_envvar(list("GITHUB_PAT" = asNamespace("remotes")$github_pat()))

  a <- 10
  source_gist(
    "a65ddd06db40213f1a921237c55defbe",
    sha1 = "f176f5e1fe05b69b1ef799fdd1e4bac6341aff51",
    local = environment(),
    quiet = TRUE
  )
  expect_equal(a, 1)
})

test_that("gist with multiple files uses first with warning", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()
  withr::local_envvar(list("GITHUB_PAT" = asNamespace("remotes")$github_pat()))

  a <- 10
  expect_warning(
    source_gist(
      "605a984e764f9ed358556b4ce48cbd08",
      sha1 = "f176f5e1fe05b69b1ef799fdd1e4bac6341aff51",
      quiet = TRUE,
      local = environment()
    ),
    "using first"
  )
  expect_equal(a, 1)
})

test_that("can specify filename", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()
  withr::local_envvar(list("GITHUB_PAT" = asNamespace("remotes")$github_pat()))

  b <- 10
  source_gist(
    "605a984e764f9ed358556b4ce48cbd08",
    filename = "b.r",
    sha1 = "8d1c53241c425a9a52700726809b7f2c164bde72",
    local = environment(),
    quiet = TRUE
  )
  expect_equal(b, 2)
})

test_that("error if file doesn't exist or no files", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()
  withr::local_envvar(list("GITHUB_PAT" = asNamespace("remotes")$github_pat()))

  expect_error(
    source_gist("605a984e764f9ed358556b4ce48cbd08", filename = "c.r", local = environment()),
    "not found"
  )

  expect_error(
    source_gist("c535eee2d02e5f47c8e7642811bc327c"),
    "No R files found"
  )
})
