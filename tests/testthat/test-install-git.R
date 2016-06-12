context("Install git submodules")

goldStandard <- list(name = "testRepo",
                     path = "testRepo",
                     url = "http://github.com/user/testRepo",
                     branch = NULL)

gitmodule <- '[submodule "testRepo"]
	path = testRepo
url = http://github.com/user/testRepo'

test_that("parse_module returns null branch when none is given", {
  expect_equal(parse_module(gitmodule), goldStandard)
})

goldStandard <- list(name = "testRepo",
                     path = "testRepo",
                     url = "http://github.com/user/testRepo",
                     branch = "devel")

gitmodule <- '[submodule "testRepo"]
	path = testRepo
url = http://github.com/user/testRepo
branch = devel'

test_that("parse_module returns devel branch when devel is given", {
  expect_equal(parse_module(gitmodule), goldStandard)
})

