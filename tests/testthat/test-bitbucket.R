context("Bitbucket")

test_that("Bitbucket repos parsed correctly", {
  expect_equal(parse_bitbucket_repo("imanuelcostigan/devtest"),
    list(username = "imanuelcostigan", repo = "devtest"))
  expect_equal(parse_bitbucket_repo("imanuelcostigan/devtest@v1.2"),
    list(username = "imanuelcostigan", repo = "devtest", ref = "v1.2"))
  expect_equal(parse_bitbucket_repo("imanuelcostigan/devtest#1"),
    list(username = "imanuelcostigan", repo = "devtest",
      ref = bitbucket_pull("1")))
  expect_equal(parse_bitbucket_repo("imanuelcostigan/devtest/somerepo"),
    list(username = "imanuelcostigan", repo = "devtest", subdir = "somerepo"))
  expect_equal(parse_bitbucket_repo("imanuelcostigan/devtest/somerepo@v1.0"),
    list(username = "imanuelcostigan", repo = "devtest", subdir = "somerepo",
      ref = "v1.0"))
  expect_equal(parse_bitbucket_repo("imanuelcostigan/devtest/somerepo#1"),
    list(username = "imanuelcostigan", repo = "devtest", subdir = "somerepo",
      ref = bitbucket_pull("1")))
})

test_that("Bitbucket remote build works", {
  # Bitbucket API is not queried for this test
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  expect_equal(bitbucket_remote("imanuelcostigan/devtest")$repo, "devtest")
  expect_equal(bitbucket_remote("imanuelcostigan/devtest")$username, "imanuelcostigan")
  expect_equal(bitbucket_remote("imanuelcostigan/devtest/dir")$subdir, "dir")
  expect_equal(bitbucket_remote("imanuelcostigan/devtest@v1.2")$ref, "v1.2")
  expect_equal(bitbucket_remote("imanuelcostigan/devtest#1")$ref, "doc-branch")
  expect_equal(bitbucket_remote("imanuelcostigan/devtest#1")$username, "imanuelcostigan")
})
