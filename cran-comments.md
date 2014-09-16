The following notes were generated across my local OS X install, ubuntu running on travis-ci and win builder. Response to NOTEs across three platforms below.

* checking package dependencies ... NOTE
  Package suggested but not available for checking: 'rmarkdown'

  This is used for the vignettes, and (as described in the Description field)
  available from http://rmarkdown.rstudio.com/. It will be submitted to CRAN
  in the next week or two.

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File 'devtools/R/package-env.r':
      attach(NULL, name = pkg_env_name(pkg))
    File 'devtools/R/shims.r':
      attach(e, name = "devtools_shims", warn.conflicts = FALSE)

  These are needed because devtools simulates package loading, and hence
  needs to attach environments to the search path.

* There are ::: calls to the package's namespace in its code. A package
  almost never needs to use ::: for its own objects.

  This is needed because that function actually generates an external
  file that is run in a fresh R session.

We also ran R CMD check on all reverse dependencies for r-release: https://github.com/wch/devtools-checkresults/blob/master/r-release/00check-summary.txt. The only failure is with NMF - the failing example seems unrelated to devtools, and it's hard to imagine why the package needs devtools at all.
