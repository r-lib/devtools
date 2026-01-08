# Git checks.

This function performs Git checks checks prior to release. It is called
automatically by
[`release()`](https://devtools.r-lib.org/dev/reference/release.md).

## Usage

``` r
git_checks(pkg = ".")
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.
