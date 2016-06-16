context("remote_deps")
test_that("remote_deps returns NULL if no remotes specified", {
  expect_equal(remote_deps("testTest"), NULL)
})


test_that("remote_deps returns works with implicit types", {
  with_mock(`devtools::package2remote` = function(...) NULL, {
    expect_equal(parse_one_remote("hadley/testthat"),
      github_remote("hadley/testthat"))

    expect_equal(parse_one_remote("klutometis/roxygen"),
      github_remote("klutometis/roxygen"))
  })

  expect_equal(split_remotes("hadley/testthat,klutometis/roxygen"),
      c("hadley/testthat", "klutometis/roxygen"))

  expect_equal(split_remotes("hadley/testthat,\n  klutometis/roxygen"),
    c("hadley/testthat", "klutometis/roxygen"))

  expect_equal(split_remotes("hadley/testthat,\n\t klutometis/roxygen"),
    c("hadley/testthat", "klutometis/roxygen"))
})

test_that("dev_remote_type errors", {
  expect_error(parse_one_remote(""),
    "Malformed remote specification ''")

  expect_error(parse_one_remote("git::testthat::blah"),
    "Malformed remote specification 'git::testthat::blah'")
  expect_error(parse_one_remote("hadley::testthat"),
    "Unknown remote type: hadley")
  expect_error(parse_one_remote("SVN2::testthat"),
    "Unknown remote type: SVN2")
})

test_that("dev_remote_type works with explicit types", {
  with_mock(`devtools::package2remote` = function(...) NULL, {
    expect_equal(parse_one_remote("github::hadley/testthat"),
      github_remote("hadley/testthat"))
  })

  expect_equal(split_remotes("github::hadley/testthat,klutometis/roxygen"),
    c("github::hadley/testthat", "klutometis/roxygen"))

  expect_equal(split_remotes("hadley/testthat,github::klutometis/roxygen"),
    c("hadley/testthat", "github::klutometis/roxygen"))

  expect_equal(split_remotes("github::hadley/testthat,github::klutometis/roxygen"),
    c("github::hadley/testthat", "github::klutometis/roxygen"))

  expect_equal(split_remotes("bioc::user:password@release/Biobase#12345,github::klutometis/roxygen"),
    c("bioc::user:password@release/Biobase#12345", "github::klutometis/roxygen"))
})

test_that("different_sha returns TRUE if remote or local sha is NA not found", {
  expect_true(different_sha(remote_sha = NA, local_sha = "4a2ea2"))
  expect_true(different_sha(remote_sha = "4a2ea2", local_sha = NA))
  expect_true(different_sha(remote_sha = NA, local_sha = NA))
})
test_that("different_sha returns TRUE if remote_sha and local_sha are different", {
  expect_true(different_sha(remote_sha = "5b3fb3", local_sha = "4a2ea2"))
})
test_that("different_sha returns FALSE if remote_sha and local_sha are the same", {
  expect_false(different_sha(remote_sha = "4a2ea2", local_sha = "4a2ea2"))
})
test_that("local_sha returns NA if package is not installed", {
  expect_equal(local_sha("tsrtarst"), NA_character_)
})
test_that("remote_sha.github_remote returns NA if remote doesn't exist", {
  expect_equal(remote_sha(github_remote("arst/arst")), NA_character_)
})
test_that("remote_sha.github_remote returns expected value if remote does exist", {
  expect_equal(remote_sha(github_remote("hadley/devtools@v1.8.0")), "ad9aac7b9a522354e1ff363a86f389e32cec181b")
})

test_that("package2remotes looks for the DESCRIPTION in .libPaths", {
   expect_equal(package2remote("testTest")$sha, NA_character_)
   withr::with_temp_libpaths({
     expect_equal(package2remote("testTest")$sha, NA_character_)
     install("testTest", quiet = TRUE)
     expect_equal(package2remote("testTest")$sha, "0.1")

     # Load the namespace, as packageDescription looks in loaded namespaces
     # first.
     loadNamespace("testTest")
    })
   expect_equal(package2remote("testTest")$sha, NA_character_)
})
