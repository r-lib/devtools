# Run CRAN checks for package on R-hub

**\[deprecated\]**

This function is deprecated since the underlying function
[`rhub::check_for_cran()`](https://r-hub.github.io/rhub/reference/check_for_cran.html)
is now deprecated and defunct. See
[`rhub::rhubv2`](https://r-hub.github.io/rhub/reference/rhubv2.html)
learn about the new check system, R-hub v2.

## Usage

``` r
check_rhub(
  pkg = ".",
  platforms = NULL,
  email = NULL,
  interactive = TRUE,
  build_args = NULL,
  ...
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- platforms:

  R-hub platforms to run the check on.

- email:

  email address to notify.

- interactive:

  whether to show the status of the build.

- build_args:

  Arguments passed to `R CMD build`.

- ...:

  extra arguments, passed to
  [`rhub::check_for_cran()`](https://r-hub.github.io/rhub/reference/check_for_cran.html).

## Value

a `rhub_check` object.
