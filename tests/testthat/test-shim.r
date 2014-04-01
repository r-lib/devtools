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

test_that("system.file returns correct values when used with load_all", {
  load_all("testShim")
  shim_ns <- ns_env("testShim")

  # The devtools::system.file function should return modified values.
  files <- system.file(c("A.txt", "B.txt", "C.txt", "D.txt"), package = "testShim")
  files <- expand_path(files)

  expect_true(all(last_n(files[[1]], 3) == c("testShim", "inst", "A.txt")))
  expect_true(all(last_n(files[[2]], 3) == c("testShim", "inst", "B.txt")))
  # Note that C.txt wouldn't be returned by base::system.file (see comments
  # in shim_system.file for explanation)
  expect_true(all(last_n(files[[3]], 2) == c("testShim", "C.txt")))
  # D.txt should be dropped
  expect_equal(length(files), 3)

  # If all files are not present, return ""
  files <- system.file("nonexistent", package = "testShim")
  expect_equal(files, "")

  # Test packages loaded the usual way - should just pass through to
  # base::system.file
  expect_identical(base::system.file("Meta", "Rd.rds", package = "stats"),
    system.file("Meta", "Rd.rds", package = "stats"))
  expect_identical(base::system.file("INDEX", package = "stats"),
    system.file("INDEX", package = "stats"))
  expect_identical(base::system.file("nonexistent", package = "stats"),
    system.file("nonexistent", package = "stats"))

  unload("testShim")
})


test_that("Shimmed system.file returns correct values when used with load_all", {
  load_all("testShim")
  shim_ns <- ns_env("testShim")

  # Make sure the version of system.file inserted into the namespace's imports
  # is the same as devtools::system.file
  expect_identical(get("system.file", envir = shim_ns), devtools::system.file)

  # Another check
  expect_identical(get_system.file(), devtools::system.file)

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
  files <- get_system.file()(c("A.txt", "B.txt", "C.txt", "D.txt"),
    package = "testShim")
  files <- expand_path(files)
  expect_true(all(last_n(files[[1]], 2) == c("testShim", "A.txt")))
  expect_true(all(last_n(files[[2]], 2) == c("testShim", "B.txt")))
  expect_equal(length(files), 2)  # Third and fourth should be dropped

  # If all files are not present, return ""
  files <- get_system.file()("nonexistent", package = "testShim")
  expect_equal(files, "")

  detach("package:testShim", unload = TRUE)

  # Reset the libpath
  .libPaths(old_libpaths)
})
