The following notes were generated across my local OS X install, ubuntu running on travis-ci and win builder. Response to NOTEs across three platforms below.

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File ‘devtools/R/package-env.r’:
    attach(NULL, name = pkg_env_name(pkg))

  This is needed because devtools simulates package loading, and hence
  needs to attach environments to the search path.

* There are ::: calls to the package's namespace in its code. A package
  almost never needs to use ::: for its own objects.

  This is needed because that function actually generates an external
  file that is run in a fresh R session.

We also ran R CMD check on all reverse dependencies for r-release: https://github.com/wch/devtools-checkresults/blob/master/r-release/00check-summary.txt. The only failure is with NMF - the failing example seems unrelated to devtools, and it's hard to imagine why the package needs devtools at all.

Compared to the last submission, I have:

* Switched to using rstudioapi instead of rstudio

* Incremented the versions of R that Rtools 3.1 matches based on Brian's
  comment (overriding the version specification from 
  http://cran.r-project.org/bin/windows/Rtools/)

I am aware that devtools does not work on Solaris.
