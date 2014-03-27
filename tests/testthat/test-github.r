context("GitHub")

test_that("GitHub repo paths are parsed correctly", {
  expect_equal(github_parse_path("devtools"), list(repo="devtools"))
  expect_equal(github_parse_path("krlmlr/kimisc"), list(username="krlmlr", repo="kimisc"))
  expect_equal(github_parse_path("my/test/pkg"), list(username="my", repo="test", subdir="pkg"))
  expect_equal(github_parse_path("devtools@devtools-1.4"), list(repo="devtools", ref="devtools-1.4"))
  expect_equal(github_parse_path("yihui/tikzDevice#23"), list(username="yihui", repo="tikzDevice", pull="23"))
  expect_equal(github_parse_path("my/test/pkg@ref"), list(username="my", repo="test", subdir="pkg", ref="ref"))
  expect_equal(github_parse_path("my/test/pkg#1"), list(username="my", repo="test", subdir="pkg", pull="1"))
  expect_error(github_parse_path("test#6@123"), "Invalid GitHub path")
  expect_error(github_parse_path("Teradata/teradataR/"), "Invalid GitHub path")
})

test_that("GitHub URL is constructed correctly", {
  # Mock github_pull_info() in a copy of github_get_conn() so that GitHub API is not queried for this test
  github_pull_info <- function(repo, username, pull) { list(username=sprintf("user-%s", pull), ref=sprintf("pull-%s", pull)) }
  github_get_conn <- devtools:::github_get_conn
  formals(github_get_conn) <- c(formals(github_get_conn), list(github_pull_info=github_pull_info))
  
  expect_equal(github_get_conn("devtools")$url, "https://github.com/hadley/devtools/archive/master.zip")
  expect_equal(github_get_conn("krlmlr/kimisc")$url, "https://github.com/krlmlr/kimisc/archive/master.zip")
  expect_equal(github_get_conn("my/test/pkg")$url, "https://github.com/my/test/archive/master.zip")
  expect_equal(github_get_conn("devtools@devtools-1.4")$url, "https://github.com/hadley/devtools/archive/devtools-1.4.zip")
  expect_equal(github_get_conn("yihui/tikzDevice#23", github_pull_info=github_pull_info)$url, "https://github.com/user-23/tikzDevice/archive/pull-23.zip")
  expect_equal(github_get_conn("my/test/pkg@ref")$url, "https://github.com/my/test/archive/ref.zip")
  expect_equal(github_get_conn("my/test/pkg#1", github_pull_info=github_pull_info)$url, "https://github.com/user-1/test/archive/pull-1.zip")
  expect_error(github_get_conn("test#6@123")$url, "Invalid GitHub path")
})

test_that("GitHub parameters are returned correctly", {
  # Mock github_pull_info() in a copy of github_get_conn() so that GitHub API is not queried for this test
  github_pull_info <- function(repo, username, pull) { list(username=sprintf("user-%s", pull), ref=sprintf("pull-%s", pull)) }
  github_get_conn <- devtools:::github_get_conn
  formals(github_get_conn) <- c(formals(github_get_conn), list(github_pull_info=github_pull_info))
  
  expect_equal(github_get_conn("devtools")$repo, "devtools")
  expect_equal(github_get_conn("krlmlr/kimisc")$username, "krlmlr")
  expect_equal(github_get_conn("my/test/pkg")$subdir, "pkg")
  expect_equal(github_get_conn("devtools@devtools-1.4")$ref, "devtools-1.4")
  expect_equal(github_get_conn("yihui/tikzDevice#23", github_pull_info=github_pull_info)$pull, "23")
})
