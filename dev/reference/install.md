# Install a local development package

Uses `R CMD INSTALL` to install the package, after installing needed
dependencies with
[`pak::local_install_deps()`](https://pak.r-lib.org/reference/local_install_deps.html).

To install to a non-default library, use
[`withr::with_libpaths()`](https://withr.r-lib.org/reference/with_libpaths.html).

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
  upgrade = FALSE,
  build_vignettes = FALSE,
  keep_source = getOption("keep.source.pkgs") || !build,
  force = deprecated()
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- reload:

  if `TRUE` (the default), will automatically attempt to reload the
  package after installing. Reloading is not always completely possible
  so see
  [`pkgload::unregister()`](https://pkgload.r-lib.org/reference/unload.html)
  for caveats.

- quick:

  if `TRUE`, skips some optional steps (e.g. help pre-rendering and
  multi-arch builds) to make installation as fast as possible.

- build:

  If `TRUE` (the default), first
  [`pkgbuild::build()`](https://pkgbuild.r-lib.org/reference/build.html)s
  the package. This ensures that the installation is completely clean,
  and prevents any binary artefacts (like `.o`, `.so`) from appearing in
  your local package directory, but is considerably slower, because
  every compile has to start from scratch.

  One downside of installing from a built tarball is that the package is
  installed from a temporary location. This means that any source
  references will point to dangling locations and debuggers won't have
  direct access to the source for step-debugging. For development
  purposes, `build = FALSE` is often the better choice.

  If `FALSE`, the package is installed directly from its source
  directory. This is faster and can be favorable for preserving source
  references for debugging (see `keep_source`).

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD INSTALL`. This defaults to the value of the option
  `"devtools.install.args"`.

- quiet:

  If `TRUE`, suppress output.

- dependencies:

  What kinds of dependencies to install. Most commonly one of the
  following values:

  - `NA`: only required (hard) dependencies,

  - `TRUE`: required dependencies plus optional and development
    dependencies,

  - `FALSE`: do not install any dependencies. (You might end up with a
    non-working package, and/or the installation might fail.) See
    [Package dependency
    types](https://pak.r-lib.org/reference/package-dependency-types.html)
    for other possible values and more information about package
    dependencies.

- upgrade:

  When `FALSE`, the default, pak does the minimum amount of work to give
  you the latest version(s) of `pkg`. It will only upgrade dependent
  packages if `pkg`, or one of their dependencies explicitly require a
  higher version than what you currently have. It will also prefer a
  binary package over to source package, even it the binary package is
  older.

  When `upgrade = TRUE`, pak will ensure that you have the latest
  version(s) of `pkg` and all their dependencies.

- build_vignettes:

  if `TRUE`, will build vignettes. Normally it is `build` that's
  responsible for creating vignettes; this argument makes sure vignettes
  are built even if a build never happens (i.e. because
  `build = FALSE`).

- keep_source:

  If `TRUE` will keep the srcrefs from an installed package. This is
  useful for debugging (especially inside of RStudio or Positron).
  Defaults to `getOption("keep.source.pkgs") || !build`, since srcrefs
  are most useful when the package is installed from its source
  directory, i.e. when `build = FALSE`.

- force:

  **\[deprecated\]** No longer used.

## See also

[`with_debug()`](https://pkgbuild.r-lib.org/reference/with_debug.html)
to install packages with debugging flags set.

Other package installation:
[`uninstall()`](https://devtools.r-lib.org/dev/reference/uninstall.md)
