test_that("release() is deprecated", {
  expect_snapshot(. <- release(), error = TRUE)
})

test_that("req_perform_cran() reports an unavailable submission form", {
  skip_if_not_installed("httr2")

  httr2::local_mocked_responses(list(
    httr2::response(503, url = cran_submission_url)
  ))

  expect_snapshot(
    req_perform_cran(httr2::request(cran_submission_url)),
    error = TRUE
  )
})
