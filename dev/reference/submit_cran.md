# Submit a package to CRAN

This submits your package to CRAN using the web-form submission process.
To complete the submission you will need respond to the email sent to
the maintainer email address.

We generally recommend using this part of the process defined by
[`usethis::use_release_issue()`](https://usethis.r-lib.org/reference/use_release_issue.html);
this process maximizes the chances of a successful submission.

## Usage

``` r
submit_cran(pkg = ".", args = NULL)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD build`.
