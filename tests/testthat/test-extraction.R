context("extract_lang")

f <- function(x) {
  a <- 1:10
  for (i in seq_along(a)) {
    print(i)
  }
}

test_that("extract_lang issues warning if nothing found", {

  expect_warning(extract_lang(body(f), comp_lang, quote(j)),
    "Devtools is incompatible")
})

test_that("extract_lang and comp_lang finds full statements", {

  expect_equal(extract_lang(body(f), comp_lang, quote(a <- 1:10)),
    quote(a <- 1:10))
})

test_that("extract_lang and comp_lang find child calls", {

  expect_equal(extract_lang(body(f), comp_lang, quote(seq_along(a))),
    quote(seq_along(a)))
})

test_that("extract_lang and comp_lang finds partial statements", {

  expect_equal(extract_lang(body(f), comp_lang, quote(a <- NULL), 1:2),
    quote(a <- 1:10))
})

test_that("extract_lang and comp_lang finds partial statements from for conditionals", {

  expect_equal(extract_lang(body(f), comp_lang, quote(for (i in seq_along(a)) NULL), 1:3),
    quote(for (i in seq_along(a)) { print(i) }))
})

test_that("modify_lang modifies properly", {
  expect_equal(modify_lang(quote(a <- 1:10), function(x) if (comp_lang(x, quote(a))) quote(b) else x),
      quote(b <- 1:10))
})
