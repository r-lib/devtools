context("s4-export")


test_that("importing an S4 exported by another pkg with export_all = FALSE", {
  load_all("testS4export", export_all = FALSE)
  
  # this used to crash with error: 
  # class "class_to_export" is not exported by 'namespace:testS4export'
  load_all("testS4import", export_all = FALSE)
  expect_true(isClassDef(getClass('derived')))
  
  # cleanup
  unload('testS4import')
  unload('testS4export')
})
