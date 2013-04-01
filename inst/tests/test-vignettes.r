context("Vignettes")

test_that("Building process works", {
  clean_vignettes("testVignettes")
  expect_false("new.tex" %in% dir("testVignettes/vignettes"))
  expect_false("new.pdf" %in% dir("testVignettes/inst/doc"))

  # Warn about vignette in wrong location
  expect_warning(build_vignettes("testVignettes"), "old.Rnw")
  expect_true("new.tex" %in% dir("testVignettes/vignettes"))
  expect_true("new.pdf" %in% dir("testVignettes/inst/doc"))

  clean_vignettes("testVignettes")
  expect_false("new.tex" %in% dir("testVignettes/vignettes"))
  expect_false("new.pdf" %in% dir("testVignettes/inst/doc"))
})
