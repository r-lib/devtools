context("s4-sort")

suppressMessages(load_all("testS4sort"))
classes <- methods::getClasses(ns_env('testS4sort'))


test_that("Example classes are not topologically sorted", {
  ## there are some superclasses of the first class
  ## later in the list
  superclasses <- extends(getClass(classes[1]))[-1]
  expect_true(any(superclasses %in% classes[-1]))
})

test_that("topological sorting s4 classes", {

  sorted_classes <- sort_s4classes(classes, 'testS4sort')

  for (idx in seq_along(classes)) {
    ## for each class in the sorted list
    ## all its superclasses are before
    superclasses <- extends(getClass(sorted_classes[idx]))
    expect_true(all(superclasses %in% head(sorted_classes, idx)))
  }

})

test_that("sorting extreme cases", {

  ## no classes to sort
  classes <- vector('character', 0)
  expect_identical(classes, sort_s4classes(classes, 'testS4sort'))

  ## only one class to sort
  classes <- "A"
  expect_identical(classes, sort_s4classes(classes, 'testS4sort'))
})

# cleanup
unload('testS4sort')
