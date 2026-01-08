# Check a package on macOS

This function first bundles a source package, then uploads it to
<https://mac.r-project.org/macbuilder/submit.html>. This function
returns a link to the page where the check results will appear.

## Usage

``` r
check_mac_release(
  pkg = ".",
  dep_pkgs = character(),
  args = NULL,
  manual = TRUE,
  quiet = FALSE,
  ...
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- dep_pkgs:

  Additional custom dependencies to install prior to checking the
  package.

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD build` if `binary = FALSE`, or `R CMD install` if
  `binary = TRUE`.

- manual:

  Should the manual be built?

- quiet:

  If `TRUE`, suppresses output.

- ...:

  Additional arguments passed to
  [`pkgbuild::build()`](https://pkgbuild.r-lib.org/reference/build.html).

## Value

The url with the check results (invisibly)

## See also

Other build functions:
[`check_win()`](https://devtools.r-lib.org/dev/reference/check_win.md)
