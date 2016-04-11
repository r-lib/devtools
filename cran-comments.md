## Test environments
* local OS X install, R 3.2.4
* ubuntu 12.04 (on travis-ci), R 3.2.4
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, WARNINGs, and 1 NOTES. 

* Found the following (possibly) invalid URLs: 
  URL: https://cran.r-project.org/web/packages/policies.html
  
  This is a false positive as this isn't a url to a package.

(Note that devtools requires >=0.7.0 of the suggested package gmailr, but the current CRAN version is 0.6.0. This isn't flagged as a problem, but the maintainer is preparing a release in the very near future.)

## Downstream dependencies

* I ran R CMD check on all 77 downstream dependencies of devtools.
  Summary at: https://github.com/hadley/devtools/blob/master/revdep/

* There was 1 ERROR: 

    * BrailleR: checking examples ... ERROR
      
      Appears to be graphics related, so unlikely to be related to devtools.

* I failed to install dependencies for: biomartr, demi, FedData, myTAI, NMF
