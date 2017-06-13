This is a point release working around a Rcpp regression that broke devtools
tests (https://github.com/RcppCore/Rcpp/pull/697).

## Test environments

* local OS X install, R 3.4.0
* Ubuntu 12.04 (on travis-ci), R-oldrel, R-release, R-devel
* Windows Server 2012 R2 (x64), R 3.4.0
* Rhub
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Debian Linux, R-devel, GCC ASAN/UBSAN
  * Fedora Linux, R-devel, clang, gfortran
  * Ubuntu Linux 16.04 LTS, R-release, GCC
* win-builder (devel and release)

## R CMD check results

0 ERRORs | 0 WARNINGs | 1 NOTES.

* Found the following (possibly) invalid URLs:
  URL: https://cran.r-project.org/web/packages/policies.html

  This is a false positive as this isn't a url to a package.

## Downstream dependencies

* We did not run R CMD check as there was a recent release, however we do not
  anticipate any issues with this change.
