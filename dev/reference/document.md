# Use roxygen to document a package

This function is a wrapper for the
[`roxygen2::roxygenize()`](https://roxygen2.r-lib.org/reference/roxygenize.html)
function from the roxygen2 package. See the documentation and vignettes
of that package to learn how to use roxygen.

## Usage

``` r
document(pkg = ".", roclets = NULL, quiet = FALSE)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- roclets:

  Character vector of roclet names to use with package. The default,
  `NULL`, uses the roxygen `roclets` option, which defaults to
  `c("collate", "namespace", "rd")`.

- quiet:

  if `TRUE` suppresses output from this function.

## See also

[`roxygen2::roxygenize()`](https://roxygen2.r-lib.org/reference/roxygenize.html),
`browseVignettes("roxygen2")`
