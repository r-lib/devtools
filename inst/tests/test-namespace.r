context("Namespace")

# Is e an ancestor environment of x?
is_ancestor_env <- function(e, x) {
  x_par <- parent_envs(x, all = TRUE)

  for (p in x_par) {
    if (identical(e, p)) return(TRUE)
  }

  return(FALSE)
}


test_that("Package objects are visible from global environment", {

  # a is exported, b is not. With load_all(), they should by default
  # both be visible in the global env.
  load_all("namespace")
  expect_equal(a, 1)
  expect_equal(b, 2)
  unload("namespace")


  # With export_all = FALSE, only the exported object should be visible
  # in the global env.
  load_all("namespace", export_all = FALSE)
  expect_equal(a, 1)
  expect_false(exists("b"))
  unload("namespace")
})

test_that("All package objects are loaded into namespace environment", {
  load_all("namespace")
  nsenv <- ns_env("namespace")
  expect_equal(nsenv$a, 1)
  expect_equal(nsenv$b, 2)
  unload("namespace")
})


test_that("All package objects are copied to package environment", {
  load_all("namespace")
  pkgenv <- pkg_env("namespace")
  expect_equal(pkgenv$a, 1)
  expect_equal(pkgenv$b, 2)
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
  nsenv   <- ns_env("namespace")
  imp_env <- imports_env("namespace")


  expect_identical(parent_envs(nsenv)[[2]], imp_env)
  expect_identical(parent_envs(nsenv)[[3]], .BaseNamespaceEnv)
  expect_identical(parent_envs(nsenv)[[4]], .GlobalEnv)

  # pkgenv should be an ancestor of the global environment
  expect_true(is_ancestor_env(pkgenv, .GlobalEnv))

  # Import environment should have name attribute
  expect_equal(attr(imp_env, "name"), "imports:namespace")

  unload("namespace")
})


test_that("unload() removes package environments from search", {
  load_all("namespace")
  pkgenv <- pkg_env("namespace")
  nsenv   <- ns_env("namespace")
  imp_env <- imports_env("namespace")
  unload("namespace")
  unload(inst("compiler"))
  unload(inst("MASS"))

  # Should report not loaded for package and namespace environments
  expect_false(is.loaded_pkg("namespace"))
  expect_false(is.loaded_ns("namespace"))

  # R's asNamespace function should error
  expect_error(asNamespace("namespace"))

  # pkgenv should NOT be an ancestor of the global environment
  # This is what makes the objects inaccessible from global env
  expect_false(is_ancestor_env(pkgenv, .GlobalEnv))
  # Another check of same thing
  expect_false(env_pkg_name("namespace") %in% search())

})
