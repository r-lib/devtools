context("Compiled DLLs")

test_that("unload() unloads DLLs from packages loaded with library()", {

  # Make a temp lib directory to install test package into
  old_libpaths <- .libPaths()
  tmp_libpath = file.path(tempdir(), "devtools_test")
  if (!dir.exists(tmp_libpath)) dir.create(tmp_libpath)
  .libPaths(c(tmp_libpath, .libPaths()))

  install("dll-load")
  expect_true(require(dllload))

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("dllload", dynlibs)))

  unload("dll-load")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("dllload", dynlibs)))

  # Reset the libpath
  .libPaths(old_libpaths)

  # Clean out compiled objects
  clean_dll("dll-load")
})


test_that("load_all() compiles and loads DLLs", {

  clean_dll("dll-load")

  load_all("dll-load", reset = TRUE)

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("dllload", dynlibs)))

  unload("dll-load")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("dllload", dynlibs)))


  # Loading again, and reloading
  # Should not re-compile (don't have a proper test for this)
  load_all("dll-load")
  expect_true(is.null(nulltest()))

  # load_all when already loaded
  # Should not re-compile (don't have a proper test for this)
  load_all("dll-load")
  expect_true(is.null(nulltest()))

  # Should re-compile (don't have a proper test for this)
  load_all("dll-load", recompile = TRUE)
  expect_true(is.null(nulltest()))
  unload("dll-load")

  # Clean out compiled objects
  clean_dll("dll-load")
})


test_that("Specific functions from DLLs listed in NAMESPACE can be called", {
  load_all("dll-load")

  # nulltest() uses the calling convention:
  # .Call("null_test", PACKAGE = "dllload")
  expect_true(is.null(nulltest()))

  # nulltest2() uses a specific C function listed in NAMESPACE, null_test2
  # null_test2 is an object in the packg_env
  # It uses this calling convention:
  # .Call(null_test2)
  expect_true(is.null(nulltest2()))
  nt2 <- ns_env("dll-load")$null_test2
  expect_equal(class(nt2), "NativeSymbolInfo")
  expect_equal(nt2$name, "null_test2")

  unload("dll-load")

  # Clean out compiled objects
  clean_dll("dll-load")
})
