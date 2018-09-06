## set-up and tear-down
create_in_temp <- function(pkg) {
  temp_path <- tempfile(pattern = "devtools-test-")
  dir.create(temp_path)
  test_pkg <- file.path(temp_path, pkg)
  capture.output(suppressMessages(usethis::create_package(test_pkg, fields = list())))
  local_proj(test_pkg, .local_envir = parent.frame())
  test_pkg
}

erase <- function(path) unlink(path, recursive = TRUE)

## fake GitHub connectivity: set a GitHub remote and add GitHub links
mock_use_github <- function(pkg) {
  use_git_with_config(message = "initial", pkg = pkg, add_user_config = TRUE, quiet = TRUE)
  r <- git2r::repository(pkg)
  git2r::remote_add(r, "origin", "https://github.com/r-lib/devtools.git")

  # TODO:(jimhester) Remove withr::with_dir once
  # https://github.com/r-lib/usethis/commit/9d91022aab2d5f58952cb7852000500dd22a07a0
  # is on CRAN
  withr::with_output_sink(
    "ignore",
    withr::with_dir(pkg, usethis::use_github_links())
  )
  unlink("ignore")
  git2r::add(r, "DESCRIPTION")
  git2r::commit(r, "Add GitHub links to DESCRIPTION")
  invisible(NULL)
}
