test_that("gist containing single file works unambiguously", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

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

  a <- 10
  expect_snapshot(
    source_gist(
      "605a984e764f9ed358556b4ce48cbd08",
      sha1 = "f176f5e1fe0",
      local = environment()
    )
  )
  expect_equal(a, 1)
})

test_that("errors with bad id", {
  expect_snapshot(source_gist("xxxx"), error = TRUE)
})

test_that("can specify filename", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

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

  expect_snapshot(error = TRUE, {
    find_gist("605a984e764f9ed358556b4ce48cbd08", 1)
    find_gist("605a984e764f9ed358556b4ce48cbd08", "c.r")
    find_gist("c535eee2d02e5f47c8e7642811bc327c")
  })
})

test_that("check_sha1() checks or reports sha1 as needed", {
  path <- withr::local_tempfile()
  writeBin("abc\n", path)

  expect_snapshot(error = TRUE, {
    check_sha1(path, NULL)
    check_sha1(path, "f")
    check_sha1(path, "ffffff")
  })
})
