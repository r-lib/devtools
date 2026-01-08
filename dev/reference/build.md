# Build package

Building converts a package source directory into a single bundled file.
If `binary = FALSE` this creates a `tar.gz` package that can be
installed on any platform, provided they have a full development
environment (although packages without source code can typically be
installed out of the box). If `binary = TRUE`, the package will have a
platform specific extension (e.g. `.zip` for windows), and will only be
installable on the current platform, but no development environment is
needed.

## Usage

``` r
build(
  pkg = ".",
  path = NULL,
  binary = FALSE,
  vignettes = TRUE,
  manual = FALSE,
  args = NULL,
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

- path:

  Path in which to produce package. If `NULL`, defaults to the parent
  directory of the package.

- binary:

  Produce a binary (`--binary`) or source (
  `--no-manual --no-resave-data`) version of the package.

- vignettes, manual:

  For source packages: if `FALSE`, don't build PDF vignettes
  (`--no-build-vignettes`) or manual (`--no-manual`).

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD build` if `binary = FALSE`, or `R CMD install` if
  `binary = TRUE`.

- quiet:

  if `TRUE` suppresses output from this function.

- ...:

  Additional arguments passed to
  [pkgbuild::build](https://pkgbuild.r-lib.org/reference/build.html).

## Value

a string giving the location (including file name) of the built package

## Details

### Configuration

#### `DESCRIPTION` entries

- `Config/build/clean-inst-doc` can be set to `FALSE` to avoid cleaning
  up `inst/doc` when building a source package. Set it to `TRUE` to
  force a cleanup. See the `clean_doc` argument.

- `Config/build/copy-method` can be used to avoid copying large
  directories in `R CMD build`. It works by copying (or linking) the
  files of the package to a temporary directory, leaving out the
  (possibly large) files that are not part of the package. Possible
  values:

  - `none`: pkgbuild does not copy the package tree. This is the
    default.

  - `copy`: the package files are copied to a temporary directory before
    ` R CMD build`.

  - `link`: the package files are symbolic linked to a temporary
    directory before `R CMD build`. Windows does not have symbolic
    links, so on Windows this is equivalent to `copy`.

  You can also use the `pkg.build_copy_method` option or the
  `PKG_BUILD_COPY_METHOD` environment variable to set the copy method.
  The option is consulted first, then the `DESCRIPTION` entry, then the
  environment variable.

- `Config/build/extra-sources` can be used to define extra source files
  for pkgbuild to decide whether a package DLL needs to be recompiled in
  `needs_compile()`. The syntax is a comma separated list of file names,
  or globs. (See
  [`utils::glob2rx()`](https://rdrr.io/r/utils/glob2rx.html).) E.g.
  `src/rust/src/*.rs` or `configure*`.

- `Config/build/bootstrap` can be set to `TRUE` to run
  `Rscript bootstrap.R` in the source directory prior to running
  subsequent build steps.

- `Config/build/never-clean` can be set to `TRUE` to never add
  `--preclean` to `R CMD INSTALL`, e.g., when header files have changed.
  This helps avoiding rebuilds that can take long for very large C/C++
  codebases and can lead to build failures if object files are out of
  sync with header files. Control the dependencies between object files
  and header files by adding `include file.d` to `Makevars` for each
  `file.c` or `file.cpp` source file.

#### Options

- `pkg.build_copy_method`: use this option to avoid copying large
  directories when building a package. See possible values above, at the
  `Config/build/copy-method` `DESCRIPTION` entry.

- `pkg.build_stop_for_warnings`: if it is set to `TRUE`, then pkgbuild
  will stop for `R CMD build` errors. It takes precedence over the
  `PKG_BUILD_STOP_FOR_WARNINGS` environment variable.

#### Environment variables

- `PKG_BUILD_COLOR_DIAGNOSTICS`: set it to `false` to opt out of colored
  compiler diagnostics. Set it to `true` to force colored compiler
  diagnostics.

- `PKG_BUILD_COPY_METHOD`: use this environment variable to avoid
  copying large directories when building a package. See possible values
  above, at the `Config/build/copy-method` `DESCRIPTION` entry.

will stop for `R CMD build` errors. The `pkg.build_stop_for_warnings`
option takes precedence over this environment variable.

## Note

The default `manual = FALSE` is not suitable for a CRAN submission,
which may require `manual = TRUE`. Even better, use
[`submit_cran()`](https://devtools.r-lib.org/dev/reference/submit_cran.md)
or [`release()`](https://devtools.r-lib.org/dev/reference/release.md).
