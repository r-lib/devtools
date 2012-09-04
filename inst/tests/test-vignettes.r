context("Vignettes")

test_that("Building process works", {
  # Warn about vignette in wrong location
  expect_warning(build_vignettes("vignettes"), "old.Rnw")
  
  # Check inst/doc doesn't contain artefacts of complication
  expect_equal(length(dir("vignettes/inst/doc")), 3)
  
  clean_vignettes("vignettes")
  # Check new.pdf gone
  expect_equal(length(dir("vignettes/inst/doc")), 2)
})
