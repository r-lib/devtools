# Install a local development package

Uses `R CMD INSTALL` to install the package. Will also try to install
dependencies of the package from CRAN, if they're not already installed.

## Usage

``` r
install(
  pkg = ".",
  reload = TRUE,
  quick = FALSE,
  build = !quick,
  args = getOption("devtools.install.args"),
  quiet = FALSE,
  dependencies = NA,
  upgrade = "default",
  build_vignettes = FALSE,
  keep_source = getOption("keep.source.pkgs"),
  force = FALSE,
  ...
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- reload:

  if `TRUE` (the default), will automatically reload the package after
  installing.

- quick:

  if `TRUE` skips docs, multiple-architectures, demos, and vignettes, to
  make installation as fast as possible.

- build:

  if `TRUE`
  [`pkgbuild::build()`](https://pkgbuild.r-lib.org/reference/build.html)s
  the package first: this ensures that the installation is completely
  clean, and prevents any binary artefacts (like `.o`, `.so`) from
  appearing in your local package directory, but is considerably slower,
  because every compile has to start from scratch.

  One downside of installing from a built tarball is that the package is
  installed from a temporary location. This means that any source
  references, at R level or C/C++ level, will point to dangling
  locations. The debuggers will not be able to find the sources for
  step-debugging. If you're installing the package for development,
  consider setting `build` to `FALSE`.

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD INSTALL`. This defaults to the value of the option
  `"devtools.install.args"`.

- quiet:

  If `TRUE`, suppress output.

- dependencies:

  Which dependencies do you want to check? Can be a character vector
  (selecting from "Depends", "Imports", "LinkingTo", "Suggests", or
  "Enhances"), or a logical vector.

  `TRUE` is shorthand for "Depends", "Imports", "LinkingTo" and
  "Suggests". `NA` is shorthand for "Depends", "Imports" and "LinkingTo"
  and is the default. `FALSE` is shorthand for no dependencies (i.e.
  just check this package, not its dependencies).

  The value "soft" means the same as `TRUE`, "hard" means the same as
  `NA`.

  You can also specify dependencies from one or more additional fields,
  common ones include:

  - Config/Needs/website - for dependencies used in building the pkgdown
    site.

  - Config/Needs/coverage for dependencies used in calculating test
    coverage.

- upgrade:

  Should package dependencies be upgraded? One of "default", "ask",
  "always", or "never". "default" respects the value of the
  `R_REMOTES_UPGRADE` environment variable if set, and falls back to
  "ask" if unset. "ask" prompts the user for which out of date packages
  to upgrade. For non-interactive sessions "ask" is equivalent to
  "always". `TRUE` and `FALSE` are also accepted and correspond to
  "always" and "never" respectively.

- build_vignettes:

  if `TRUE`, will build vignettes. Normally it is `build` that's
  responsible for creating vignettes; this argument makes sure vignettes
  are built even if a build never happens (i.e. because
  `build = FALSE`).

- keep_source:

  If `TRUE` will keep the srcrefs from an installed package. This is
  useful for debugging (especially inside of RStudio). It defaults to
  the option `"keep.source.pkgs"`.

- force:

  Force installation, even if the remote state has not changed since the
  previous install.

- ...:

  additional arguments passed to
  [`remotes::install_deps()`](https://remotes.r-lib.org/reference/install_deps.html)
  when installing dependencies.

## Details

If `quick = TRUE`, installation takes place using the current package
directory. If you have compiled code, this means that artefacts of
compilation will be created in the `src/` directory. If you want to
avoid this, you can use `build = TRUE` to first build a package bundle
and then install it from a temporary directory. This is slower, but
keeps the source directory pristine.

If the package is loaded, it will be reloaded after installation. This
is not always completely possible, see
[`reload()`](https://devtools.r-lib.org/dev/reference/reload.md) for
caveats.

To install a package in a non-default library, use
[`withr::with_libpaths()`](https://withr.r-lib.org/reference/with_libpaths.html).

## See also

[`update_packages()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
to update installed packages from the source location and
[`with_debug()`](https://pkgbuild.r-lib.org/reference/with_debug.html)
to install packages with debugging flags set.

Other package installation:
[`uninstall()`](https://devtools.r-lib.org/dev/reference/uninstall.md)
