# Unload and reload package

**\[deprecated\]**

`reload()` is deprecated because we no longer use or recommend this
workflow. Instead, we recommend
[`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md) to
load a package for interactive development.

## Usage

``` r
reload(pkg = ".", quiet = FALSE)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- quiet:

  if `TRUE` suppresses output from this function.

## See also

[`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md) to
load a package for interactive development.
