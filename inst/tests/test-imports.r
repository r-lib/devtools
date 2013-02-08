context("Imports")

test_that("Imported objects are copied to package environment", {
  load_all("testNamespace")
  # This package imports the whole 'compiler' package and 'splines::polySpline'
  imp_env <- imports_env("testNamespace")

  # cmpfun is exported from compiler, so it should be in imp_env
  expect_identical(imp_env$cmpfun, compiler::cmpfun)

  # cmpSpecial is NOT exported from compiler, so it should not be in imp_env
  expect_true(exists("cmpSpecial", asNamespace("compiler")))
  expect_false(exists("cmpSpecial", imp_env))


  # 'polySpline' is a single object imported specifically from splines
  expect_true(exists("polySpline", imp_env))

  # 'interpSpline' is not imported from splines
  expect_false(exists("interpSpline", imp_env))

  unload("testNamespace")
  unload(inst("compiler"))
  unload(inst("splines"))
})
