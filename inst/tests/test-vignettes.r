context("Vignettes")

test_that("Building process works", {
  # Warn about vignette in wrong location
  expect_warning(build_vignettes("testVignettes"), "old.Rnw")

  # Check inst/doc doesn't contain artefacts of complication
  expect_equal(length(dir("testVignettes/inst/doc")), 3)

  clean_vignettes("testVignettes")
  # Check new.pdf gone
  expect_equal(length(dir("testVignettes/inst/doc")), 2)
})
