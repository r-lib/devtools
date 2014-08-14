context("GitHub")

with_mock <- function(name, value, code) {
  env <- asNamespace("devtools")
  orig_value <- env[[name]]
  unlockBinding(name, env)
  env[[name]] <- value
  on.exit(env[[name]] <- orig_value)

  force(code)
}

test_that("GitHub repo paths are parsed correctly", {
  expect_equal(parse_git_repo("devtools"), list(repo="devtools"))
  expect_equal(parse_git_repo("krlmlr/kimisc"), list(username="krlmlr", repo="kimisc"))
  expect_equal(parse_git_repo("my/test/pkg"), list(username="my", repo="test", subdir="pkg"))
  expect_equal(parse_git_repo("devtools@devtools-1.4"), list(repo="devtools", ref="devtools-1.4"))
  expect_equal(parse_git_repo("yihui/tikzDevice#23"), list(username="yihui", repo="tikzDevice", ref=github_pull("23")))
  expect_equal(parse_git_repo("my/test/pkg@ref"), list(username="my", repo="test", subdir="pkg", ref="ref"))
  expect_equal(parse_git_repo("my/test/pkg#1"), list(username="my", repo="test", subdir="pkg", ref=github_pull("1")))
  expect_error(parse_git_repo("test#6@123"), "Invalid git repo")
  expect_error(parse_git_repo("Teradata/teradataR/"), "Invalid git repo")
})

# Mock github_ref.github_pull so that GitHub API is not queried for this test
mock_github_resolve_ref.github_pull <- function(x, params) {
  params$username <- sprintf("user-%s", x)
  params$ref <- sprintf("pull-%s", x)
  params
}

test_that("GitHub parameters are returned correctly", {
  with_mock("github_resolve_ref.github_pull", mock_github_resolve_ref.github_pull, {
    expect_equal(github_remote("hadley/devtools")$repo, "devtools")
    expect_equal(github_remote("krlmlr/kimisc")$username, "krlmlr")
    expect_equal(github_remote("my/test/pkg")$subdir, "pkg")
    expect_equal(github_remote("hadley/devtools@devtools-1.4")$ref, "devtools-1.4")
    expect_equal(github_remote("yihui/tikzDevice#23")$ref, "pull-23")
  })
})
