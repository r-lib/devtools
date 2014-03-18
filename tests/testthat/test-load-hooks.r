context("Load hooks")

test_that("hooks called in correct order", {
  record_use <- function(hook) {
    function(...) {
      h <- globalenv()$hooks
      h$events <- c(h$events, hook)
    }
  }
  reset_events <- function() {
    assign("hooks", new.env(parent = emptyenv()), env = globalenv())
    h <- globalenv()$hooks
    h$events <- character()
  }


  setHook(packageEvent("testHooks", "attach"), record_use("user_attach"))
  setHook(packageEvent("testHooks", "detach"), record_use("user_detach"))
  setHook(packageEvent("testHooks", "onLoad"),   record_use("user_load"))
  setHook(packageEvent("testHooks", "onUnload"), record_use("user_unload"))

  reset_events()
  load_all("testHooks")
  expect_equal(globalenv()$hooks$events,
    c("pkg_load", "user_load", "pkg_attach", "user_attach")
  )

  reset_events()
  load_all("testHooks", reset = FALSE)
  expect_equal(globalenv()$hooks$events, character())

  reset_events()
  unload("testHooks")
  expect_equal(globalenv()$hooks$events,
    c("user_detach", "pkg_detach", "user_unload", "pkg_unload")
  )

  rm(list = "hooks", envir = globalenv())
  setHook(packageEvent("testHooks", "attach"), NULL, "replace")
  setHook(packageEvent("testHooks", "detach"), NULL, "replace")
  setHook(packageEvent("testHooks", "onLoad"),   NULL, "replace")
  setHook(packageEvent("testHooks", "onUnload"), NULL, "replace")

})

test_that("onLoad and onAttach", {
  load_all("testLoadHooks")
  nsenv <- ns_env("testLoadHooks")
  pkgenv <- pkg_env("testLoadHooks")

  # normalizePath is needed so that capitalization differences on
  # case-insensitive platforms won't cause errors.
  expect_equal(normalizePath(nsenv$onload_lib), normalizePath(getwd()))
  expect_equal(normalizePath(nsenv$onattach_lib), normalizePath(getwd()))

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
  load_all("testLoadHooks", reset = FALSE)
  # Shouldn't form new environments
  expect_identical(nsenv, ns_env("testLoadHooks"))
  expect_identical(pkgenv, pkg_env("testLoadHooks"))

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
  load_all("testLoadHooks", reset = TRUE)
  nsenv2 <- ns_env("testLoadHooks")
  pkgenv2 <- pkg_env("testLoadHooks")
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

  unload("testLoadHooks")

  # ===================================================================
  # Unloading and reloading should create new environments and same
  # values as first time
  load_all("testLoadHooks")
  nsenv3 <- ns_env("testLoadHooks")
  pkgenv3 <- pkg_env("testLoadHooks")

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

  unload("testLoadHooks")
})



test_that("onUnload", {
  load_all("testLoadHooks")

  # The onUnload function in testLoadHooks increments this variable
  .GlobalEnv$.__testLoadHooks__ <- 1
  unload("testLoadHooks")
  expect_equal(.GlobalEnv$.__testLoadHooks__, 2)

  # Clean up
  rm(".__testLoadHooks__", envir = .GlobalEnv)
})
