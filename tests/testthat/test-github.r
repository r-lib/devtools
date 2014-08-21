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
  expect_equal(github_parse_path("devtools"), list(repo="devtools"))
  expect_equal(github_parse_path("krlmlr/kimisc"), list(username="krlmlr", repo="kimisc"))
  expect_equal(github_parse_path("my/test/pkg"), list(username="my", repo="test", subdir="pkg"))
  expect_equal(github_parse_path("devtools@devtools-1.4"), list(repo="devtools", ref="devtools-1.4"))
  expect_equal(github_parse_path("yihui/tikzDevice#23"), list(username="yihui", repo="tikzDevice", ref=github_pull("23")))
  expect_equal(github_parse_path("my/test/pkg@ref"), list(username="my", repo="test", subdir="pkg", ref="ref"))
  expect_equal(github_parse_path("my/test/pkg#1"), list(username="my", repo="test", subdir="pkg", ref=github_pull("1")))
  expect_error(github_parse_path("test#6@123"), "Invalid GitHub path")
  expect_error(github_parse_path("Teradata/teradataR/"), "Invalid GitHub path")
})

# Mock github_ref.github_pull so that GitHub API is not queried for this test
mock_github_ref.github_pull <- function(x, param) {
  list(username=sprintf("user-%s", x), ref=sprintf("pull-%s", x))
}

test_that("GitHub URL is constructed correctly", {
  with_mock("github_ref.github_pull", mock_github_ref.github_pull, {
    expect_equal(github_get_conn("krlmlr/kimisc")$url, "https://github.com/krlmlr/kimisc/archive/master.zip")
    expect_equal(github_get_conn("my/test/pkg")$url, "https://github.com/my/test/archive/master.zip")
    expect_equal(github_get_conn("hadley/devtools@devtools-1.4")$url, "https://github.com/hadley/devtools/archive/devtools-1.4.zip")
    expect_equal(github_get_conn("yihui/tikzDevice#23")$url, "https://github.com/user-23/tikzDevice/archive/pull-23.zip")
    expect_equal(github_get_conn("my/test/pkg@ref")$url, "https://github.com/my/test/archive/ref.zip")
    expect_equal(github_get_conn("my/test/pkg#1")$url, "https://github.com/user-1/test/archive/pull-1.zip")
    expect_error(github_get_conn("hadley/test#6@123")$url, "Invalid GitHub path")
  })
})

test_that("GitHub parameters are returned correctly", {
  with_mock("github_ref.github_pull", mock_github_ref.github_pull, {
    expect_equal(github_get_conn("hadley/devtools")$repo, "devtools")
    expect_equal(github_get_conn("krlmlr/kimisc")$username, "krlmlr")
    expect_equal(github_get_conn("my/test/pkg")$subdir, "pkg")
    expect_equal(github_get_conn("hadley/devtools@devtools-1.4")$ref, "devtools-1.4")
    expect_equal(github_get_conn("yihui/tikzDevice#23", github_ref.pull=github_ref.pull)$ref, "pull-23")
  })
})
