## Test environments

* local OS X install, R 3.3.1
* ubuntu 12.04 (on travis-ci), R 3.3.1
* win-builder (devel and release)

## R CMD check results

0 ERRORs | 0 WARNINGs | 1 NOTES. 

* Found the following (possibly) invalid URLs: 
  URL: https://cran.r-project.org/web/packages/policies.html
  
  This is a false positive as this isn't a url to a package.

## Downstream dependencies

I ran R CMD check on all 75 downstread dependencies (results at https://github.com/hadley/devtools/tree/master/revdep). As far as I can tell, there are no new problems related to this version of devtools.
