The following notes were generated across my local OS X install, ubuntu running on travis-ci and win builder. Response to NOTEs across three platforms below.

* I'm changing my maintainer email address to hadley@rstudio.com

* checking dependencies in R code ... NOTE
  Namespace in Imports field not imported from: ‘memoise’
  All declared Imports should be used.
  
  memoise is a build-time dependency.

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File 'devtools/R/package-env.r':
      attach(NULL, name = pkg_env_name(pkg))
    File 'devtools/R/shims.r':
      attach(e, name = "devtools_shims", warn.conflicts = FALSE)

  These are needed because devtools simulates package loading, and hence
  needs to attach environments to the search path.

We also ran R CMD check on all reverse dependencies for r-release: https://github.com/wch/checkresults/tree/master/devtools/r-release. There were no failures.
