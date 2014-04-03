context("help")

test_that("devtools::help behaves the same as utils::help for non-devtools-loaded packages", {
  # stats wasn't loaded with devtools. There are many combinations of calling
  # with quotes and without; make sure they're the same both ways. Need to index
  # in using [1] to drop attributes for which there are unimportant differences.
  expect_identical(devtools::help(lm)[1],            utils::help(lm)[1])
  expect_identical(devtools::help(lm, stats)[1],     utils::help(lm, stats)[1])
  expect_identical(devtools::help(lm, 'stats')[1],   utils::help(lm, 'stats')[1])
  expect_identical(devtools::help('lm')[1],          utils::help('lm')[1])
  expect_identical(devtools::help('lm', stats)[1],   utils::help('lm', stats)[1])
  expect_identical(devtools::help('lm', 'stats')[1], utils::help('lm', 'stats')[1])
})

test_that("devtools::help behaves the same as utils::help for nonexistent objects", {
  expect_equal(length(devtools::help(foofoo)), 0)
  expect_equal(length(devtools::help("foofoo")), 0)
})


test_that("devtools::? behaves the same as utils::? for non-devtools-loaded packages", {
  expect_identical(devtools::`?`(lm)[1], utils::`?`(lm)[1])
  expect_identical(devtools::`?`(`lm`)[1], utils::`?`(`lm`)[1])
  expect_identical(devtools::`?`('lm')[1], utils::`?`('lm')[1])
})

test_that("devtools::? behaves the same as utils::? for nonexistent objects", {
  expect_equal(length(devtools::`?`(foofoo)), 0)
  expect_equal(length(devtools::`?`(`foofoo`)), 0)
  expect_equal(length(devtools::`?`("foofoo")), 0)
})


test_that("help and ? find files for devtools-loaded packages", {
  load_all('testHelp')

  # We can't test dev_help or help directly, because instead of returning an
  # object, they display the Rd file directly. But dev_help uses find_topic,
  # and we can test that.
  expect_true(!is.null(find_topic('foofoo')))
  expect_null(find_topic('bad_value'))
  unload('testHelp')
})
