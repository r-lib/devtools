## set-up and tear-down
create_in_temp <- function(pkg) {
  temp_path <- tempfile(pattern="devtools-test-")
  dir.create(temp_path)
  test_pkg <- file.path(temp_path, pkg)
  capture.output(suppressMessages(create(test_pkg, description = list())))
  test_pkg
}

erase <- function(path) unlink(path, recursive = TRUE)

## fake GitHub connectivity: set a GitHub remote and add GitHub links
mock_use_github <- function(pkg) {
  use_git_with_config(message = "initial", pkg = pkg, add_user_config = TRUE, quiet = TRUE)
  r <- git2r::repository(pkg)
  git2r::remote_add(r, "origin", "https://github.com/hadley/devtools.git")
  use_github_links(pkg)
  git2r::add(r, "DESCRIPTION")
  git2r::commit(r, "Add GitHub links to DESCRIPTION")
  invisible(NULL)
}
