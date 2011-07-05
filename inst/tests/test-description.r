context("Documentation checks")

test_that("invalid DESCRIPTION gives warning", {
  expect_message(load_all("invalid-description"), 
    c("invalid DESCRIPTION", "fields missing"))
})