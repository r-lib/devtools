# devtools

[![Build Status](https://travis-ci.org/hadley/devtools.png?branch=master)](https://travis-ci.org/hadley/devtools)

The aim of `devtools` is to make your life as a package developer easier by providing R functions that simplify many common tasks. R packages are actually really simple, and with the right tools it should be easier to use the package structure than not. Package development in R can feel intimidating, but devtools does every thing it can to make it as welcoming as possible. `devtools` comes with a small guarantee: if because of a bug in devtools a member of R-core gets angry with you, I will send you a handwritten apology note. Just forward me the email and your address, and I'll get a card in the mail.

`devtools` is opinionated about how to do package development, and requires that you use `roxygen2` for documentation and `testthat` for testing. Not everyone agrees with these opinions, and they are by no means perfect, but they have evolved during the process of writing over 30 R packages. I'm always happy to hear about what doesn't work for you, and any places where devtools gets in your way. Either send an email to the [rdevtools mailing list](http://groups.google.com/group/rdevtools) or file an [issue](http://github.com/hadley/devtools/issues).

## Updating to the latest version of devtools

You can track (and contribute to) development of `devtools` at https://github.com/hadley/devtools. To install it:

1. Install the release version of `devtools` from CRAN with `install.packages("devtools")`.

2. Make sure you have a working development environment.
    * **Windows**: Install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).
    * **Mac**: Install Xcode from the Mac App Store.
    * **Linux**: Install a compiler and various development libraries (details vary across differnet flavors of Linux).

3. Follow the instructions below depending on platform.

    * **Mac and Linux**:

        ```R
        devtools::install_github("hadley/devtools")
        ```

    * **Windows**:

        ```R
        library(devtools)
        build_github_devtools()

        #### Restart R before continuing ####
        install.packages("devtools.zip", repos = NULL)

        # Remove the package after installation
        unlink("devtools.zip")
        ```


## Package development tools

All `devtools` functions accept a path as an argument, e.g. `load_all("path/to/path/mypkg")`. If you don't specify a path, `devtools` will look in the current working directory - this is recommend practice.

Frequent development tasks:

* `load_all()` simulates installing and reloading your package,
  loading R code in `R/`, compiled shared objects in `src/` and data
  files in `data/`. During development you usually want to access all functions so `load_all()` ignores the package `NAMESPACE`.
  `load_all()` will automatically create a `DESCRIPTION` if needed.

* `document()` updates documentation, file collation and
  `NAMESPACE`.

* `test()` reloads your code, then runs all `testthat` tests.

Building and installing:

* `install()` reinstalls the package, detaches the currently
  loaded version then reloads the new version with `library()`. Reloading a package is not guaranteed to work: see the documentation to `unload()` for caveats.

* `build()` builds a package file from package sources. You can
  can use it to build a binary version of your package.

* `install_github()` installs an R package from github,
  `install_gitorious()` from gitorious, `install_bitbucket()` from
  bitbucket, `install_url()` from an arbitrary url and
  `install_file()` from a local file on disk. `install_version()`
  installs a specified version from cran.

Check and release:

* `check()` updates the documentation, then builds and checks
  the package. `build_win()` builds a package using
  [win-builder](http://win-builder.r-project.org/), allowing you to easily check your package on windows.

* `run_examples()` will run all examples to make sure they work.
  This is useful because example checking is the last step of `R CMD check`.

* `check_doc()` runs most of the documentation checking components
  of `R CMD check`

* `release()` makes sure everything is ok with your package
  (including asking you a number of questions), then builds and
  uploads to CRAN. It also drafts an email to let the CRAN
  maintainers know that you've uploaded a new package.

Other commands:

* `bash()` opens a bash shell in your package directory so you can
  use git or other command line tools.

* `wd()` changes the working directory to a path relative to the
  package root.

## Development mode

Calling `dev_mode()` will switch your version of R into "development mode". In this mode, R will install packages to `~/R-dev`. This is useful to avoid clobbering the existing versions of CRAN packages that you need for other tasks. Calling `dev_mode()` again will turn development mode off, and return you to your default library setup.

## Other tips

I recommend adding the following code to your `.Rprofile`:

```R
.First <- function() {
  options(
    repos = c(CRAN = "http://cran.rstudio.com/"),
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
* `devtools.desc.author`: your R author string, in the form of `"Hadley Wickham <h.wickham@@gmail.com> [aut, cre]"`. Used when creating default `DESCRIPTION` files.
* `devtools.desc.license`: a default license used when creating new packages
