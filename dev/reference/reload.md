# Unload and reload package

This attempts to unload and reload an *installed* package. If the
package is not loaded already, it does nothing. It's not always possible
to cleanly unload a package: see the caveats in
[`unload()`](https://pkgload.r-lib.org/reference/unload.html) for some
of the potential failure points. If in doubt, restart R and reload the
package with [`library()`](https://rdrr.io/r/base/library.html).

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

## Examples

``` r
if (FALSE) { # \dontrun{
# Reload package that is in current directory
reload(".")

# Reload package that is in ./ggplot2/
reload("ggplot2/")

# Can use inst() to find the package path
# This will reload the installed ggplot2 package
reload(pkgload::inst("ggplot2"))
} # }
```
