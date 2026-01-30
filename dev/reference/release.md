# Release package to CRAN.

**\[deprecated\]**

`release()` is deprecated in favour of
[`usethis::use_release_issue()`](https://usethis.r-lib.org/reference/use_release_issue.html).
We no longer feel confident recommending `release()` because we don't
use it ourselves, so there's no guarantee that it will track best
practices as they evolve over time.

If you want to programmatical submit to CRAN, you can continue to use
[`submit_cran()`](https://devtools.r-lib.org/dev/reference/submit_cran.md).

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

## See also

[`usethis::use_release_issue()`](https://usethis.r-lib.org/reference/use_release_issue.html)
to create a checklist of release tasks that you can use in addition to
or in place of `release`.
