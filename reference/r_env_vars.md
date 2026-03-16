# Environment variables to set when calling R

Devtools sets a number of environmental variables to ensure consistent
between the current R session and the new session, and to ensure that
everything behaves the same across systems. It also suppresses a common
warning on windows, and sets `NOT_CRAN` so you can tell that your code
is not running on CRAN. If `NOT_CRAN` has been set externally, it is not
overwritten.

## Usage

``` r
r_env_vars()
```

## Value

a named character vector
