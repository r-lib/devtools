context("Metadata")

test_that("devtools metadata for load hooks", {

  # loadhooks test package has .onLoad and .onAttach
  load_all("load-hooks")
  md <- dev_meta("loadhooks")
  expect_true(md$onLoad)
  expect_true(md$onAttach)
  unload("load-hooks")


  # namespace test package doesn't have .onLoad and .onAttach
  load_all("namespace")
  md <- dev_meta("namespace")
  expect_false(exists("onLoad", envir = md))
  expect_false(exists("onAttach", envir = md))
  unload("namespace")
})


test_that("NULL metadata for non-devtools-loaded packages", {
  expect_true(is.null(dev_meta("stats")))
})


test_that("dev_packages() lists devtools-loaded packages", {
  expect_false(any(c("namespace", "loadhooks") %in% dev_packages()))
  expect_false("namespace" %in% dev_packages())
  expect_false("loadhooks" %in% dev_packages())

  load_all("namespace")
  expect_true("namespace" %in% dev_packages())
  expect_false("loadhooks" %in% dev_packages())

  load_all("load-hooks")
  expect_true("namespace" %in% dev_packages())
  expect_true("loadhooks" %in% dev_packages())

  unload("namespace")
  expect_false("namespace" %in% dev_packages())
  expect_true("loadhooks" %in% dev_packages())

  unload("load-hooks")
  expect_false("namespace" %in% dev_packages())
  expect_false("loadhooks" %in% dev_packages())


  expect_false("stats" %in% dev_packages())
})
