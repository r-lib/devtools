context("Imports")

test_that("Imported objects are copied to package environment", {
  load_all("namespace")
  # This package imports the whole 'compiler' package and 'MASS::area'
  imp_env <- imports_env("namespace")

  # cmpfun is exported from compiler, so it should be in imp_env
  expect_identical(imp_env$cmpfun, compiler::cmpfun)

  # cmpSpecial is NOT exported from compiler, so it should not be in imp_env
  expect_true(exists("cmpSpecial", asNamespace("compiler")))
  expect_false(exists("cmpSpecial", imp_env))


  # 'area' is a single object imported specifically from MASS
  expect_true(exists("area", imp_env))

  # 'addterm' is not imported from MASS
  expect_false(exists("addterm", imp_env))

  unload("namespace")
  unload(inst("compiler"))
  unload(inst("MASS"))
})
