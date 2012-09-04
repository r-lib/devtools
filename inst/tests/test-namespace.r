context("Namespace")

# Is e an ancestor environment of x?
is_ancestor_env <- function(e, x) {
  x_par <- parenvs(x, all = TRUE)

  for (p in x_par) {
    if (identical(e, p)) return(TRUE)
  }

  return(FALSE)
}


test_that("Loaded namespaces have correct version", {
  load_all("namespace")
  expect_identical(c(version="0.1"), getNamespaceVersion("namespace"))
  unload("namespace")
})

test_that("Exported objects are visible from global environment", {

  # a is listed as an export in NAMESPACE, b is not. But with load_all(),
  # they should both be visible in the global env.
  load_all("namespace")
  expect_equal(a, 1)
  expect_equal(b, 2)
  unload("namespace")


  # With export_all = FALSE, only the listed export should be visible
  # in the global env.
  load_all("namespace", export_all = FALSE)
  expect_equal(a, 1)
  expect_false(exists("b"))
  unload("namespace")
})

test_that("All objects are loaded into namespace environment", {
  load_all("namespace")
  nsenv <- ns_env("namespace")
  expect_equal(nsenv$a, 1)
  expect_equal(nsenv$b, 2)
  unload("namespace")
})


test_that("All objects are copied to package environment", {
  load_all("namespace")
  pkgenv <- pkg_env("namespace")
  expect_equal(pkgenv$a, 1)
  expect_equal(pkgenv$b, 2)
  unload("namespace")

  # With export_all = FALSE, only the listed export should be copied
  load_all("namespace", export_all = FALSE)
  pkgenv <- pkg_env("namespace")
  expect_equal(pkgenv$a, 1)
  expect_false(exists("b", envir = pkgenv))
  unload("namespace")
})


test_that("Unloading and reloading a package works", {
  load_all("namespace")
  expect_equal(a, 1)

  # A load_all() again without unloading shouldn't change things
  load_all("namespace")
  expect_equal(a, 1)

  # Unloading should remove objects
  unload("namespace")
  expect_false(exists('a'))

  # Loading again should work
  load_all("namespace")
  expect_equal(a, 1)

  # Loading with reset should work
  load_all("namespace", reset = TRUE)
  expect_equal(a, 1)

  unload("namespace")
})

test_that("Namespace, imports, and package environments have correct hierarchy", {
  load_all("namespace")

  pkgenv <- pkg_env("namespace")
  nsenv  <- ns_env("namespace")
  impenv <- imports_env("namespace")

  expect_identical(parenvs(nsenv)[[2]], impenv)
  expect_identical(parenvs(nsenv)[[3]], .BaseNamespaceEnv)
  expect_identical(parenvs(nsenv)[[4]], .GlobalEnv)

  # pkgenv should be an ancestor of the global environment
  expect_true(is_ancestor_env(pkgenv, .GlobalEnv))

  unload("namespace")
})


test_that("unload() removes package environments from search", {
  load_all("namespace")
  pkgenv <- pkg_env("namespace")
  nsenv   <- ns_env("namespace")
  unload("namespace")
  unload(inst("compiler"))
  unload(inst("splines"))

  # Should report not loaded for package and namespace environments
  expect_false(is_attached("namespace"))
  expect_false(is_loaded("namespace"))

  # R's asNamespace function should error
  expect_error(asNamespace("namespace"))

  # pkgenv should NOT be an ancestor of the global environment
  # This is what makes the objects inaccessible from global env
  expect_false(is_ancestor_env(pkgenv, .GlobalEnv))
  # Another check of same thing
  expect_false(pkg_env_name("namespace") %in% search())

})


test_that("Environments have the correct attributes", {
  load_all("namespace")
  pkgenv <- pkg_env("namespace")
  impenv <- imports_env("namespace")

  # as.environment finds the same package environment
  expect_identical(pkgenv, as.environment("package:namespace"))

  # Check name attribute of package environment
  expect_identical(attr(pkgenv, "name"), "package:namespace")

  # Check path attribute of package environment
  wd <- normalizePath(devtest("namespace"))
  expect_identical(wd, attr(pkgenv, "path"))

  # Check name attribute of imports environment
  expect_identical(attr(impenv, "name"), "imports:namespace")

  unload("namespace")
})
