context("git")

git_test_repo <- function() {
  d <- tempfile("")
  dir.create(d)
  r <- git2r::init(d)
  git2r::config(r, user.name = "user", user.email = "user@email.com")
  writeLines(character(), file.path(d, ".gitignore"))
  git2r::add(r, ".gitignore")
  git2r::commit(r, "initial")
  r
}

test_that("SHA for regular repository", {
  r <- git_test_repo()
  commit <- git2r::commits(r)[[1]]
  expect_false(git2r::is_commit(git2r_head(r)))
  expect_equal(git_repo_sha1(r), git2r_attrib(commit, "sha"))
})

test_that("SHA for detached head", {
  skip_on_cran()

  r <- git_test_repo()
  commit <- git2r::commits(r)[[1]]
  git2r::checkout(commit)
  expect_true(git2r::is_commit(git2r_head(r)))
  expect_equal(git_repo_sha1(r), git2r_attrib(commit, "sha"))
})
