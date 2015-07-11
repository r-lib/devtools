context("s4-sort")

## Define a graph of classes with complex inheritance pattern
## example taken from wikipedia:
## https://en.wikipedia.org/wiki/Topological_sorting#Examples

testenv <- new.env()

setClass("A", where = testenv)
setClass("B", where = testenv)
setClass("C", where = testenv)
setClassUnion("D", members = c("A", "B", "C"), where = testenv)
setClass("E", where = testenv)
setIs("B", "E", where = testenv)
setClassUnion("F", members = c("D", "E"), where = testenv)
setClass("G", where = testenv)
setIs("D", "G", where = testenv)
setClassUnion("H", members = c("C", "E"), where = testenv)

classes <- methods::getClasses(where = testenv)


test_that("Example classes are not topologically sorted", {
  ## there are some superclasses of the first class
  ## later in the list
  superclasses <- extends(classes[1])[-1]
  expect_true(any(superclasses %in% classes[-1]))
})

test_that("topological sorting s4 classes", {

  sorted_classes <- sort_s4classes(classes)

  for (idx in seq_along(classes)) {
    ## for each class in the sorted list
    ## all its superclasses are before
    superclasses <- extends(sorted_classes[idx])
    expect_true(all(superclasses %in% head(sorted_classes, idx)))
  }

})
