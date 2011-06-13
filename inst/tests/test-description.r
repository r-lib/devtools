context("Documentation checks")

test_that("invalid DESCRIPTION gives warning", {
  expect_message(check_doc("invalid-description"), 
    c("invalid DESCRIPTION", "fields missing"))
})