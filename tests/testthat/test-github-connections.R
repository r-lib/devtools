context("GitHub connections")

## set auth to TRUE if env var GITHUB_PAT is available (eg local testing)
## set auth to FALSE otherwise (eg on travis, at this point)
auth <- FALSE
skip_no_auth <- function() if (!exists("auth") || !auth) skip("no auth")

## why create a temporary test package & repo?
## if the package lives within tests/testthat like the other test packages,
## git2r::discover_repository "successfully" discovers the enclosing devtools
## repository, which prevents usage and testing of uses_git() and use_git()
## and, therefore, uses_github() and use_github()

create_test_pkg <- function(pkg_name = "testpkg") {
  capture.output( # necessary because write_dcf() uses cat()
    suppressMessages({
      path <- tempfile(pattern="devtools-test-")
      dir.create(path)
      path <- file.path(path, pkg_name)
      create(path, description = list(NULL))
    })
  )
  path
}

erase_test_pkg <- function(pkg_path) {
  capture.output( # necessary because github_request() returns parsed content
    suppressMessages({
      gh_info <- github_info(pkg_path)
      unlink(pkg_path, recursive = TRUE)
      github_delete_repo(gh_info$username, gh_info$repo)
    })
  )
  return(invisible())
}

test_pkg <- create_test_pkg("testGithub")

test_that("git non-usage is detected", {
  expect_false(uses_git(test_pkg))
  expect_message(print(dr_github(test_pkg)), "not a git repository")
})

test_that("git usage can be added, then detected", {
  expect_message(use_git(pkg = test_pkg), "Initialising repo")
  expect_true(uses_git(test_pkg))
})

test_that("github non-usage is detected", {
  expect_false(uses_github(test_pkg))
  expect_message(print(dr_github(test_pkg)), "cannot detect .* GitHub")
})

test_that("dummy github info is returned when no github usage", {
  expect_identical(github_dummy, github_info(test_pkg))
})

test_that("dummy github links are created, messaged, diagnosed", {
  DESCRIPTION_safe <- readLines(file.path(test_pkg, "DESCRIPTION"))
  expect_message(use_github_links(test_pkg), "Cannot detect .* GitHub")
  DESCRIPTION_new <- readLines(file.path(test_pkg, "DESCRIPTION"))
  expect_identical(grep("URL", DESCRIPTION_new, value = TRUE),
                   "URL: https://github.com/<USERNAME>/<REPO>")
  expect_identical(grep("BugReports", DESCRIPTION_new, value = TRUE),
                   "BugReports: https://github.com/<USERNAME>/<REPO>/issues")
  expect_message(print(dr_github(test_pkg)), "placeholder found")
  writeLines(DESCRIPTION_safe, file.path(test_pkg, "DESCRIPTION"))
})

test_that("github usage can be added and detected", {

  skip_no_auth()

  ## caveat: this is a very specific set of arg values
  ## if these tests are accepted, explore other combinations of args
  expect_message(use_github(private = TRUE, pkg = test_pkg, protocol = "https"),
                 "Creating GitHub repository")
  expect_true(uses_github(test_pkg))
  expect_identical("testGithub", github_info(test_pkg)$repo)
})

test_that("github links are created when adding github connection", {

  skip_no_auth()

  DESCRIPTION <- readLines(file.path(test_pkg, "DESCRIPTION"))
  gh_info <- github_info(test_pkg)
  expect_identical(grep("URL", DESCRIPTION, value = TRUE),
                   sprintf("URL: https://github.com/%s/%s",
                           gh_info$username, gh_info$repo))
  expect_identical(grep("BugReports", DESCRIPTION, value = TRUE),
                   sprintf("BugReports: https://github.com/%s/%s/issues",
                           gh_info$username, gh_info$repo))
})

test_that("github_info() prefers, but does not require, remote named 'origin'", {

  skip_no_auth()

  r <- git2r::repository(test_pkg, discover = TRUE)

  git2r::remote_add(r, "anomaly", "https://github.com/twitter/AnomalyDetection.git")
  expect_identical(list(username = "twitter", repo = "AnomalyDetection"),
                   github_info(test_pkg, remote_name = "anomaly"))
  expect_identical(list(username = git2r::config(r)[["global"]][["user.name"]],
                        repo = "testGithub"),
                   github_info(test_pkg))
  expect_error(github_info(test_pkg, remote_name = "nope"))

})

test_that("github_info() errors on specific request for nonexistent remote", {

  r <- git2r::repository(test_pkg, discover = TRUE)
  if (uses_github(test_pkg)) {
    # if skip_no_auth() in force, test_pkg is not GitHub'd
    expect_error(github_info(test_pkg, remote_name = "nope"))
  }


})

erase_test_pkg(test_pkg)
