# Build README

Renders an executable README, i.e. `README.qmd` or `README.Rmd`, to
`README.md`. Specifically, `build_readme()`:

- Installs a copy of the package's current source to a temporary library

- Renders the README in a clean R session

## Usage

``` r
build_readme(path = ".", quiet = TRUE, ...)
```

## Arguments

- path:

  Path to the top-level directory of the source package.

- quiet:

  If `TRUE`, suppresses most output. Set to `FALSE` if you need to
  debug.

- ...:

  Additional arguments passed to
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html),
  in the case of `README.Rmd`. Not used for `README.qmd`
