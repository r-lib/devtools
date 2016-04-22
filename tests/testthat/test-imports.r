context("Imports")

test_that("Imported objects are copied to package environment", {
  load_all("testNamespace")
  # This package imports the whole 'compiler' package, bitops::bitAnd, and
  # bitops::bitOr.
  imp_env <- imports_env("testNamespace")

  # cmpfun is exported from compiler, so it should be in imp_env
  expect_identical(imp_env$cmpfun, compiler::cmpfun)

  # cmpSpecial is NOT exported from compiler, so it should not be in imp_env
  expect_true(exists("cmpSpecial", asNamespace("compiler")))
  expect_false(exists("cmpSpecial", imp_env))


  # 'bitAnd' is a single object imported specifically from bitops
  expect_true(exists("bitAnd", imp_env))

  # 'bitFlip' is not imported from bitops
  expect_false(exists("bitFlip", imp_env))

  unload("testNamespace")
  unload(inst("compiler"))
  unload(inst("bitops"))
})


test_that("Imported objects are be re-exported", {
  load_all("testNamespace")
  # bitAnd is imported and re-exported
  expect_identical(bitAnd, bitops::bitAnd)
  # bitOr is imported but not re-exported
  expect_false(exists("bitOr", .GlobalEnv))
  unload("testNamespace")
  unload(inst("compiler"))
  unload(inst("bitops"))

  # Same as previous, but with export_all = FALSE
  load_all("testNamespace", export_all = FALSE)
  expect_identical(bitAnd, bitops::bitAnd)
  expect_false(exists("bitOr", .GlobalEnv))
  unload("testNamespace")
  unload(inst("compiler"))
  unload(inst("bitops"))
})
