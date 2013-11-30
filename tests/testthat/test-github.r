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
})
