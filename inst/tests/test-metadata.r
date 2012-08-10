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


