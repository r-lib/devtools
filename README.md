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

## Package development tools

Frequent development tasks:

* `load_all("pkg")` simulates installing and reloading your package, by
  loading R code in `R/`, compiled shared objects in `src/` and data files in
  `data/`. During development you usually want to access all functions so
  `load_all` ignores the package `NAMESPACE`. It works efficiently by only
  reloading files that have changed. It's not 100% correct, but it's very
  fast.

* `document("pkg")` updates documentation, file collation and `NAMESPACE`. It
  also runs some basic checks on the generated `Rd` files.

* `test("pkg")` runs all `testthat` tests in your package.

Building and installing:

* `build("pkg")` builds a package file from package sources. This is used by
  `install` and `check` to ensure that your development directory is left
  untouched.

* `install("pkg")` reinstalls the package, detaches the currently loaded
  version then reloads the new version with `library`. Reloading a package is
  not guaranteed to work: see the documentation to `reload` for caveats.

Check and release:

* `check("pkg")` updates the documentation, then builds and checks the
  package.

* `run_examples()` runs all examples to make sure they work. This is useful
  because example checking is the last step of `R CMD check`.

* `release()` makes sure everything is ok with your package (including asking
  you a number of questions), then builds and uploads to CRAN. It also drafts
  an email to let the CRAN maintainer know that you've uploaded a new package.

Other commands:

* `bash()` opens a bash shell in your package directory so you can use 
   git or other command line tools.

## Development mode

Calling `dev_mode()` will switch your version of R into "development mode". In this mode, R will install packages to `~/R-dev`. This is useful to avoid clobbering the existing versions of CRAN packages, that you need for other analyses you're performing . Calling `dev_mode()` again will turn development mode off, and return you to your default library setup.

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

