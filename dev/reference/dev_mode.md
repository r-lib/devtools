# Activate and deactivate development mode

**\[deprecated\]**

We no longer recommend `dev_mode()` and it will be removed in a future
release of devtools. Instead, we now rely on
[`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md) to
test drive an in-development package. If you really like the idea of
corralling experimental packages in a special library, you might enjoy
[`withr::local_libpaths()`](https://withr.r-lib.org/reference/with_libpaths.html).
If you are concerned about different projects interfering with each
other through the use of a shared library, consider using the [renv
package](https://rstudio.github.io/renv/).

Original description: When activated, `dev_mode` creates a new library
for storing installed packages. This new library is automatically
created when `dev_mode` is activated if it does not already exist. This
allows you to test development packages in a sandbox, without
interfering with the other packages you have installed.

## Usage

``` r
dev_mode(on = NULL, path = getOption("devtools.path"))
```

## Arguments

- on:

  turn dev mode on (`TRUE`) or off (`FALSE`). If omitted will guess
  based on whether or not `path` is in
  [`.libPaths()`](https://rdrr.io/r/base/libPaths.html)

- path:

  directory to library.

## Examples

``` r
if (FALSE) { # \dontrun{
dev_mode()
dev_mode()
} # }
```
