# Release package to CRAN.

Run automated and manual tests, then post package to CRAN.

## Usage

``` r
release(pkg = ".", check = FALSE, args = NULL)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- check:

  if `TRUE`, run checking, otherwise omit it. This is useful if you've
  just checked your package and you're ready to release it.

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD build`.

## Details

The package release process will:

- Confirm that the package passes `R CMD check` on relevant platforms

- Confirm that important files are up-to-date

- Build the package

- Submit the package to CRAN, using comments in "cran-comments.md"

You can add arbitrary extra questions by defining an (un-exported)
function called `release_questions()` that returns a character vector of
additional questions to ask.

You also need to read the CRAN repository policy at
'https://cran.r-project.org/web/packages/policies.html' and make sure
you're in line with the policies. `release` tries to automate as many of
polices as possible, but it's impossible to be completely comprehensive,
and they do change in between releases of devtools.

## See also

[`usethis::use_release_issue()`](https://usethis.r-lib.org/reference/use_release_issue.html)
to create a checklist of release tasks that you can use in addition to
or in place of `release`.
