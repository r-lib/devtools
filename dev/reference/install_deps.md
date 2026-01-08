# Install package dependencies if needed.

`install_deps()` will install the user dependencies needed to run the
package, `install_dev_deps()` will also install the development
dependencies needed to test and build the package.

## Usage

``` r
install_deps(
  pkg = ".",
  dependencies = NA,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  upgrade = c("default", "ask", "always", "never"),
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", " --no-build-vignettes"),
  ...
)

install_dev_deps(
  pkg = ".",
  dependencies = TRUE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  upgrade = c("default", "ask", "always", "never"),
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", " --no-build-vignettes"),
  ...
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

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

- repos:

  A character vector giving repositories to use.

- type:

  Type of package to `update`.

- upgrade:

  Should package dependencies be upgraded? One of "default", "ask",
  "always", or "never". "default" respects the value of the
  `R_REMOTES_UPGRADE` environment variable if set, and falls back to
  "ask" if unset. "ask" prompts the user for which out of date packages
  to upgrade. For non-interactive sessions "ask" is equivalent to
  "always". `TRUE` and `FALSE` are also accepted and correspond to
  "always" and "never" respectively.

- quiet:

  If `TRUE`, suppress output.

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

- build_opts:

  Options to pass to `R CMD build`, only used when `build` is `TRUE`.

- ...:

  additional arguments passed to
  [`remotes::install_deps()`](https://remotes.r-lib.org/reference/install_deps.html)
  when installing dependencies.

## Examples

``` r
if (FALSE) install_deps(".") # \dontrun{}
```
