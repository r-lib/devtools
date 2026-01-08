# Find missing s3 exports.

The method is heuristic - looking for objs with a period in their name.

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
