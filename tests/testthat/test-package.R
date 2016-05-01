context('package')

test_that("it can load from outside of package root", {
  expect_false('testHooks' %in% loadedNamespaces())
  load_all(file.path("testHooks"))
  expect_true('testHooks' %in% loadedNamespaces())
  unload(file.path("testHooks"))
  expect_false('testHooks' %in% loadedNamespaces())
})

