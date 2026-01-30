# Check documentation, as `R CMD check` does

This function attempts to run the documentation related checks in the
same way that `R CMD check` does. Unfortunately it can't run them all
because some tests require the package to be loaded, and the way they
attempt to load the code conflicts with how devtools does it.

## Usage

``` r
check_man(pkg = ".")
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

## Value

Nothing. This function is called purely for it's side effects: if no
errors there will be no output.

## Examples

``` r
if (FALSE) { # \dontrun{
check_man("mypkg")
} # }
```
