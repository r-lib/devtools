context("Compiled DLLs")

test_that("unload() unloads DLLs from packages loaded with library()", {

  # Make a temp lib directory to install test package into
  old_libpaths <- .libPaths()
  tmp_libpath = file.path(tempdir(), "devtools_test")
  if (!dir.exists(tmp_libpath)) dir.create(tmp_libpath)
  .libPaths(c(tmp_libpath, .libPaths()))

  install("dll-unload")
  expect_true(require(dllunload))

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("dllunload", dynlibs)))

  unload("dll-unload")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("dllunload", dynlibs)))

  # Reset the libpath
  .libPaths(old_libpaths)

  # Clean out compiled objects
  clean_dll("dll-unload")
})


test_that("load_all() compiles and loads DLLs", {

  clean_dll("dll-unload")

  load_all("dll-unload", reset = TRUE)

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("dllunload", dynlibs)))

  unload("dll-unload")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("dllunload", dynlibs)))


  # Loading again, and reloading
  # Should not re-compile (don't have a proper test for this)
  load_all("dll-unload")
  expect_true(is.null(nulltest()))

  # load_all when already loaded
  # Should not re-compile (don't have a proper test for this)
  load_all("dll-unload")
  expect_true(is.null(nulltest()))

  # Should re-compile (don't have a proper test for this)
  load_all("dll-unload", recompile = TRUE)
  expect_true(is.null(nulltest()))
  unload("dll-unload")

  # Clean out compiled objects
  clean_dll("dll-unload")
})

