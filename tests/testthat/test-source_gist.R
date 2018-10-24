context("source_gist")

test_that("gist containing single file works unambiguously", {
  skip_on_cran()

  a <- 10
  source_gist("a65ddd06db40213f1a921237c55defbe", local = environment())
  expect_equal(a, 1)
})

test_that("gist with multiple files uses first with warning", {
  skip_on_cran()

  a <- 10
  expect_warning(source_gist("605a984e764f9ed358556b4ce48cbd08", local = environment()), "using first")
  expect_equal(a, 1)
})

test_that("can specify filename", {
  skip_on_cran()

  b <- 10
  source_gist("605a984e764f9ed358556b4ce48cbd08", filename = "b.r", local = environment())
  expect_equal(b, 2)
})

test_that("error if file doesn't exist or no files", {
  skip_on_cran()

  expect_error(
    source_gist("605a984e764f9ed358556b4ce48cbd08", filename = "c.r", local = environment()),
    "not found"
  )

  expect_error(
    source_gist("c535eee2d02e5f47c8e7642811bc327c"),
    "No R files found"
  )
})
