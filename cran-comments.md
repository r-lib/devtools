## Test environments
* local OS X install, R 3.1.2
* ubuntu 12.04 (on travis-ci), R 3.1.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 2 NOTEs:

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

## Downstream dependencies
I have also run R CMD check on all 5 downstream dependencies of devtools 
(https://github.com/hadley/devtools/blob/master/revdep/summary.md). All packages 
passed. I only ran revdep checks on packages that include or depend on devtools, because devtools is supposed to be used interactively for package development, not supply code to other packages.

