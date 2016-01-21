## Test environments
* local OS X install, R 3.2.1
* ubuntu 12.04 (on travis-ci), R 3.2.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 2 NOTEs:

* checking foreign function calls ... NOTE
  Evaluating ‘dll$foo’ during check gives error
  
  This is part of a dynamic check to see if the user can compile packages
  so `dll` does not exist during checking.

* Found the following (possibly) invalid URLs: 
  URL: https://cran.r-project.org/web/packages/policies.html
  
  This is a false positive as this isn't a url to a package.

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File 'devtools/R/package-env.r':
      attach(NULL, name = pkg_env_name(pkg))
    File 'devtools/R/shims.r':
      attach(e, name = "devtools_shims", warn.conflicts = FALSE)

  These are needed because devtools simulates package loading, and hence
  needs to attach environments to the search path.

## Downstream dependencies

* I ran R CMD check on all 75 downstream dependencies of devtools.
  Summary at: https://github.com/hadley/devtools/blob/master/revdep/summary.md

* There was 1 failure: 

  * assertive.reflection: due to error in \donttest().
  * jiebaR: 
  
  * NMF: this failed in the same way previously. I have reported the issue
    to the maintainer, but I'm reasonably certain it's not related to devtools.

* As far as I can tell, there were no new failures related to changes in 
  devtools.

assertive.reflection
