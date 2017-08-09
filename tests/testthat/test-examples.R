context('Examples')

test_that('Can run an example', {
    pkg <- "testHelp"
    expect_output(run_examples(pkg = pkg)
      , "stopifnot(foofoo() == 'You called foofoo.')", fixed = TRUE)
    })
