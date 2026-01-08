# Lint all source files in a package

The default linters correspond to the style guide at
<https://style.tidyverse.org/>, however it is possible to override any
or all of them using the `linters` parameter.

## Usage

``` r
lint(pkg = ".", cache = TRUE, ...)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- cache:

  Store the lint results so repeated lints of the same content use the
  previous results. Consult the lintr package to learn more about its
  caching behaviour.

- ...:

  Additional arguments passed to
  [`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html).

## See also

[`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html),
[`lintr::lint()`](https://lintr.r-lib.org/reference/lint.html)
