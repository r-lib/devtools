# Execute pkgdown build_site in a package

`build_site()` is a shortcut for
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html),
it generates the static HTML documentation.

## Usage

``` r
build_site(path = ".", quiet = TRUE, ...)
```

## Arguments

- path:

  path to the package to build the static HTML.

- quiet:

  If `TRUE`, suppress output.

- ...:

  additional arguments passed to
  [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
