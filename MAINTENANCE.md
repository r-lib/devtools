# NA

## Current state

Devtools is generally stable, most of the active development has moved
to sub-packages like remotes and usethis, and relatively little code
lives in devtools itself.

## Known outstanding issues

I don’t know of any major outstanding issues in devtools itself.

## Future directions

The package development cheatsheet likely needs a major overhaul to
account for much more functionality in usethis and the current state of
devtools. <https://github.com/r-lib/devtools/issues/2107>

Should devtools be converted to use pak for installation, or should the
installation commands be deprecated in devtools and users suggested to
use pak directly?

## R CMD check notes

devtools has some vintage tests around `.Rnw` vignettes. It’s not clear
if it makes sense to keep these, but I (jennybc) am not rushing to
remove these tests. Since I inherited the maintainership of devtools, I
have not pursued why 2 of these tests fail locally (they are skipped on
GHA). However, today, I did sort it out and want to record what I did.
In case it comes up in the future, this caused the necessary LaTeX
package to be installed:

``` r
tinytex::parse_install(
  text = "! LaTeX Error: File `grfext.sty' not found."
)
```
