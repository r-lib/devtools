# useful errors if too few or too many

    Code
      build_readme(pkg)
    Condition
      Error in `build_readme()`:
      ! Can't find 'README.Rmd' or 'inst/README.Rmd'.

---

    Code
      build_readme(pkg)
    Condition
      Error in `build_readme()`:
      ! Can't have both 'README.Rmd' and 'inst/README.Rmd'.

# build_rmd() is deprecated

    Code
      suppressMessages(build_rmd("README.Rmd", path = pkg, quiet = TRUE))
    Condition
      Warning:
      `build_rmd()` was deprecated in devtools 2.5.0.
      i Please use `build_readme()` instead.

