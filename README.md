# devtools

The aim of `devtools` is to make your life as a package developer easy, by R functions that simplify many of the common tasks of package development. Devtools is currently very opinionated about how to do package development, and requires that you use `roxygen` for documentation and `testthat` for testing. Future version will relax these opinions - patches are welcome! Track development of `devtools` at https://github.com/hadley/devtools.

I also recommend that you use `roxygen2`, which has not quite made it to CRAN yet. Once you've installed and loaded `devtools`, you can install the development version of roxygen by running `install_github("roxygen", "klutometis")`.

## Package development tools

Frequent development tasks:

* `load_all("pkg")` simulates installing and reloading your package, by
  loading R code in `R/`, compiled shared objects in `src/` and data files in
  `data/`. During development you usually want to access all functions so
  `load_all` ignores the package `NAMESPACE`. It works efficiently by only
  reloading files that have changed. It's not 100% correct, but it's very
  fast.

* `document("pkg")` updates documentation, file collation and `NAMESPACE`. 

* `test("pkg")` reloads your code, then runs all `testthat` tests.

Building and installing:

* `build("pkg")` builds a package file from package sources. This is used by
  `install` and `check` to ensure that your development directory is left
  untouched. You can also use it to build a binary version of your package.

* `build_win("pkg")` builds a package using
  [win-builder](http://win-builder.r-project.org/), allowing you to easily
  make a windows binary package if you're not on windows.

* `install("pkg")` reinstalls the package, detaches the currently loaded
  version then reloads the new version with `library`. Reloading a package is
  not guaranteed to work: see the documentation to `reload` for caveats.
  
* `install_github("repo", "username")` installs an R package from github.

Check and release:

* `check("pkg")` updates the documentation, then builds and checks the
  package.

* `run_examples()` runs all examples to make sure they work. This is useful
  because example checking is the last step of `R CMD check`.

* `check_doc()` runs most of the documentation checking components of `R CMD
  check`

* `release()` makes sure everything is ok with your package (including asking
  you a number of questions), then builds and uploads to CRAN. It also drafts
  an email to let the CRAN maintainer know that you've uploaded a new package.

Other commands:

* `bash()` opens a bash shell in your package directory so you can use 
   git or other command line tools.

* `wd()` changes the working directory to a path relative to the package root.

## Development mode

Calling `dev_mode()` will switch your version of R into "development mode". In this mode, R will install packages to `~/R-dev`. This is useful to avoid clobbering the existing versions of CRAN packages that you need for other tasks. Calling `dev_mode()` again will turn development mode off, and return you to your default library setup.

## Referring to a package

All `devtools` functions accept either a path, a name, or nothing.

* Specifying a path is easiest if you're only developing a small number of
  packages. Just ensuring your working directory is the directory in which
  your packages live then use (e.g.) `install("mypkg")`

* If you don't specify anything, all `devtools` commands automatically use the
  last package you referred to.

* Specifying package names is useful if you are developing many packages. In
  this case, `devtools` will look in `~/.Rpackages`, and try the path given by
  the default function, if it's not there, it will look up the package name in
  the list and use that path. 

  For example, a small section of my `~/.Rpackages` looks like this:

        list(
            default = function(x) {
              file.path("~/documents/", x, x)
            }, 

          "describedisplay" = "~/ggobi/describedisplay",
          "tourr" =    "~/documents/tour/tourr", 
          "mutatr" = "~/documents/oo/mutatr"
        )

## Other tips

I recommend adding the following code to your `.Rprofile`:

    .First <- function() {
      options(
        repos = c(CRAN = "http://cran.r-project.org/"),
        browserNLdisabled = TRUE,
        deparse.max.lines = 2)
    }

    if (interactive()) {
      suppressMessages(require(devtools))
    }

This will set up R to:

* always install packages from the main CRAN mirror
* ignore newlines when  `browse()`ing
* give minimal output from `traceback`
* automatically load `devtools` in interactive sessions
