test_that("github_ functions are deprecated", {
  expect_snapshot({
    . <- github_pull(1)
    . <- github_release()
  })
})
