## Release summary

This is another minor release to fix the logic that devtools uses for detecting RTools (specifically for the new toolchain, without registry settings).  I think this time we have all the cases covered - thanks for the help, Uwe!

## Test environments
* local OS X install, R 3.2.4
* ubuntu 12.04 (on travis-ci), R 3.2.4
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, WARNINGs, and 1 NOTES. 

* Found the following (possibly) invalid URLs: 
  URL: https://cran.r-project.org/web/packages/policies.html
  
  This is a false positive as this isn't a url to a package.

## Downstream dependencies

* I did not check downstream dependencies.
