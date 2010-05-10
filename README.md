# devtools

The aim of devtools is to make your life as a package developer easy. 

It does this by providing tools to:

* simulate `R CMD install` during development  (IN PROGRESS)
* interactively run some parts of `R CMD check`
* build documentation, run tests and benchmarking your code
* help you release your package

These tools are described in more detail below.

## Installation

While developing a package, you often want to reload all objects in the package without having to quit R, run `R CMD install` and then reopen. `load_all` will package dependencies described in `DESCRIPTION`, R code in `R/`, compiled shared objects in  `src/`, data files in `data/`.

It keeps your global workspace clean by loading all objects into an environment called `devel:package-name`, and works efficiently by only reload files that have changed.

## Referring to a package

All `devtools` functions as either a path or a name. If you specify a name it will first look in `~/documents/name/name` (because that's how I organise my packages), and if not found there it will load `~/.Rpackages` which should be an R list mapping package name to full path.  

For example, a small section of my `~/.Rpackages` looks like this:

    list(
      "describedisplay" = "~/ggobi/describedisplay",
      "tourr" =    "~/documents/tour/tourr", 
      "mutatr" = "~/documents/oo/mutatr"
    )
    
## `.Rprofile`

To make it even easier to use, you might want to add the following lines to your `.Rprofile`:

    if (interactive()) {
      suppressMessages(require(devtools))
      l <- function(pkg, ...) {
        pkg <- tolower(deparse(substitute(pkg)))
        load_all(pkg, ...)
      }  
    }

That way you can reload any development package with the minimum of typing.