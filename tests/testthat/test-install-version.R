context("Install specific version")

local_archive <- function(x) {
  if (x == "http://cran.r-project.org")
    readRDS("archive.rds")
  else
    NULL
}

test_that("package_find_repo() works correctly with multiple repos", {

  # The archive format is not readable on older R versions
  # (`do not know how to convert 'value' to class "POSIXct"`)
  skip_if_not(getRversion() >= "3.2.0")
  repos <- c(CRANextras = "http://www.stats.ox.ac.uk/pub/RWin", CRAN = "http://cran.r-project.org")
  # ROI.plugin.glpk is the smallest package in the CRAN archive
  package <- "ROI.plugin.glpk"

  with_mock(`devtools:::read_archive` = local_archive,
    res <- package_find_repo(package, repos = repos)
  )

  expect_equal(NROW(res), 1L)
  expect_equal(res$repo, "http://cran.r-project.org")
  expect_true(all(grepl("^ROI.plugin.glpk", res$path)))
})

test_that("package_find_repo() works correctly with archived packages", {
  # Issue 1033

  skip_if_not(getRversion() >= "3.2.0")
  repos <- c(CRAN = "http://cran.r-project.org")
  package <- "igraph0"
  with_mock(`devtools:::read_archive` = local_archive,
    res <- package_find_repo(package, repos = repos)
  )

  expect_gte(NROW(res), 8L)
  expect_true(all(res$repo == "http://cran.r-project.org"))
  expect_true(all(grepl("^igraph0", res$path)))
})
