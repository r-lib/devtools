# Report package development situation

`dev_sitrep()` reports

- If R is up to date

- If RStudio is up to date

- If compiler build tools are installed and available for use

- If devtools and its dependencies are up to date

- If the package's dependencies are up to date

Call this function if things seem weird and you're not sure what's wrong
or how to fix it. If this function returns no output everything should
be ready for package development.

## Usage

``` r
dev_sitrep(pkg = ".", debug = FALSE)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- debug:

  If `TRUE`, will print out extra information useful for debugging. If
  `FALSE`, it will use result cached from a previous run.

## Value

A named list, with S3 class `dev_sitrep` (for printing purposes).

## Examples

``` r
if (FALSE) { # \dontrun{
dev_sitrep()
} # }
```
