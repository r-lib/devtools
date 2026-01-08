# Custom devtools release checks.

This function performs additional checks prior to release. It is called
automatically by
[`release()`](https://devtools.r-lib.org/dev/reference/release.md).

## Usage

``` r
release_checks(pkg = ".", built_path = NULL)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.
