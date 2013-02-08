context("Compiled DLLs")

test_that("unload() unloads DLLs from packages loaded with library()", {

  # Make a temp lib directory to install test package into
  old_libpaths <- .libPaths()
  tmp_libpath = file.path(tempdir(), "devtools_test")
  if (!dir.exists(tmp_libpath)) dir.create(tmp_libpath)
  .libPaths(c(tmp_libpath, .libPaths()))

  install("testDllLoad", quiet = TRUE)
  expect_true(require(testDllLoad))

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("testDllLoad", dynlibs)))

  unload("testDllLoad")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("testDllLoad", dynlibs)))

  # Reset the libpath
  .libPaths(old_libpaths)

  # Clean out compiled objects
  clean_dll("testDllLoad")
})


test_that("load_all() compiles and loads DLLs", {

  clean_dll("testDllLoad")

  load_all("testDllLoad", reset = TRUE, quiet = TRUE)

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("testDllLoad", dynlibs)))

  unload("testDllLoad")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("testDllLoad", dynlibs)))


  # Loading again, and reloading
  # Should not re-compile (don't have a proper test for this)
  load_all("testDllLoad", quiet = TRUE)
  expect_true(is.null(nulltest()))

  # load_all when already loaded
  # Should not re-compile (don't have a proper test for this)
  load_all("testDllLoad", quiet = TRUE)
  expect_true(is.null(nulltest()))

  # Should re-compile (don't have a proper test for this)
  load_all("testDllLoad", recompile = TRUE, quiet = TRUE)
  expect_true(is.null(nulltest()))
  unload("testDllLoad")

  # Clean out compiled objects
  clean_dll("testDllLoad")
})


test_that("Specific functions from DLLs listed in NAMESPACE can be called", {
  load_all("testDllLoad", quiet = TRUE)

  # nulltest() uses the calling convention:
  # .Call("null_test", PACKAGE = "testDllLoad")
  expect_true(is.null(nulltest()))

  # nulltest2() uses a specific C function listed in NAMESPACE, null_test2
  # null_test2 is an object in the packg_env
  # It uses this calling convention:
  # .Call(null_test2)
  expect_true(is.null(nulltest2()))
  nt2 <- ns_env("testDllLoad")$null_test2
  expect_equal(class(nt2), "NativeSymbolInfo")
  expect_equal(nt2$name, "null_test2")

  unload("testDllLoad")

  # Clean out compiled objects
  clean_dll("testDllLoad")
})


test_that("load_all() can compile and load DLLs linked to Rcpp", {

  clean_dll("testDllRcpp")

  load_all("testDllRcpp", reset = TRUE, quiet = TRUE)

  # Check that it's loaded properly by calling the hello world function
  # which returns a list
  expect_true(is.list(rcpp_hello_world()))

  # Check whether attribute compilation occurred and that exported
  # names are available from load_all
  expect_true(rcpp_test_attributes())

  # Unload and clean out compiled objects
  unload("testDllRcpp")
  clean_dll("testDllRcpp")
})
