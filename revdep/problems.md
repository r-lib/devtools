# ggtaxplot (0.0.1)

* Email: <mailto:clement.coclet@gmail.com>
* GitHub mirror: <https://github.com/cran/ggtaxplot>

Run `revdepcheck::cloud_details(, "ggtaxplot")` for more info

## Newly broken

*   checking re-building of vignette outputs ... ERROR
     ```
     Error(s) in re-building vignettes:
       ...
     --- re-building ‘ggtaxplot.Rmd’ using rmarkdown
     
     Quitting from ggtaxplot.Rmd:18-20 [setup_install]
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     <error/rlib_error_package_not_found>
     Error in `devtools::install_git()`:
     ! The package "remotes" is required.
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'ggtaxplot.Rmd' failed with diagnostics:
     The package "remotes" is required.
     --- failed re-building ‘ggtaxplot.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘ggtaxplot.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# Luminescence (1.1.2)

* GitHub: <https://github.com/R-Lum/Luminescence>
* Email: <mailto:maintainer_luminescence@r-luminescence.org>
* GitHub mirror: <https://github.com/cran/Luminescence>

Run `revdepcheck::cloud_details(, "Luminescence")` for more info

## Newly broken

*   checking Rd cross-references ... WARNING
     ```
     Missing link(s) in Rd file 'install_DevelopmentVersion.Rd':
       ‘[devtools:remote-reexports]{devtools::install_github}’
     
     See section 'Cross-references' in the 'Writing R Extensions' manual.
     ```

# riskmetric (0.2.6)

* GitHub: <https://github.com/pharmaR/riskmetric>
* Email: <mailto:eli.miller@atorusresearch.com>
* GitHub mirror: <https://github.com/cran/riskmetric>

Run `revdepcheck::cloud_details(, "riskmetric")` for more info

## Newly broken

*   checking tests ... ERROR
     ```
       Running ‘testthat.R’
     Running the tests in ‘tests/testthat.R’ failed.
     Complete output:
       > library(testthat)
       > library(riskmetric)
       > 
       > options(repos = "fake-cran.fake-r-project.org")
       > 
       > test_check("riskmetric")
       Execution halted
     ```

# srcpkgs (0.2)

* GitHub: <https://github.com/kforner/srcpkgs>
* Email: <mailto:karl.forner@gmail.com>
* GitHub mirror: <https://github.com/cran/srcpkgs>

Run `revdepcheck::cloud_details(, "srcpkgs")` for more info

## Newly broken

*   checking examples ... ERROR
     ```
     Running examples in ‘srcpkgs-Ex.R’ failed
     The error most likely occurred in:
     
     > ### Name: pkgs_install
     > ### Title: installs a list of source packages
     > ### Aliases: pkgs_install
     > 
     > ### ** Examples
     > 
     > pkg <- setup_and_get_dummy_srcpkg()
     > dest <- tempfile()
     > pkgs_install(pkg, dest)
     Execution halted
     ```

*   checking tests ... ERROR
     ```
     ...
         1. ├─testthat::expect_error(...) at test-pkgs_install.R:43:3
         2. │ └─testthat:::expect_condition_matching_(...)
         3. │   └─testthat:::quasi_capture(...)
         4. │     ├─testthat (local) .capture(...)
         5. │     │ └─base::withCallingHandlers(...)
         6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
         7. └─srcpkgs:::pkg_install_nodeps(src_pkgs$ZZ$path, LIB, quiet = TRUE)
         8.   ├─withr::with_libpaths(...)
         9.   │ └─base::force(code)
        10.   └─devtools::install(...)
        11.     └─(function() {...
        12.       └─pak::local_install_deps(...)
        13.         └─pak:::remote(...)
        14.           └─err$throw(res$error)
       ── Failure ('test-plan.R:12:3'): execute_plan ──────────────────────────────────
       Expected `nrow(plan)` to equal `nrow(mat2)`.
       Differences:
         `actual`: 7
       `expected`: 5
       
       
       [ FAIL 10 | WARN 3 | SKIP 5 | PASS 576 ]
       Error:
       ! Test failures.
       Execution halted
     ```

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
       3.     ├─srcpkgs:::fast_unlist(lapply(pkgs_to_install, .process_pkg))
       4.     │ └─base::unlist(x, recursive, use.names)
       5.     └─base::lapply(pkgs_to_install, .process_pkg)
       6.       └─srcpkgs (local) FUN(X[[i]], ...)
       7.         └─srcpkgs:::pkg_install_nodeps(pkg$path, lib, quiet = quiet, ...)
       8.           ├─withr::with_libpaths(...)
       9.           │ └─base::force(code)
      10.           └─devtools::install(...)
      11.             └─(function() {...
      12.               └─pak::local_install_deps(...)
      13.                 └─pak:::remote(...)
      14.                   └─err$throw(res$error)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'testing_and_checking.Rmd' failed with diagnostics:
     ! error in pak subprocess
     Caused by error in `get_user_cache_dir()`:
     ! R_USER_CACHE_DIR env var not set during package check, see https://github.com/r-lib/pkgcache#README
     --- failed re-building ‘testing_and_checking.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘testing_and_checking.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

