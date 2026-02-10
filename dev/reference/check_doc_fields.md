# Check for missing documentation fields

Checks all Rd files in `man/` and looks for any that have a `\usage`
section (i.e. a function) but that *don't* have `\value` and `\examples`
sections. These missing fields are flagged by CRAN on initial
submission.

## Usage

``` r
check_doc_fields(pkg = ".", fields = c("value", "examples"))
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- fields:

  A character vector of Rd field names to check for.

## Value

A named list of character vectors, one for each field, containing the
names of Rd files missing that field. Returned invisibly.

## Examples

``` r
if (FALSE) { # \dontrun{
check_doc_fields(".")
} # }
```
