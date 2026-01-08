# Build a Rmarkdown files package

`build_rmd()` is a wrapper around
[`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html)
that first installs a temporary copy of the package, and then renders
each `.Rmd` in a clean R session. `build_readme()` locates your
`README.Rmd` and builds it into a `README.md`

## Usage

``` r
build_rmd(files, path = ".", output_options = list(), ..., quiet = TRUE)

build_readme(path = ".", quiet = TRUE, ...)
```

## Arguments

- files:

  The Rmarkdown files to be rendered.

- path:

  path to the package to build the readme.

- output_options:

  List of output options that can override the options specified in
  metadata (e.g. could be used to force `self_contained` or
  `mathjax = "local"`). Note that this is only valid when the output
  format is read from metadata (i.e. not a custom format object passed
  to `output_format`).

- ...:

  additional arguments passed to
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html)

- quiet:

  If `TRUE`, suppress output.
