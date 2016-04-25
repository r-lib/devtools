context("Bitbucket")

test_that("Bitbucket API prefix is correct", {
  expect_equal(bitbucket_api_prefix(), "api.bitbucket.org")
  expect_equal(bitbucket_api_prefix("api.corpbitbucket.org"),
    "api.corpbitbucket.org")
})

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


