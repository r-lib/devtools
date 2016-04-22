context("Namespace")

# Is e an ancestor environment of x?
is_ancestor_env <- function(e, x) {
  if (identical(e, x))
    return(TRUE)
  else if (identical(x, emptyenv()))
    return(FALSE)
  else
    is_ancestor_env(e, parent.env(x))
}

# Get parent environment n steps deep
parent_env <- function(e, n = 1) {
  if (n == 0)
    e
  else
    parent_env(parent.env(e), n-1)
}

test_that("Loaded namespaces have correct version", {
  load_all("testNamespace")
  expect_identical(c(version="0.1"), getNamespaceVersion("testNamespace"))
  unload("testNamespace")
})

test_that("Exported objects are visible from global environment", {

  # a is listed as an export in NAMESPACE, b is not. But with load_all(),
  # they should both be visible in the global env.
  load_all("testNamespace")
  expect_equal(a, 1)
  expect_equal(b, 2)
  unload("testNamespace")


  # With export_all = FALSE, only the listed export should be visible
  # in the global env.
  load_all("testNamespace", export_all = FALSE)
  expect_equal(a, 1)
  expect_false(exists("b"))
  unload("testNamespace")
})


test_that("Missing exports don't result in error", {
  expect_warning(load_all("testMissingNsObject"))
  nsenv <- ns_env("testMissingNsObject")
  expect_equal(nsenv$a, 1)
  unload("testMissingNsObject")
})


test_that("All objects are loaded into namespace environment", {
  load_all("testNamespace")
  nsenv <- ns_env("testNamespace")
  expect_equal(nsenv$a, 1)
  expect_equal(nsenv$b, 2)
  unload("testNamespace")
})


test_that("All objects are copied to package environment", {
  load_all("testNamespace")
  pkgenv <- pkg_env("testNamespace")
  expect_equal(pkgenv$a, 1)
  expect_equal(pkgenv$b, 2)
  unload("testNamespace")

  # With export_all = FALSE, only the listed export should be copied
  load_all("testNamespace", export_all = FALSE)
  pkgenv <- pkg_env("testNamespace")
  expect_equal(pkgenv$a, 1)
  expect_false(exists("b", envir = pkgenv))
  unload("testNamespace")
})


test_that("Unloading and reloading a package works", {
  load_all("testNamespace")
  expect_equal(a, 1)

  # A load_all() again without unloading shouldn't change things
  load_all("testNamespace")
  expect_equal(a, 1)

  # Unloading should remove objects
  unload("testNamespace")
  expect_false(exists('a'))

  # Loading again should work
  load_all("testNamespace")
  expect_equal(a, 1)

  # Loading with reset should work
  load_all("testNamespace", reset = TRUE)
  expect_equal(a, 1)

  unload("testNamespace")
})

test_that("Namespace, imports, and package environments have correct hierarchy", {
  load_all("testNamespace")

  pkgenv <- pkg_env("testNamespace")
  nsenv  <- ns_env("testNamespace")
  impenv <- imports_env("testNamespace")

  expect_identical(parent_env(nsenv, 1), impenv)
  expect_identical(parent_env(nsenv, 2), .BaseNamespaceEnv)
  expect_identical(parent_env(nsenv, 3), .GlobalEnv)

  # pkgenv should be an ancestor of the global environment
  expect_true(is_ancestor_env(pkgenv, .GlobalEnv))

  unload("testNamespace")
})


test_that("unload() removes package environments from search", {
  load_all("testNamespace")
  pkgenv <- pkg_env("testNamespace")
  nsenv   <- ns_env("testNamespace")
  unload("testNamespace")
  unload(inst("compiler"))
  unload(inst("bitops"))

  # Should report not loaded for package and namespace environments
  expect_false(is_attached("testNamespace"))
  expect_false(is_loaded("testNamespace"))

  # R's asNamespace function should error
  expect_error(asNamespace("testNamespace"))

  # pkgenv should NOT be an ancestor of the global environment
  # This is what makes the objects inaccessible from global env
  expect_false(is_ancestor_env(pkgenv, .GlobalEnv))
  # Another check of same thing
  expect_false(pkg_env_name("testNamespace") %in% search())

})


test_that("Environments have the correct attributes", {
  load_all("testNamespace")
  pkgenv <- pkg_env("testNamespace")
  impenv <- imports_env("testNamespace")

  # as.environment finds the same package environment
  expect_identical(pkgenv, as.environment("package:testNamespace"))

  # Check name attribute of package environment
  expect_identical(attr(pkgenv, "name"), "package:testNamespace")

  # Check path attribute of package environment
  if (has_tests()) {
    wd <- normalizePath(devtest("testNamespace"))
    expect_identical(wd, attr(pkgenv, "path"))
  }

  # Check name attribute of imports environment
  expect_identical(attr(impenv, "name"), "imports:testNamespace")

  unload("testNamespace")
})
