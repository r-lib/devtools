# Build README

Renders an executable README, such as `README.Rmd`, to `README.md`.
Specifically, `build_readme()`:

- Installs a copy of the package's current source to a temporary library

- Renders the README in a clean R session

## Usage

``` r
build_readme(path = ".", quiet = TRUE, ...)
```

## Arguments

- path:

  Path to the package to build the README.

- quiet:

  If `TRUE`, suppresses most output. Set to `FALSE` if you need to
  debug.

- ...:

  Additional arguments passed to
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).
