context("Repo parameter parser")

test_that("Repo parameter is parsed correctly", {
  expect_equal(parse_repo_param("devtools"), list(repo="devtools"))
  expect_equal(parse_repo_param("krlmlr/kimisc"), list(username="krlmlr", repo="kimisc"))
  expect_equal(parse_repo_param("my/test/pkg"), list(username="my", repo="test", subdir="pkg"))
  expect_equal(parse_repo_param("devtools@devtools-1.4"), list(repo="devtools", ref="devtools-1.4"))
  expect_equal(parse_repo_param("yihui/tikzDevice#23"), list(username="yihui", repo="tikzDevice", pull="23"))
  expect_equal(parse_repo_param("my/test/pkg@ref"), list(username="my", repo="test", subdir="pkg", ref="ref"))
  expect_equal(parse_repo_param("my/test/pkg#1"), list(username="my", repo="test", subdir="pkg", pull="1"))
  expect_error(parse_repo_param("test#6@123"), "Invalid GitHub path")
})
