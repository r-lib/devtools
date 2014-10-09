context('load_all')
library(testthatsomemore)

example_package <- list(
  DESCRIPTION = 
"Package: floobit
Type: Package
Title: floobit
Description: floobit bar baz lorem ipsum
Version: 1.3.3.7
Authors@R: c(person('Floobit', 'Maker', email = 'floobit@maker.com', role = c('aut','cre')))
Depends:
  R (>= 3.0.2)
License:
  MIT",
  NAMESPACE = 'export(floobit_example)',
  R = list(example.R = "floobit_example <- function(...) 'floobit'")
)

test_that('it can load a package when not in the root', {
  within_file_structure(example_package, {
    load_all(file.path(tempdir, 'R')) # Load from inside R directory instead of package root
    expect_is(get('floobit_example', envir = asNamespace('floobit')), 'function')
    unloadNamespace('floobit')
  })
})

context('unload')

test_that('it can unload a package when not in the root', {
  within_file_structure(example_package, {
    load_all(file.path(tempdir, 'R')) 
    expect_is(get('floobit_example', envir = asNamespace('floobit')), 'function')
    unload(file.path(tempdir, 'R'))
    expect_false(is.element('floobit', loadedNamespaces()))
  })
})


