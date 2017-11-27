# devtools

[![Build Status](https://travis-ci.org/hadley/devtools.svg?branch=master)](https://travis-ci.org/hadley/devtools)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/hadley/devtools?branch=master&svg=true)](https://ci.appveyor.com/project/hadley/devtools)
[![Coverage Status](https://codecov.io/github/hadley/devtools/coverage.svg?branch=master)](https://codecov.io/github/hadley/devtools?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/devtools)](https://cran.r-project.org/package=devtools)


The aim of `devtools` is to make package development easier by providing R functions that simplify common tasks.

An R package is actually quite simple. A package is a template or set of conventions that structures your code. This not only makes sharing code easy, it reduces the time and effort required to complete you project: following a template removes the need to have to think about how to organize things and paves the way for the creation of standardised tools that can further accelerate your progress.

While package development in R can feel intimidating, `devtools` does every thing it can to make it less so. In fact, `devtools` comes with a small guarantee: if you get an angry e-mail from an R-core member because of a bug in `devtools`, forward me the email and your address and I'll mail you a card with a handwritten apology.

`devtools` is opinionated about package development. It requires that you use `roxygen2` for documentation and `testthat` for testing. Not everyone would agree with this approach, and they are by no means perfect. But they have evolved out of the experience of writing over 30 R packages.

I'm always happy to hear about what doesn't work for you and where `devtools` gets in your way. Either send an email to the [rdevtools mailing list](http://groups.google.com/group/rdevtools) or file an [issue at the GitHub repository](http://github.com/hadley/devtools/issues).

## Updating to the latest version of devtools

You can track (and contribute to) the development of `devtools` at https://github.com/hadley/devtools. To install it:

1. Install the release version of `devtools` from CRAN with `install.packages("devtools")`.

2. Make sure you have a working development environment.
    * **Windows**: Install [Rtools](https://cran.r-project.org/bin/windows/Rtools/).
    * **Mac**: Install Xcode from the Mac App Store.
    * **Linux**: Install a compiler and various development libraries (details vary across different flavors of Linux).

3. Install the development version of devtools.

   ```R
   devtools::install_github("hadley/devtools")
   ```

## Package development tools

All `devtools` functions accept a path as an argument, e.g. `load_all("path/to/path/mypkg")`. If you don't specify a path, `devtools` will look in the current working directory - this is recommended practice.

Frequent development tasks:

* `load_all()` simulates installing and reloading your package,
  loading R code in `R/`, compiled shared objects in `src/` and data
  files in `data/`. During development you usually want to access all 
  functions so `load_all()` ignores the package `NAMESPACE`.
  `load_all()` will automatically create a `DESCRIPTION` if needed.

* `document()` updates documentation, file collation and
  `NAMESPACE`.

* `test()` reloads your code, then runs all `testthat` tests.

Building and installing:

* `install()` reinstalls the package, detaches the currently loaded version 
  then reloads the new version with `library()`. Reloading a package is not
  guaranteed to work: see the documentation to `unload()` for caveats.

* `build()` builds a package file from package sources. You can
  use it to build a binary version of your package.

* `install_*` functions install an R package:
   * `install_github()` from github,
   * `install_bitbucket()` from bitbucket, 
   * `install_url()` from an arbitrary url and
   * `install_local()` from a local file on disk. 
   * `install_version()` installs a specified version from cran.

Check and release:

* `check()` updates the documentation, then builds and checks the package. 
  `build_win()` builds a package using 
  [win-builder](http://win-builder.r-project.org/), allowing you to easily check 
  your package on windows.

* `run_examples()` will run all examples to make sure they work.
  This is useful because example checking is the last step of `R CMD check`.

* `check_man()` runs most of the documentation checking components
  of `R CMD check`

* `release()` makes sure everything is ok with your package
  (including asking you a number of questions), then builds and
  uploads to CRAN. It also drafts an email to let the CRAN
  maintainers know that you've uploaded a new package.

## Diaspora

devtools started off as a lean-and-mean package to facilitate local package development, but over the years it accumulated more and more functionality. Currently devtools is undergoing a diaspora to split out functionality into smaller, more tightly focussed packages. The diaspora includes:

* [pkgbuild](https://github.com/r-lib/pkgbuild): Building binary packages
  (including checking if build tools are available).

* [pkgload](https://github.com/r-lib/pkgload): Simulating package loading 
  (i.e. `load_all()`)

* [rcmdcheck](https://github.com/r-lib/rcmdcheck): Running R CMD check
  and reporting the results.

* [revdepcheck](https://github.com/r-lib/revdepcheck): Running R CMD check
  on all reverse dependencies, and figuring out what's changed since the 
  last CRAN release.

* [remotes](https://github.com/r-lib/remotes): Installing packages.

* [sessioninfo](https://github.com/r-lib/sessioninfo): Session info.

* [usethis](https://github.com/r-lib/usethis): Automating package setup.

Generally, you should not need to worry about these different packages, because devtools installs them all automatically. You will need to care, however, if you're filing a bug because reporting it at the correct place will lead to a speedier resolution.

## Other tips

I recommend adding the following code to your `.Rprofile`:

```R
.First <- function() {
  options(
    repos = c(CRAN = "https://cran.rstudio.com/"),
    browserNLdisabled = TRUE,
    deparse.max.lines = 2)
}

if (interactive()) {
  suppressMessages(require(devtools))
}
```

See the complete list in `?devtools`

This will set up R to:

* always install packages from the RStudio CRAN mirror
* ignore newlines when  `browse()`ing
* give minimal output from `traceback()`
* automatically load `devtools` in interactive sessions

There are also a number of options you might want to set (in `.Rprofile`) to customise the default behaviour when creating packages and drafting emails:

* `devtools.name`: your name, used to sign emails
* `devtools.desc.author`: your R author string, in the form of `"Hadley Wickham <h.wickham@gmail.com> [aut, cre]"`. Used when creating default `DESCRIPTION` files.
* `devtools.desc.license`: a default license used when creating new packages

# Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
