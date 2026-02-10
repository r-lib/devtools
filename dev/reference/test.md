# Execute testthat tests in a package

- `test()` runs all tests in a package. It's a shortcut for
  [`testthat::test_dir()`](https://testthat.r-lib.org/reference/test_dir.html)

- `test_active_file()` runs `test()` on the active file.

- `test_coverage()` computes test coverage for your package. It's a
  shortcut for
  [`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md)
  plus [`covr::report()`](http://covr.r-lib.org/reference/report.md).

- `test_coverage_active_file()` computes test coverage for the active
  file. It's a shortcut for
  [`covr::file_coverage()`](http://covr.r-lib.org/reference/file_coverage.md)
  plus [`covr::report()`](http://covr.r-lib.org/reference/report.md).

## Usage

``` r
test(pkg = ".", filter = NULL, stop_on_failure = FALSE, export_all = TRUE, ...)

test_active_file(file = find_active_file(), ...)

test_coverage(pkg = ".", report = NULL, ...)

test_coverage_active_file(
  file = find_active_file(),
  filter = TRUE,
  report = NULL,
  export_all = TRUE,
  ...
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- filter:

  If not `NULL`, only tests with file names matching this regular
  expression will be executed. Matching is performed on the file name
  after it's stripped of `"test-"` and `".R"`.

- stop_on_failure:

  If `TRUE`, throw an error if any tests fail.

- export_all:

  If `TRUE` (the default), export all objects. If `FALSE`, export only
  the objects that are listed as exports in the NAMESPACE file.

- ...:

  additional arguments passed to wrapped functions.

- file:

  One or more source or test files. If a source file the corresponding
  test file will be run. The default is to use the active file in
  RStudio (if available).

- report:

  How to display the coverage report.

  - `"html"` opens an interactive report in the browser.

  - `"zero"` prints uncovered lines to the console.

  - `"silent"` returns the coverage object without display.

  Defaults to `"html"` if interactive; otherwise to `"zero"`.
