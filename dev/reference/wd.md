# Set working directory

**\[deprecated\]**

`wd()` is deprecated because we no longer use or recommend this
workflow. Set working directory

## Usage

``` r
wd(pkg = ".", path = "")
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- path:

  path within package. Leave empty to change working directory to
  package directory.
