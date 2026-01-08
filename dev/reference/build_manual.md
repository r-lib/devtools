# Create package pdf manual

Create package pdf manual

## Usage

``` r
build_manual(pkg = ".", path = NULL)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- path:

  path in which to produce package manual. If `NULL`, defaults to the
  parent directory of the package.

## See also

[`Rd2pdf()`](https://rdrr.io/r/base/RdUtils.html)
