test_that("release() is deprecated", {
  expect_snapshot(. <- release(), error = TRUE)
})
