context("Load hooks")

test_that("onLoad and onAttach", {
  load_all("load-hooks")
  nsenv <- ns_env("load-hooks")
  pkgenv <- pkg_env("load-hooks")

  # a: modified by onLoad in namespace env
  # b: modified by onAttach in namespace env
  # c: modified by onAttach in package env
  # In a normal install+load, b can't be modified by onAttach because
  # the namespace is locked before onAttach. But it can be modified when
  # using load_all.
  expect_equal(nsenv$a, 2)
  expect_equal(nsenv$b, 2) # This would be 1 in normal install+load
  expect_equal(nsenv$c, 1)

  expect_equal(pkgenv$a, 2)
  expect_equal(pkgenv$b, 1)
  expect_equal(pkgenv$c, 2)


  # ===================================================================
  # Loading again without reset won't change a, b, and c in the
  # namespace env, and also shouldn't trigger onload or onattach. But
  # the existing namespace values will be copied over to the package
  # environment
  load_all("load-hooks")
  # Shouldn't form new environments
  expect_identical(nsenv, ns_env("load-hooks"))
  expect_identical(pkgenv, pkg_env("load-hooks"))

  # namespace and package env values should be the same
  expect_equal(nsenv$a, 2)
  expect_equal(nsenv$b, 2)
  expect_equal(nsenv$c, 1)
  expect_equal(pkgenv$a, 2)
  expect_equal(pkgenv$b, 2)
  expect_equal(pkgenv$c, 1)


  # ===================================================================
  # With reset=TRUE, there should be new package and namespace
  # environments, and the values should be the same as the first
  # load_all.
  load_all("load-hooks", reset = TRUE)
  nsenv2 <- ns_env("load-hooks")
  pkgenv2 <- pkg_env("load-hooks")
  # Should form new environments
  expect_false(identical(nsenv, nsenv2))
  expect_false(identical(pkgenv, pkgenv2))

  # Values should be same as first time
  expect_equal(nsenv2$a, 2)
  expect_equal(nsenv2$b, 2)
  expect_equal(nsenv2$c, 1)
  expect_equal(pkgenv2$a, 2)
  expect_equal(pkgenv2$b, 1)
  expect_equal(pkgenv2$c, 2)

  unload("load-hooks")

  # ===================================================================
  # Unloading and reloading should create new environments and same
  # values as first time
  load_all("load-hooks")
  nsenv3 <- ns_env("load-hooks")
  pkgenv3 <- pkg_env("load-hooks")

  # Should form new environments
  expect_false(identical(nsenv, nsenv3))
  expect_false(identical(pkgenv, pkgenv3))

  # Values should be same as first time
  expect_equal(nsenv3$a, 2)
  expect_equal(nsenv3$b, 2)
  expect_equal(nsenv3$c, 1)
  expect_equal(pkgenv3$a, 2)
  expect_equal(pkgenv3$b, 1)
  expect_equal(pkgenv3$c, 2)

  unload("load-hooks")
})



test_that("onUnload", {
  load_all("load-hooks")

  # The onUnload function in load-hooks increments this variable
  .GlobalEnv$.__loadhooks__ <- 1
  unload("load-hooks")
  expect_equal(.GlobalEnv$.__loadhooks__, 2)

  # Clean up
  rm(".__loadhooks__", envir = .GlobalEnv)
})
