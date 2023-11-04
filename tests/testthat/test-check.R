test_that("can determine when to document", {
  expect_false(can_document(list()))
  # TODO: switch to expect_snapshot()
  expect_output(
    expect_message(
      expect_false(can_document(list(roxygennote = "15.0.00"))),
      "doesn't match required"
    )
  )
  expect_true(can_document(list(roxygennote = packageVersion("roxygen2"))))
})

test_that("fail instead of sending an email to wrong recipient", {
  # The testTest package has both Authors@R and Maintainer field - this causes problems in change_maintainer_email().
  # The function checks if the provided email is actually the one in the maintainer field instead of sending the report to the wrong recipient
  expect_error(check_win_release(path("testTest"), email = "foo@bar.com"))
})
