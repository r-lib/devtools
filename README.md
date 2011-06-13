# devtools

The aim of devtools is to make your life as a package developer easy. 

It does this by providing tools to:

* simulate `R CMD install` during development  (IN PROGRESS)
* interactively run some parts of `R CMD check`
* build documentation, run tests and benchmarking your code
* help you release your package

These tools are described in more detail below.

## Installation

There are two ways to reload the package from disk:

* `load_all("pkg")` will package dependencies described in `DESCRIPTION`, R
  code in `R/`, compiled shared objects in `src/`, data files in `data/`. It
  keeps your global workspace clean by loading all objects into a package
  environment, and works efficiently by only reloading files that have
  changed. During development you usually want to access all functions (even
  if not exported), so `load_all` ignores the package `NAMESPACE`.

* Alternatively, you can run `install("pkg"); reload()`. This will
  reinstall the package using `R CMD install`, detach the package namespace
  and the then reload the package using `library`. Non-internal functions will
  not be available, so this slower option is more suitable as you get closer
  to release.

## Referring to a package

All `devtools` functions accept either a path or a name. If you're only developing a small number of packages, the easiest way to use devtools is ensure that your working directory is set to the directory in which you package lives.

If you are developing many packges, it may be more convenient to refer to packages by name. In this case, `devtools` will `~/.Rpackages`, and try the path given by the default function, if it's not there, it will look up the package name in the list and use that path. For example, a small section of my `~/.Rpackages` looks like this:

    list(
        default = function(x) {
          file.path("~/documents/", x, x)
        }, 

      "describedisplay" = "~/ggobi/describedisplay",
      "tourr" =    "~/documents/tour/tourr", 
      "mutatr" = "~/documents/oo/mutatr"
    )

If you don't specify a package, `devtools` will use the last package you referred to.

