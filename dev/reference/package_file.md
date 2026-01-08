# Find file in a package.

It always starts by walking up the path until it finds the root
directory, i.e. a directory containing `DESCRIPTION`. If it cannot find
the root directory, or it can't find the specified path, it will throw
an error.

## Usage

``` r
package_file(..., path = ".")
```

## Arguments

- ...:

  Components of the path.

- path:

  Place to start search for package directory.

## Examples

``` r
if (FALSE) { # \dontrun{
package_file("figures", "figure_1")
} # }
```
