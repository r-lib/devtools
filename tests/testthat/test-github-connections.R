context("git usage and GitHub connections")

test_that("git (non-)usage is detected, diagnosed, and can be added", {
  skip_on_cran()

  test_pkg <- create_in_temp("testNoGit")

  expect_false(uses_git(test_pkg))
  expect_warning(expect_message(print(dr_github(test_pkg)),
                                "not a git repository"),
                 'DR_GITHUB FOUND PROBLEMS')

  expect_message(use_git_with_config(message = "initial", pkg = test_pkg, add_user_config = TRUE),
                 "Initialising repo")
  expect_true(uses_git(test_pkg))

  erase(test_pkg)

})

test_that("GitHub non-usage is handled", {
  skip_on_cran()

  test_pkg <- create_in_temp("testNoGitHub")
  use_git_with_config(message = "initial", pkg = test_pkg, add_user_config = TRUE, quiet = TRUE)

  expect_true(uses_git(test_pkg))
  expect_false(uses_github(test_pkg))
  expect_warning(expect_message(print(dr_github(test_pkg)),
                                "not a GitHub repository"),
                 "DR_GITHUB FOUND PROBLEMS")

  expect_identical(github_dummy, github_info(test_pkg))

  expect_error(use_github_links(test_pkg), "Cannot detect .* GitHub")

  erase(test_pkg)

})

## If env var GITHUB_PAT exists and there's willingness to call GitHub
## use_github() could be tested right around here.
## As it stands, that function is not under automated testing.

test_that("github info and links can be queried and manipulated", {
  skip_on_cran()

  test_pkg <- create_in_temp("testGitHub")
  mock_use_github(test_pkg)

  expect_true(uses_github(test_pkg))

  gh_info <- github_info(test_pkg)
  expect_equal(gh_info$username, "hadley")
  expect_equal(gh_info$repo, "devtools")

  desc_path <- file.path(test_pkg, "DESCRIPTION")
  desc <- read_dcf(desc_path)

  ## default GitHub links created by use_github_links() via use_github()
  expect_identical(desc[["URL"]],
                   file.path("https://github.com",
                             gh_info$username, gh_info$repo))
  expect_identical(desc[["BugReports"]],
                   file.path("https://github.com",
                             gh_info$username, gh_info$repo, "issues"))

  ## make sure we don't clobber existing links
  mtime_before <- file.info(desc_path)$mtime
  expect_message(use_github_links(test_pkg), "found and preserved")
  mtime_after <- file.info(desc_path)$mtime
  expect_identical(mtime_before, mtime_after)

  ## make sure we diagnose lack of GitHub links
  desc$URL <- "http://www.example.com"
  desc$BugReports <- "http://www.example.com/issues"
  write_dcf(desc_path, desc)
  expect_warning(expect_message(print(dr_github(test_pkg)),
                                "no GitHub repo link"),
                 "DR_GITHUB FOUND PROBLEMS")
  expect_warning(expect_message(print(dr_github(test_pkg)),
                                "no GitHub Issues"),
                 "DR_GITHUB FOUND PROBLEMS")

  erase(test_pkg)

})

test_that("github_info() prefers, but doesn't require, remote named 'origin'", {
  skip_on_cran()

  test_pkg <- create_in_temp("testGitHubInfo")
  mock_use_github(test_pkg)

  r <- git2r::repository(test_pkg, discover = TRUE)
  git2r::remote_add(r, "anomaly",
    "https://github.com/twitter/AnomalyDetection.git")

  ## defaults to "origin"
  expect_equal(github_info(test_pkg)$username, "hadley")
  expect_equal(github_info(test_pkg)$repo, "devtools")

  ## another remote will be used if no "origin"
  git2r::remote_rename(r, "origin", "zzz")
  gh_info <- github_info(test_pkg)
  expect_equal(gh_info$username, "twitter")
  expect_equal(gh_info$repo, "AnomalyDetection")
  git2r::remote_rename(r, "zzz", "origin")

  ## another remote can be requested by name
  gh_info <- github_info(test_pkg, remote_name = "anomaly")
  expect_equal(gh_info$username, "twitter")
  expect_equal(gh_info$repo, "AnomalyDetection")

  ## error if nonexistent remote requested by name
  expect_error(github_info(test_pkg, remote_name = "nope"))

  erase(test_pkg)

})

test_that("username and repo are extracted from github remote URL", {
  gh_info <- list(username = "hadley", repo = "devtools",
                  fullname = "hadley/devtools")
  expect_identical(github_remote_parse("https://github.com/hadley/devtools.git"), gh_info)
  expect_identical(github_remote_parse("https://github.com/hadley/devtools"), gh_info)
  expect_identical(github_remote_parse("git@github.com:hadley/devtools.git"), gh_info)
})
