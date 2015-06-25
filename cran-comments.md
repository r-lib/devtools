## Test environments
* local OS X install, R 3.2.1
* ubuntu 12.04 (on travis-ci), R 3.2.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 2 NOTEs:

* Found the following (possibly) invalid URLs.

  This appears to be a false position: 
  http://cran.r-project.org/web/packages/policies.html is not a URL to
  a package, and hence is not in the canonical form.

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File 'devtools/R/package-env.r':
      attach(NULL, name = pkg_env_name(pkg))
    File 'devtools/R/shims.r':
      attach(e, name = "devtools_shims", warn.conflicts = FALSE)

  These are needed because devtools simulates package loading, and hence
  needs to attach environments to the search path.

(I also get an error on winbuilder R-release, but that looks like a problem with the stringi installation on that machine.)

## Downstream dependencies
I have also run R CMD check on all 34 downstream dependencies of devtools 
(https://github.com/hadley/devtools/blob/master/revdep/summary.md):

* There were 2 failures: 
  
  * REDCapR: This looks to be an SSL connection problem
  * NMF: this failed in the same way previously.

* As far as I can tell, there were no new failures related to changes in 
  devtools.
  
