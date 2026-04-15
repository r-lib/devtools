# useful errors if too few or too many

    Code
      build_readme(pkg)
    Condition
      Error in `build_readme()`:
      ! Can't find 'README.qmd' or 'README.Rmd', at the top-level or below 'inst/'.

---

    Code
      build_readme(pkg)
    Condition
      Error in `build_readme()`:
      ! Found multiple executable READMEs: 'README.Rmd' and 'inst/README.Rmd'. There can only be one.

# errors if both README.qmd and README.Rmd exist

    Code
      build_readme(pkg)
    Condition
      Error in `build_readme()`:
      ! Found multiple executable READMEs: 'README.qmd' and 'README.Rmd'. There can only be one.

# build_readme() aborts when a dep is missing

    Code
      build_readme(pkg)
    Condition
      Error in `build_readme()`:
      ! 1 {PACKAGE} dependency is not installed.
      i Install it with `pak::local_install_dev_deps()`.
        missingpkg (missing)

# build_rmd() is deprecated

    Code
      suppressMessages(build_rmd("README.Rmd", path = pkg, quiet = TRUE))
    Condition
      Warning:
      `build_rmd()` was deprecated in devtools 2.5.0.
      i Please use `build_readme()` instead.

