test_that("can determine when to document", {
  expect_false(can_document(NULL))
  expect_true(can_document("1.0.0", installed = "1.0.0"))
  expect_snapshot(result <- can_document("1.0.0", installed = "2.0.0"))
  expect_false(result)
})

test_that("fail instead of sending an email to wrong recipient", {
  # The testTest package has both Authors@R and Maintainer field - this causes problems in change_maintainer_email().
  # The function checks if the provided email is actually the one in the maintainer field instead of sending the report to the wrong recipient
  expect_error(check_win_release(path("testTest"), email = "foo@bar.com"))
})
