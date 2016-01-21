context("Install specific version")

test_that("package_find_repo() works correctly with multiple repos", {

  repos <- c(CRANextras = "http://www.stats.ox.ac.uk/pub/RWin", CRAN = "http://cran.rstudio.com")
  # ROI.plugin.glpk is the smallest package in the CRAN archive
  package <- "ROI.plugin.glpk"
  res <- package_find_repo(package, repos = repos)

  expect_equal(NROW(res), 1L)
  expect_equal(res$repo, "http://cran.rstudio.com")
  expect_match(rownames(res), package)
})
