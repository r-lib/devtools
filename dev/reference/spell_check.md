# Spell checking

Runs a spell check on text fields in the package description file,
manual pages, and optionally vignettes. Wraps the
[spelling](https://docs.ropensci.org/spelling//reference/spell_check_package.html)
package.

## Usage

``` r
spell_check(pkg = ".", vignettes = TRUE, use_wordlist = TRUE)
```

## Arguments

- pkg:

  The package to use, can be a file path to the package or a package
  object. See
  [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  for more information.

- vignettes:

  also check all `rmd` and `rnw` files in the pkg `vignettes` folder

- use_wordlist:

  ignore words in the package
  [WORDLIST](https://docs.ropensci.org/spelling//reference/wordlist.html)
  file
