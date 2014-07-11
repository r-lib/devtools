context("Gist")

# The tests need to call R CMD ...
# Therefore I need to change the environment variable to make it normal
.R_TESTS <- Sys.getenv("R_TESTS")
Sys.setenv("R_TESTS"="")

test_that("Source Gist Correctly", {
  expect_equal(capture.output(source_gist("108b497a9cbbcd3caa9a"), file=NULL), 
               "asdkfja;sldfa;sl")
  expect_equal(capture.output(source_gist("f2e541586bb70697c2cc", chdir = TRUE), 
                              file=NULL), 
               "hello")
  expect_equal({
    source_gist("452874384bdc62ca9ae7", verbose = TRUE)
    capture.output(hello(), file=NULL)
  }, "hello")
  expect_equal({
    source_gist("f3fe88494ad49fe9445e", sha1="194673d8e95fedbc0e1e7f7820f98e681dab8754")
    capture.output(hello(), file=NULL)
  }, "hello")
  expect_error(source_gist("f3fe88494ad49fe9445e", sha1="294673"))
})
Sys.setenv("R_TESTS"=.R_TESTS)

