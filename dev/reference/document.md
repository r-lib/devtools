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

  Character vector of
  [roclets](https://roxygen2.r-lib.org/reference/roclet.html) to use.

  The default, `NULL`, uses the roxygen `roclets` option, which defaults
  to `c("collate", "namespace", "rd")`. This will update (if needed) the
  `Collate` field with
  [`update_collate()`](https://roxygen2.r-lib.org/reference/update_collate.html),
  produce the `NAMESPACE` file with
  [`namespace_roclet()`](https://roxygen2.r-lib.org/reference/namespace_roclet.html),
  and produce the Rd files with
  [`rd_roclet()`](https://roxygen2.r-lib.org/reference/rd_roclet.html).

  (Note that `update_collate()` is not technically a roclet but is still
  controlled with this argument for historical reasons.)

- quiet:

  if `TRUE` suppresses output from this function.

## See also

[`roxygen2::roxygenize()`](https://roxygen2.r-lib.org/reference/roxygenize.html),
`browseVignettes("roxygen2")`
