# Uninstall a local development package

Uses [`remove.packages()`](https://rdrr.io/r/utils/remove.packages.html)
to uninstall the package. To uninstall a package from a non-default
library, use in combination with
[`withr::with_libpaths()`](https://withr.r-lib.org/reference/with_libpaths.html).

## Usage

``` r
uninstall(pkg = ".", unload = TRUE, quiet = FALSE, lib = .libPaths()[[1]])
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- unload:

  if `TRUE` (the default), ensures the package is unloaded, prior to
  uninstalling.

- quiet:

  If `TRUE`, suppress output.

- lib:

  a character vector giving the library directories to remove the
  packages from. If missing, defaults to the first element in
  [`.libPaths()`](https://rdrr.io/r/base/libPaths.html).

## See also

[`with_debug()`](https://pkgbuild.r-lib.org/reference/with_debug.html)
to install packages with debugging flags set.

Other package installation:
[`install()`](https://devtools.r-lib.org/dev/reference/install.md)
