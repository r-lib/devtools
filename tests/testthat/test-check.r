context("Check")

test_that("sucessful check doesn't trigger error", {
  skip_on_cran()
  results <- check("testTest", document = FALSE, quiet = TRUE)

  expect_error(signal_check_results(results), NA)
  expect_equal(
    summarise_check_results(results),
    "0 errors | 0 warnings | 0 notes",
    fixed = TRUE
  )
})

test_that("check with NOTES captured", {
  skip_on_cran()

  results <- parse_check_results("check-results-note.log")

  expect_error(signal_check_results(results), NA)
  expect_error(
    signal_check_results(results, "note"),
    "0 errors | 0 warnings | 2 notes",
    fixed = TRUE
  )
})

test_that("check cran-comments", {
  skip_on_cran()

  # Create pseudo package that only contains
  # cran-comments.md, first with an ok comment
  # then with a bad winbuilder link.
  temp_dir <- tempfile()
  skip_if(dir.exists(temp_dir))
  dir.create(temp_dir)
  my_pkg <- list(path = temp_dir)
  class(my_pkg) <- "package"

  writeLines(
    c("This is a package update. The `rcnst` issue has been fixed.",
      "",
      "## Test environments",
      "* local MRAN R 3.4.3",
      "* ubuntu 14.04 (on travis-ci), R 3.4.3 and dev <https://travis-ci.org/HughParsonage/TeXCheckR>",
      "* win-builder (dev and release)",
      "",
      "## R CMD check results",
      "",
      "0 errors | 0 warnings | 0 notes", ""),
    con = file.path(temp_dir, "cran-comments.md")
  )
  expect_null(cran_comments(pkg = my_pkg))

  writeLines(
    c("This is a package update. The `rcnst` issue has been fixed.",
      "",
      "## Test environments",
      "* local MRAN R 3.4.3",
      "* ubuntu 14.04 (on travis-ci), R 3.4.3 and dev <https://travis-ci.org/HughParsonage/TeXCheckR>",
      "* win-builder (dev and release) <https://win-builder.r-project.org/goBi3K29QiuZ/00check.log>",
      "",
      "## R CMD check results",
      "",
      "0 errors | 0 warnings | 0 notes",
      ""),
    con = file.path(temp_dir, "cran-comments.md")
  )
  expect_warning(cran_comments(pkg = my_pkg),
                 regexp = "Links to win-builder results are ephemeral")

})
