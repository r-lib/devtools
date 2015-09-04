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

erase_test_pkg <- function(pkg_path) unlink(pkg_path, recursive = TRUE)

github_delete_repo <- function(pkg_path) {
  gh_info <- github_dummy
  if (exists(pkg_path) && uses_git(pkg_path)) {
    r <- git2r::repository(pkg_path, discover = TRUE)
    gh_info <- github_info(r)
  }
  if (gh_info$username == "<USERNAME>")
    gh_info$username <- system("git config --global --get user.name",
                               intern = TRUE)
  if (gh_info$repo == "<REPO>")
    gh_info$repo <- basename(pkg_path)

  auth <- github_auth(github_pat())

  search_term <- paste0("repo:", gh_info$username, "/", gh_info$repo)
  req <- httr::GET("https://api.github.com/",
                   path = file.path("search", "repositories"), auth,
                   query = list(q = search_term))
  if (httr::status_code(req) != 200) {
    httr::http_status(req)
    return(invisible(FALSE))
  }

  ## now that this is exists only here, I have disabled this
  #   if (confirm) {
  #     are_you_sure <- paste0("Are you absolutely sure you want to delete ",
  #                            username, "/", repo, " from GitHub?")
  #     if (!identical(1L, menu(c("Yes", "No"), title = are_you_sure)))
  #       return(invisible(FALSE))
  #   }

  req <- httr::DELETE("https://api.github.com/", auth,
                      path = file.path("repos", gh_info$username, gh_info$repo))
  if (httr::status_code(req) == 204) {
    return(invisible(TRUE))
  } else {
    github_response(req)
    return(invisible(FALSE))
  }

}

test_pkg <- create_test_pkg("testGithub")
suppressMessages(github_delete_repo(test_pkg))

test_that("git non-usage is detected", {
  expect_false(uses_git(test_pkg))
  expect_message(print(dr_github(test_pkg)), "not a git repository")
})

test_that("git usage can be added, then detected", {
  expect_message(use_git(pkg = test_pkg), "Initialising repo")
  expect_true(uses_git(test_pkg))
})

test_that("github non-usage is detected and diagnosed", {
  expect_false(uses_github(test_pkg))
  expect_message(print(dr_github(test_pkg)), "cannot detect .* GitHub")
})

test_that("empty URL and BugReports is diagnosed", {
  expect_message(print(dr_github(test_pkg)), "empty URL field")
  expect_message(print(dr_github(test_pkg)), "empty BugReports field")
})

test_that("dummy github info is returned when no github usage", {
  expect_identical(github_dummy, github_info(test_pkg))
})

test_that("github links are not added if no github usage", {
  expect_error(use_github_links(test_pkg), "Cannot detect .* GitHub")
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

  desc <- read_dcf(file.path(test_pkg, "DESCRIPTION"))
  gh_info <- github_info(test_pkg)
  expect_identical(desc[["URL"]],
                  file.path("https://github.com",
                            gh_info$username, gh_info$repo))
  expect_identical(desc[["BugReports"]],
                   file.path("https://github.com",
                             gh_info$username, gh_info$repo, "issues"))
})

test_that("pre-existing URL and BugReports are not clobbered", {

  skip_no_auth()

  desc_path <- file.path(test_pkg, "DESCRIPTION")
  mtime_before <- file.mtime(desc_path)
  expect_message(use_github_links(test_pkg), "found and preserved")
  mtime_after <- file.mtime(desc_path)
  expect_identical(mtime_before, mtime_after)

})

test_that("lack of GitHub links is diagnosed", {

  skip_no_auth()

  desc_path <- file.path(test_pkg, "DESCRIPTION")
  desc <- new_desc <- read_dcf(desc_path)
  new_desc$URL <- "http://www.example.com"
  new_desc$BugReports <- "http://www.example.com/issues"
  write_dcf(desc_path, new_desc)
  expect_message(print(dr_github(test_pkg)), "no GitHub repo link")
  expect_message(print(dr_github(test_pkg)), "no GitHub Issues")
  write_dcf(desc_path, desc)

})

test_that("github_info() prefers, but doesn't require, remote named 'origin'", {

  skip_no_auth()

  r <- git2r::repository(test_pkg, discover = TRUE)
  git2r::remote_add(r, "anomaly",
                    "https://github.com/twitter/AnomalyDetection.git")

  ## defaults to "origin"
  expect_identical(list(username = git2r::config(r)[["global"]][["user.name"]],
                        repo = "testGithub"),
                   github_info(test_pkg))

  ## another remote will be used if no "origin"
  git2r::remote_rename(r, "origin", "zzz")
  expect_identical(list(username = "twitter", repo = "AnomalyDetection"),
                   github_info(test_pkg))
  git2r::remote_rename(r, "zzz", "origin")

  ## another remote can be requested by name
  expect_identical(list(username = "twitter", repo = "AnomalyDetection"),
                   github_info(test_pkg, remote_name = "anomaly"))
})

test_that("github_info() errors if nonexistent remote requested by name", {

  skip_no_auth()

  r <- git2r::repository(test_pkg, discover = TRUE)
  expect_error(github_info(test_pkg, remote_name = "nope"))
})

suppressMessages(github_delete_repo(test_pkg))
erase_test_pkg(test_pkg)
