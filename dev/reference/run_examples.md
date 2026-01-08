# Run all examples in a package.

One of the most frustrating parts of `R CMD check` is getting all of
your examples to pass - whenever one fails you need to fix the problem
and then restart the whole process. This function makes it a little
easier by making it possible to run all examples from an R function.

## Usage

``` r
run_examples(
  pkg = ".",
  start = NULL,
  show = deprecated(),
  run_donttest = FALSE,
  run_dontrun = FALSE,
  fresh = FALSE,
  document = TRUE,
  run = deprecated(),
  test = deprecated()
)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- start:

  Where to start running the examples: this can either be the name of
  `Rd` file to start with (with or without extensions), or a topic name.
  If omitted, will start with the (lexicographically) first file. This
  is useful if you have a lot of examples and don't want to rerun them
  every time you fix a problem.

- show:

  DEPRECATED.

- run_donttest:

  if `TRUE`, do run `\donttest` sections in the Rd files.

- run_dontrun:

  if `TRUE`, do run `\dontrun` sections in the Rd files.

- fresh:

  if `TRUE`, will be run in a fresh R session. This has the advantage
  that there's no way the examples can depend on anything in the current
  session, but interactive code (like
  [`browser()`](https://rdrr.io/r/base/browser.html)) won't work.

- document:

  if `TRUE`,
  [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  will be run to ensure examples are updated before running them.

- run, test:

  Deprecated, see `run_dontrun` and `run_donttest` above.
