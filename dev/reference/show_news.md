# Show package news

Show package news

## Usage

``` r
show_news(pkg = ".", latest = TRUE, ...)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- latest:

  if `TRUE`, only show the news for the most recent version.

- ...:

  other arguments passed on to `news`
