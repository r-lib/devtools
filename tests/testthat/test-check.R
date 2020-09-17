test_that("can determine when to document", {
  expect_false(can_document(list()))
  # TODO: switch to expect_snapshot()
  suppressMessages(expect_message(
    expect_false(can_document(list(roxygennote = "15.0.00"))),
    "doesn't match required"
  ))
  expect_true(can_document(list(roxygennote = packageVersion("roxygen2"))))
})
