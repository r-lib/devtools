context("Compiled DLLs")

test_that("unload() unloads DLLs from packages loaded with library()", {

  # Make a temp lib directory to install test package into
  old_libpaths <- .libPaths()
  tmp_libpath = file.path(tempdir(), "devtools_test")
  dir.create(tmp_libpath)
  .libPaths(c(tmp_libpath, .libPaths()))

  install("unload-dll")
  expect_true(require(unloaddll))

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("unloaddll", dynlibs)))

  unload("unload-dll")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("unloaddll", dynlibs)))

  # Reset the libpath
  .libPaths(old_libpaths)

  # Clean out compiled objects
  clean_dll("unload-dll")
})


test_that("load_all() compiles and loads DLLs", {

  clean_dll("unload-dll")

  load_all("unload-dll", reset = TRUE)

  # Check that it's loaded properly, by running a function from the package.
  # nulltest() calls a C function which returns null.
  expect_true(is.null(nulltest()))

  # DLL should be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_true(any(grepl("unloaddll", dynlibs)))

  unload("unload-dll")

  # DLL should not be listed in .dynLibs()
  dynlibs <- vapply(.dynLibs(), `[[`, "name", FUN.VALUE = character(1))
  expect_false(any(grepl("unloaddll", dynlibs)))


  # Loading again, and reloading
  # Should not re-compile (don't have a proper test for it)
  load_all("unload-dll")
  expect_true(is.null(nulltest()))

  # Should not re-compile (don't have a proper test for it)
  load_all("unload-dll")
  expect_true(is.null(nulltest()))

  # Should re-compile (don't have a proper test for it)
  load_all("unload-dll", reset = TRUE)
  expect_true(is.null(nulltest()))
  unload("unload-dll")

  # Clean out compiled objects
  clean_dll("unload-dll")
})

