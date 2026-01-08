# Load complete package

`load_all()` loads a package. It roughly simulates what happens when a
package is installed and loaded with
[`library()`](https://rdrr.io/r/base/library.html), without having to
first install the package. It:

- Loads all data files in `data/`. See
  [`load_data()`](https://pkgload.r-lib.org/reference/load_data.html)
  for more details.

- Sources all R files in the R directory, storing results in environment
  that behaves like a regular package namespace. See
  [`load_code()`](https://pkgload.r-lib.org/reference/load_code.html)
  for more details.

- Adds a shim from
  [`system.file()`](https://pkgload.r-lib.org/reference/system.file.html)
  to
  [`shim_system.file()`](https://pkgload.r-lib.org/reference/system.file.html)
  in the imports environment of the package. This ensures that
  [`system.file()`](https://rdrr.io/r/base/system.file.html) works with
  both development and installed packages despite their differing
  directory structures.

- Adds shims from [`help()`](https://rdrr.io/r/utils/help.html) and `?`
  to [`shim_help()`](https://pkgload.r-lib.org/reference/help.html) and
  [`shim_question()`](https://pkgload.r-lib.org/reference/help.html) to
  make it easier to preview development documentation.

- Compiles any C, C++, or Fortran code in the `src/` directory and
  connects the generated DLL into R. See
  [`pkgbuild::compile_dll()`](https://pkgbuild.r-lib.org/reference/compile_dll.html)
  for more details.

- Loads any compiled translations in `inst/po`.

- Runs `.onAttach()`, `.onLoad()` and `.onUnload()` functions at the
  correct times.

- If you use testthat, will load all test helpers so you can access them
  interactively. devtools sets the `DEVTOOLS_LOAD` environment variable
  to the package name to let you check whether the helpers are run
  during package loading.

`is_loading()` returns `TRUE` when it is called while `load_all()` is
running. This may be useful e.g. in `.onLoad` hooks. A package loaded
with `load_all()` can be identified with
[`is_dev_package()`](https://pkgload.r-lib.org/reference/is_dev_package.html).

## Usage

``` r
load_all(
  path = ".",
  reset = TRUE,
  recompile = FALSE,
  export_all = TRUE,
  helpers = TRUE,
  quiet = FALSE,
  ...
)
```

## Arguments

- path:

  Path to a package, or within a package.

- reset:

  **\[deprecated\]** This is no longer supported because preserving the
  namespace requires unlocking its environment, which is no longer
  possible in recent versions of R.

- recompile:

  DEPRECATED. force a recompile of DLL from source code, if present.
  This is equivalent to running
  [`pkgbuild::clean_dll()`](https://pkgbuild.r-lib.org/reference/clean_dll.html)
  before `load_all()`

- export_all:

  If `TRUE` (the default), export all objects. If `FALSE`, export only
  the objects that are listed as exports in the NAMESPACE file.

- helpers:

  if `TRUE` loads testthat test helpers.

- quiet:

  if `TRUE` suppresses output from this function.

- ...:

  Additional arguments passed to
  [`pkgload::load_all()`](https://pkgload.r-lib.org/reference/load_all.html).

## Differences to regular loading

`load_all()` tries its best to reproduce the behaviour of
[`loadNamespace()`](https://rdrr.io/r/base/ns-load.html) and
[`library()`](https://rdrr.io/r/base/library.html). However it deviates
from normal package loading in several ways.

- `load_all()` doesn't install the package to a library, so
  [`system.file()`](https://pkgload.r-lib.org/reference/system.file.html)
  doesn't work. pkgload fixes this for the package itself installing a
  shim,
  [`shim_system.file()`](https://pkgload.r-lib.org/reference/system.file.html).
  However, this shim is not visible to third party packages, so they
  will fail if they attempt to find files within your package. One
  potential workaround is to use
  [`fs::path_package()`](https://fs.r-lib.org/reference/path_package.html)
  instead of [`system.file()`](https://rdrr.io/r/base/system.file.html),
  since that understands the mechanisms that devtools uses to load
  packages.

- `load_all()` loads all packages referenced in `Imports` at load time,
  but [`loadNamespace()`](https://rdrr.io/r/base/ns-load.html) and
  [`library()`](https://rdrr.io/r/base/library.html) only load package
  dependencies as they are needed.

- `load_all()` copies all objects (not just the ones listed as exports)
  into the package environment. This is useful during development
  because it makes internal objects easy to access. To export only the
  objects listed as exports, use `export_all = FALSE`. This more closely
  simulates behavior when loading an installed package with
  [`library()`](https://rdrr.io/r/base/library.html), and can be useful
  for checking for missing exports.

## Controlling the debug compiler flags

`load_all()` delegates to
[`pkgbuild::compile_dll()`](https://pkgbuild.r-lib.org/reference/compile_dll.html)
to perform the actual compilation, during which by default some debug
compiler flags are appended. If you would like to produce an optimized
build instead, you can opt out by either using `debug = FALSE`, setting
the `pkg.build_extra_flags` option to `FALSE`, or setting the
`PKG_BUILD_EXTRA_FLAGS` environment variable to `FALSE`. For further
details see the Details section in
[`pkgbuild::compile_dll()`](https://pkgbuild.r-lib.org/reference/compile_dll.html).

## Examples

``` r
if (FALSE) { # \dontrun{
# Load the package in the current directory
load_all("./")

# Running again loads changed files
load_all("./")

# With export_all=FALSE, only objects listed as exports in NAMESPACE
# are exported
load_all("./", export_all = FALSE)
} # }
```
