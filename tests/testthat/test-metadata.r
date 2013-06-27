context("Metadata")

test_that("devtools metadata for load hooks", {

  # testLoadHooks test package has .onLoad and .onAttach
  load_all("testLoadHooks")
  md <- dev_meta("testLoadHooks")
  expect_true(md$.onLoad)
  expect_true(md$.onAttach)
  unload("testLoadHooks")


  # testNamespace test package doesn't have .onLoad and .onAttach
  load_all("testNamespace")
  md <- dev_meta("testNamespace")
  expect_false(exists("onLoad", envir = md))
  expect_false(exists("onAttach", envir = md))
  unload("testNamespace")
})


test_that("NULL metadata for non-devtools-loaded packages", {
  expect_true(is.null(dev_meta("stats")))
})


test_that("dev_packages() lists devtools-loaded packages", {
  expect_false(any(c("testNamespace", "testLoadHooks") %in% dev_packages()))
  expect_false("testNamespace" %in% dev_packages())
  expect_false("testLoadHooks" %in% dev_packages())

  load_all("testNamespace")
  expect_true("testNamespace" %in% dev_packages())
  expect_false("testLoadHooks" %in% dev_packages())

  load_all("testLoadHooks")
  expect_true("testNamespace" %in% dev_packages())
  expect_true("testLoadHooks" %in% dev_packages())

  unload("testNamespace")
  expect_false("testNamespace" %in% dev_packages())
  expect_true("testLoadHooks" %in% dev_packages())

  unload("testLoadHooks")
  expect_false("testNamespace" %in% dev_packages())
  expect_false("testLoadHooks" %in% dev_packages())


  expect_false("stats" %in% dev_packages())
})
