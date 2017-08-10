context('Examples')

test_that('Can run an example', {
  pkg <- "testHelp"
  expect_output(run_examples(pkg = pkg), "You called foofoo.", fixed=TRUE)
})
