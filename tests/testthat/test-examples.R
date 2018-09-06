context("Examples")

test_that("Can run an example", {
  pkg <- "testHelp"
  expect_output(run_examples(pkg = pkg, document = FALSE), "You called foofoo.", fixed = TRUE)
})
