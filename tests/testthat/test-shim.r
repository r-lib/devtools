context("shim")

# Utility functions -----------------------------
# Take file paths and split them into pieces
expand_path <- function(path) {
  strsplit(path, .Platform$file.sep)
}

# Return the last n elements of vector x
last_n <- function(x, n = 1) {
  len <- length(x)
  x[(len-n+1):len]
}


# Tests -----------------------------------------

test_that("Replacement system.file isn't visible in global env", {
  load_all("testShim")
  expect_identical(get("system.file", pos = globalenv()), base::system.file)
  unload("testShim")
})


test_that("Replacement system.file returns correct values when used with load_all", {
  load_all("testShim")
  shim_ns <- ns_env("testShim")

  # Make sure the version of system.file inserted into the namespace's imports
  # isn't the same as base::system.file
  expect_false(identical(
    get("system.file", envir = shim_ns), base::system.file))

  # The sysfile_wrap function just wraps system.file, and should return the
  # modified values.
  files <- sysfile_wrap(c("A.txt", "B.txt", "C.txt", "D.txt"), package = "testShim")
  files <- expand_path(files)
  expect_true(all(last_n(files[[1]], 3) == c("testShim", "inst", "A.txt")))
  expect_true(all(last_n(files[[2]], 3) == c("testShim", "inst", "B.txt")))
  # Note that C.txt wouldn't be returned by base::system.file (see comments
  # in shim_system.file for explanation)
  expect_true(all(last_n(files[[3]], 2) == c("testShim", "C.txt")))
  # D.txt should be dropped
  expect_equal(length(files), 3)

  # If all files are not present, return ""
  files <- sysfile_wrap("nonexistent", package = "testShim")
  expect_equal(files, "")

  # Test packages outside testShim - should just pass through to
  # base::system.file
  expect_identical(system.file("Meta", "Rd.rds", package = "stats"),
    sysfile_wrap("Meta", "Rd.rds", package = "stats"))
  expect_identical(system.file("INDEX", package = "stats"),
    sysfile_wrap("INDEX", package = "stats"))
  expect_identical(system.file("nonexistent", package = "stats"),
    sysfile_wrap("nonexistent", package = "stats"))

  unload("testShim")
})

test_that("Replacement system.file returns correct values when installed", {
  # This set of tests is mostly a sanity check - it doesn't use the special
  # version of system.file, but it's useful to make sure we know what to look
  # for in the other tests.

  # Make a temp lib directory to install test package into
  old_libpaths <- .libPaths()
  tmp_libpath = file.path(tempdir(), "devtools_test")
  if (!dir.exists(tmp_libpath)) dir.create(tmp_libpath)
  .libPaths(c(tmp_libpath, .libPaths()))

  install("testShim", quiet = TRUE)
  expect_true(require(testShim))

  # The special version of system.file shouldn't exist - this get() will fall
  # through to the base namespace
  expect_identical(get("system.file", pos = asNamespace("testShim")),
    base::system.file)

  # Test within package testShim
  files <- sysfile_wrap(c("A.txt", "B.txt", "C.txt", "D.txt"),
    package = "testShim")
  files <- expand_path(files)
  expect_true(all(last_n(files[[1]], 2) == c("testShim", "A.txt")))
  expect_true(all(last_n(files[[2]], 2) == c("testShim", "B.txt")))
  expect_equal(length(files), 2)  # Third and fourth should be dropped

  # If all files are not present, return ""
  files <- sysfile_wrap("nonexistent", package = "testShim")
  expect_equal(files, "")

  detach("package:testShim", unload = TRUE)

  # Reset the libpath
  .libPaths(old_libpaths)
})
