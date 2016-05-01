context("getrootdir")

test_that("finds common prefix", {
  expect_equal(getrootdir(c("x/a", "x/b", "x/c")), "x")
})


test_that("returns empty string when all paths in current directory (#537)", {
  expect_equal(getrootdir(c("a", "b", "c", "d/e")), "")
})
