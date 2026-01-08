# Check a package on Windows

This function first bundles a source package, then uploads it to
<https://win-builder.r-project.org/>. Once the service has built and
checked the package, an email is sent to address of the maintainer
listed in `DESCRIPTION`. This usually takes around 30 minutes. The email
contains a link to a directory with the package binary and check logs,
which will be deleted after a couple of days.

## Usage

``` r
check_win_devel(
  pkg = ".",
  args = NULL,
  manual = TRUE,
  email = NULL,
  quiet = FALSE,
  ...
)

check_win_release(
  pkg = ".",
  args = NULL,
  manual = TRUE,
  email = NULL,
  quiet = FALSE,
  ...
)

check_win_oldrelease(
  pkg = ".",
  args = NULL,
  manual = TRUE,
  email = NULL,
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

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD build` if `binary = FALSE`, or `R CMD install` if
  `binary = TRUE`.

- manual:

  Should the manual be built?

- email:

  An alternative email address to use. If `NULL`, the default is to use
  the package maintainer's email.

- quiet:

  If `TRUE`, suppresses output.

- ...:

  Additional arguments passed to
  [`pkgbuild::build()`](https://pkgbuild.r-lib.org/reference/build.html).

## Functions

- `check_win_devel()`: Check package on the development version of R.

- `check_win_release()`: Check package on the released version of R.

- `check_win_oldrelease()`: Check package on the previous major release
  version of R.

## See also

Other build functions:
[`check_mac_release()`](https://devtools.r-lib.org/dev/reference/check_mac_release.md)
