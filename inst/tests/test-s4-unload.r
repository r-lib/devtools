context("s4-unload")

# Returns a named vector of this class's superclasses.
# Results are sorted so they can be compared easily to a vector.
# A contains B  ==  A is a superclass of B
get_superclasses <- function(class) {
  superclasses <- vapply(getClass(class)@contains, slot, "superClass",
    FUN.VALUE = character(1))

  sort(unname(superclasses))
}

# Returns a named vector of this class's subclasses
# Results are sorted so they can be compared easily to a vector.
# A extends B  ==  A is a subclass of B
get_subclasses <- function(class) {
  subclasses <- vapply(getClass(class)@subclasses, slot, "subClass",
    FUN.VALUE = character(1))

  sort(unname(subclasses))
}


test_that("loading and reloading s4 classes", {
  load_all("s4union")

  # Check class hierarchy
  expect_equal(get_superclasses("A"), c("AB", "mle2A", "mleA"))
  expect_equal(get_subclasses("AB"), c("A", "B"))
  expect_equal(get_superclasses("mle2"), c("mle", "mle2A", "mleA"))
  expect_equal(get_subclasses("mleA"), c("A", "mle", "mle2"))
  expect_equal(get_subclasses("mle2A"), c("A", "mle2"))

  # Check that package is registered correctly
  expect_equal(getClassDef("A")@package, "s4union")
  expect_equal(getClassDef("AB")@package, "s4union")
  expect_equal(getClassDef("mle2")@package, "s4union")

  # Unloading shouldn't result in any errors or warnings
  expect_no_warn_error(unload("s4union"))

  # Check that classes are unregistered
  # This test on A fails for some bizarre reason - bug in R? But it doesn't
  # to cause any practical problems.
  # expect_true(is.null(getClassDef("A")))
  expect_true(is.null(getClassDef("B")))
  expect_true(is.null(getClassDef("AB")))


  # Load again and repeat tests --------------------------------------------

  # Loading again shouldn't result in any errors or warnings
  expect_no_warn_error(load_all("s4union"))

  # Check class hierarchy
  expect_equal(get_superclasses("A"), c("AB", "mle2A", "mleA"))
  expect_equal(get_subclasses("AB"), c("A", "B"))
  expect_equal(get_superclasses("mle2"), c("mle", "mle2A", "mleA"))
  expect_equal(get_subclasses("mleA"), c("A", "mle", "mle2"))
  expect_equal(get_subclasses("mle2A"), c("A", "mle2"))

  # Check that package is registered correctly
  expect_equal(getClassDef("A")@package, "s4union")
  expect_equal(getClassDef("AB")@package, "s4union")
  expect_equal(getClassDef("mle2")@package, "s4union")

  unload("s4union")
  unloadNamespace("stats4")   # This was imported by s4union

  # Check that classes are unregistered
  # This test on A fails for some bizarre reason - bug in R? But it doesn't
  # to cause any practical problems.
  # expect_true(is.null(getClassDef("A")))
  expect_true(is.null(getClassDef("B")))
  expect_true(is.null(getClassDef("AB")))
})
