# Build Rmarkdown files

**\[deprecated\]**

`build_rmd()` is deprecated, as it is a low-level helper for internal
use. To render your package's `README.Rmd` or `README.qmd`, use
[`build_readme()`](https://devtools.r-lib.org/dev/reference/build_readme.md).
To preview a vignette or article, use functions like
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
or
[`pkgdown::build_article()`](https://pkgdown.r-lib.org/reference/build_articles.html).

## Usage

``` r
build_rmd(files, path = ".", output_options = list(), ..., quiet = TRUE)
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
