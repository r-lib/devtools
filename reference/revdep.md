# Reverse dependency tools

Tools to check and notify maintainers of all CRAN and Bioconductor
packages that depend on the specified package.

## Usage

``` r
revdep(
  pkg,
  dependencies = c("Depends", "Imports", "Suggests", "LinkingTo"),
  recursive = FALSE,
  ignore = NULL,
  bioconductor = FALSE
)

revdep_maintainers(pkg = ".")
```

## Arguments

- pkg:

  Package name. This is unlike most devtools packages which take a path
  because you might want to determine dependencies for a package that
  you don't have installed. If omitted, defaults to the name of the
  current package.

- dependencies:

  A character vector listing the types of dependencies to follow.

- recursive:

  If `TRUE` look for full set of recursive dependencies.

- ignore:

  A character vector of package names to ignore. These packages will not
  appear in returned vector.

- bioconductor:

  If `TRUE` also look for dependencies amongst Bioconductor packages.

## Details

The first run in a session will be time-consuming because it must
download all package metadata from CRAN and Bioconductor. Subsequent
runs will be faster.

## See also

The [revdepcheck](https://github.com/r-lib/revdepcheck) package can be
used to run R CMD check on all reverse dependencies.

## Examples

``` r
if (FALSE) { # \dontrun{
revdep("ggplot2")

revdep("ggplot2", ignore = c("xkcd", "zoo"))
} # }
```
