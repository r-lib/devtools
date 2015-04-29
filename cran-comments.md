## Test environments
* local OS X install, R 3.1.2
* ubuntu 12.04 (on travis-ci), R 3.1.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 2 NOTEs:

* checking dependencies in R code ... NOTE
  'library' or 'require' call to ‘testthat’ in package code.
  
  devtools::test() calls library(testthat) because testthat must be 
  attached to the search path for testthat unit tests to work.

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File 'devtools/R/package-env.r':
      attach(NULL, name = pkg_env_name(pkg))
    File 'devtools/R/shims.r':
      attach(e, name = "devtools_shims", warn.conflicts = FALSE)

  These are needed because devtools simulates package loading, and hence
  needs to attach environments to the search path.

I also get a whole lot of NOTEs of the nature "a possible error in paste0(...): ... used in a situation where it does not exist". I believe these are an error in R CMD check, as noted in my post on the topic to R-devel.

## Downstream dependencies
I have also run R CMD check on all 18 downstream dependencies of devtools 
(https://github.com/hadley/devtools/blob/master/revdep/summary.md):

* There was 1 failure: REDCapR. This looks to be an SSL connection problem
  so I don't believe it's related to the devtools update.
  
* I could not install metafolio to check it.
  
* I have reported all the existing R CMD CHECK notes to revdep maintainers.
