context("Dependencies")

test_that("Warned about dependency versions", {
  # Should give a warning about grid version
  expect_warning(load_all("testImportVersion"), "Need grid >=")
  unload("testImportVersion")

  # TODO: Add check for NOT giving a warning about compiler version
  # Not possible with testthat?
})


test_that("Error on missing dependencies", {
  # Should give a warning about missing package
  expect_error(load_all("testImportMissing"), "missingpackage not available")

  # Loading process will be partially done; unload it
  unload("testImportMissing")
})

test_that("Packages in depends are required", {
  load_all("testDependMissing")
  expect_true("package:MASS" %in% search())
  unload("testDependMissing")
  detach("package:MASS", unload = TRUE)
})

test_that("Parse dependencies", {
  deps <- parse_deps("\nhttr (< 2.1),\nRCurl (>= 3),\nutils (== 2.12.1),\ntools,\nR (>= 2.10),\nmemoise")
  expect_equal(nrow(deps), 5)
  expect_false("R" %in% deps$name)

  expect_equal(deps$compare, c("<", ">=", "==", NA, NA))
  expect_equal(deps$version, c("2.1", "3", "2.12.1", NA, NA))


  # Invalid version specifications
  expect_error(parse_deps("\nhttr (< 2.1),\nRCurl (3.0)"))
  expect_error(parse_deps("\nhttr (< 2.1),\nRCurl ( 3.0)"))
  expect_error(parse_deps("\nhttr (< 2.1),\nRCurl (==3.0)"))
  expect_error(parse_deps("\nhttr (< 2.1),\nRCurl (==3.0 )"))
  expect_error(parse_deps("\nhttr (< 2.1),\nRCurl ( ==3.0)"))

  # This should be OK (no error)
  deps <- parse_deps("\nhttr (< 2.1),\nRCurl (==  3.0.1)")
  expect_equal(deps$compare, c("<", "=="))
  expect_equal(deps$version, c("2.1", "3.0.1"))
})
