# Create a package

Create a package

## Usage

``` r
create(path, ..., open = FALSE)
```

## Arguments

- path:

  A path. If it exists, it is used. If it does not exist, it is created,
  provided that the parent path exists.

- ...:

  Additional arguments passed to
  [`usethis::create_package()`](https://usethis.r-lib.org/reference/create_package.html)

- open:

  If `TRUE`,
  [activates](https://usethis.r-lib.org/reference/proj_activate.html)
  the new project:

  - If using RStudio or Positron, the new project is opened in a new
    session, window, or browser tab, depending on the product (RStudio
    or Positron) and context (desktop or server).

  - Otherwise, the working directory and active project of the current R
    session are changed to the new project.

## Value

The path to the created package, invisibly.
