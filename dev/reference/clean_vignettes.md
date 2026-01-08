# Clean built vignettes.

This uses a fairly rudimentary algorithm where any files in `doc` with a
name that exists in `vignettes` are removed.

## Usage

``` r
clean_vignettes(pkg = ".")
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.
