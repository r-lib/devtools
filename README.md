# devtools

The aim of `devtools` is to make your life as a package developer easy. It does this by providing tools to:

* simulate `R CMD install` during development
* build documentation (using roxygen), run tests (using testthat)
* run `R CMD check` from within R
* help you release your package

These tools are described in more detail below.

To use all features of devtools, you also need to install `RCurl`.  To get it:

* On windows, run 
  `install.packages("RCurl", repos = "http://www.stats.ox.ac.uk/pub/RWin/")`
* On everything else, run 
  `install.packages("RCurl")`

I also recommend that you use my fork of roxygen, rather than the official CRAN version. Once you've installed and loaded `devtools`, you can install this direct from my github account by running `install_github("roxygen")`.

## Installation

There are two ways to reload the package from disk:

* `load_all("pkg")` will load package dependencies described in `DESCRIPTION`,
  R code in `R/`, compiled shared objects in `src/`, data files in `data/`. It
  keeps your global workspace clean by loading all objects into a package
  environment, and works efficiently by only reloading files that have
  changed. 

  During development you usually want to access all functions (even if not
  exported), so `load_all` ignores the package `NAMESPACE`.

* Alternatively, you can run `install("pkg")`. This will reinstall the package
  using `R CMD install`, detach the package and its namespace and then reload
  it using `library`. Reloading a package is not guaranteed to work: see the
  documentation to `reload` for caveats.

  Non-internal functions will not be available and `install` is somewhat
  slower than `load_all`, so this option is more suitable as you get closer to
  release.

## Check and release

* `document()` will re-roxygenise all your source files.

* `test()` will run `testthat` tests in your package.

* `check()` will update the documentation, then build and check the package.

* `run_examples()` will run all examples in your package. The second parameter
  specifies which file to start with.  `document()` is automatically run 
  prior to running examples.

* `release()` will make sure everything is ok with your package (including
  asking you a number of questions to verify that everything is ok), then
  build and upload to CRAN. It will also draft an email to let the CRAN
  maintainer know that you've uploaded a new package.

## Development mode

Calling `dev_mode()` will switch your version of R into "development mode". In this mode, R will install packages to `~/R-dev`. This is useful to avoid clobbering existing versions of CRAN packages. Calling `dev_mode()` again will turn development mode off, and return you to your default library set up.

## Referring to a package

All `devtools` functions accept either a path or a name. If you're only developing a small number of packages, the easiest way to use devtools is ensure that your working directory is set to the directory in which you package lives.

If you don't specify a package, all `devtools` commands automatically use the last package you referred to.

If you are developing many packages, it may be more convenient to refer to packages by name. In this case, `devtools` will `~/.Rpackages`, and try the path given by the default function, if it's not there, it will look up the package name in the list and use that path. For example, a small section of my `~/.Rpackages` looks like this:

    list(
        default = function(x) {
          file.path("~/documents/", x, x)
        }, 

      "describedisplay" = "~/ggobi/describedisplay",
      "tourr" =    "~/documents/tour/tourr", 
      "mutatr" = "~/documents/oo/mutatr"
    )

