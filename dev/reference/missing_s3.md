# Find missing s3 exports

**\[deprecated\]**

`missing_s3()` is deprecated because roxygen2 now provides the same
functionality. Run
[`devtools::document()`](https://devtools.r-lib.org/dev/reference/document.md)
and look for `"Missing documentation for S3 method"` warnings.

## Usage

``` r
missing_s3(pkg = ".")
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.
