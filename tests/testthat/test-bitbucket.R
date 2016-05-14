context("Bitbucket")

test_that("Bitbucket API prefix is correct", {
  expect_equal(bitbucket_host(), "api.bitbucket.org")
  expect_equal(bitbucket_host("api.corpbitbucket.org"), "api.corpbitbucket.org")
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

test_that("Bitbucket remote build works", {
  # bitbucket_remote requires the OAuth token to be available in $HOME. So
  # skip these tests on CI plaforms / CRAN.
  skip_on_travis()
  skip_on_appveyor()
  skip_on_cran()
  # Mock resolve_ref so that Bitbucket API is not queried for this test
  mock_bitbucket_resolve_ref.bitbucket_pull <- function(x, params) {
    params$username <- sprintf("user-%s", x)
    params$ref <- sprintf("pull-%s", x)
    params
  }
  with_mock(bitbucket_resolve_ref.bitbucket_pull = mock_bitbucket_resolve_ref.bitbucket_pull, {
    expect_equal(bitbucket_remote("imanuelcostigan/devtest")$repo, "devtest")
    expect_equal(bitbucket_remote("imanuelcostigan/devtest")$username, "imanuelcostigan")
    expect_equal(bitbucket_remote("imanuelcostigan/devtest/dir")$subdir, "dir")
    expect_equal(bitbucket_remote("imanuelcostigan/devtest@v1.2")$ref, "v1.2")
    expect_equal(bitbucket_remote("imanuelcostigan/devtest#1")$ref, "pull-1")
    expect_equal(bitbucket_remote("imanuelcostigan/devtest#1")$ref, "pull-1")
    expect_equal(bitbucket_remote("imanuelcostigan/devtest#1")$username, "user-1")
  })
})


