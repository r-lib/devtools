# Build and check a package

`check()` automatically builds and checks a source package, using all
known best practices. `check_built()` checks an already-built package.

Passing `R CMD check` is essential if you want to submit your package to
CRAN: you must not have any ERRORs or WARNINGs, and you want to ensure
that there are as few NOTEs as possible. If you are not submitting to
CRAN, at least ensure that there are no ERRORs or WARNINGs: these
typically represent serious problems.

`check()` automatically builds a package before calling `check_built()`,
as this is the recommended way to check packages. Note that this process
runs in an independent R session, so nothing in your current workspace
will affect the process. Under-the-hood, `check()` and `check_built()`
rely on
[`pkgbuild::build()`](https://pkgbuild.r-lib.org/reference/build.html)
and
[`rcmdcheck::rcmdcheck()`](http://r-lib.github.io/rcmdcheck/reference/rcmdcheck.md).

## Usage

``` r
check(
  pkg = ".",
  document = NULL,
  build_args = NULL,
  ...,
  manual = FALSE,
  cran = TRUE,
  remote = FALSE,
  incoming = remote,
  force_suggests = FALSE,
  run_dont_test = FALSE,
  args = "--timings",
  env_vars = c(NOT_CRAN = "true"),
  quiet = FALSE,
  check_dir = NULL,
  cleanup = deprecated(),
  vignettes = TRUE,
  error_on = c("never", "error", "warning", "note")
)

check_built(
  path = NULL,
  cran = TRUE,
  remote = FALSE,
  incoming = remote,
  force_suggests = FALSE,
  run_dont_test = FALSE,
  manual = FALSE,
  args = "--timings",
  env_vars = NULL,
  check_dir = tempdir(),
  quiet = FALSE,
  error_on = c("never", "error", "warning", "note")
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- document:

  By default (`NULL`) will document if your installed roxygen2 version
  matches the version declared in the `DESCRIPTION` file. Use `TRUE` or
  `FALSE` to override the default.

- build_args:

  Additional arguments passed to `R CMD build`

- ...:

  Additional arguments passed on to
  [`pkgbuild::build()`](https://pkgbuild.r-lib.org/reference/build.html).

- manual:

  If `FALSE`, don't build and check manual (`--no-manual`).

- cran:

  if `TRUE` (the default), check using the same settings as CRAN uses.
  Because this is a moving target and is not uniform across all of
  CRAN's machine, this is on a "best effort" basis. It is more
  complicated than simply setting `--as-cran`.

- remote:

  Sets `_R_CHECK_CRAN_INCOMING_REMOTE_` env var. If `TRUE`, performs a
  number of CRAN incoming checks that require remote access.

- incoming:

  Sets `_R_CHECK_CRAN_INCOMING_` env var. If `TRUE`, performs a number
  of CRAN incoming checks.

- force_suggests:

  Sets `_R_CHECK_FORCE_SUGGESTS_`. If `FALSE` (the default), check will
  proceed even if all suggested packages aren't found.

- run_dont_test:

  Sets `--run-donttest` so that examples surrounded in `\donttest{}` are
  also run. When `cran = TRUE`, this only affects R 3.6 and earlier; in
  R 4.0, code in `\donttest{}` is always run as part of CRAN submission.

- args:

  Character vector of arguments to pass to `R CMD check`. Pass each
  argument as a single element of this character vector (do not use
  spaces to delimit arguments like you would in the shell). For example,
  to skip running of examples and tests, use
  `args = c("--no-examples", "--no-tests")` and not
  `args = "--no-examples --no-tests"`. (Note that instead of the
  `--output` option you should use the `check_dir` argument, because
  `--output` cannot deal with spaces and other special characters on
  Windows.)

- env_vars:

  Environment variables set during `R CMD check`

- quiet:

  if `TRUE` suppresses output from this function.

- check_dir:

  Path to a directory where the check is performed. If this is not
  `NULL`, then the a temporary directory is used, that is cleaned up
  when the returned object is garbage collected.

- cleanup:

  **\[deprecated\]** See `check_dir` for details.

- vignettes:

  If `FALSE`, do not build or check vignettes, equivalent to using
  `args = '--ignore-vignettes'` and
  `build_args = '--no-build-vignettes'`.

- error_on:

  Whether to throw an error on `R CMD check` failures. Note that the
  check is always completed (unless a timeout happens), and the error is
  only thrown after completion.

  `error_on` is passed through to
  [`rcmdcheck::rcmdcheck()`](http://r-lib.github.io/rcmdcheck/reference/rcmdcheck.md),
  which is the definitive source for what the different values mean. If
  not specified by the user, both `check()` and `check_built()` default
  to `error_on = "never"` in interactive use and `"warning"` in a
  non-interactive setting.

- path:

  Path to built package.

## Value

An object containing errors, warnings, notes, and more.

## Environment variables

Devtools does its best to set up an environment that combines best
practices with how check works on CRAN. This includes:

- The standard environment variables set by devtools:
  [`r_env_vars()`](https://devtools.r-lib.org/dev/reference/r_env_vars.md).
  Of particular note for package tests is the `NOT_CRAN` env var, which
  lets you know that your tests are running somewhere other than CRAN,
  and hence can take a reasonable amount of time.

- Debugging flags for the compiler, set by
  [`compiler_flags(FALSE)`](https://pkgbuild.r-lib.org/reference/compiler_flags.html).

- If `aspell` is found, `_R_CHECK_CRAN_INCOMING_USE_ASPELL_` is set to
  `TRUE`. If no spell checker is installed, a warning is issued.

- Environment variables, controlled by arguments `incoming`, `remote`
  and `force_suggests`.

## See also

[`release()`](https://devtools.r-lib.org/dev/reference/release.md) if
you want to send the checked package to CRAN.
