context("sort")

test_that("case-insensitive sort order", {
  expect_equal(sort_ci(rev(letters)), letters)
  expect_equal(sort_ci(rev(LETTERS)), LETTERS)
  expect_equal(sort_ci(c(letters[1:3], LETTERS[1:3])), c("A", "a", "B", "b", "C", "c"))
})
