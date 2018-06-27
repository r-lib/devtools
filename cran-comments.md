This is a point release fixing failing tests on CRAN and adding support for the
upcoming git2r version 0.22.0

## Test environments

* local OS X install, R 3.4.3
* Ubuntu 12.04 (on travis-ci), R-oldrel, R-release, R-devel
* Windows Server 2012 R2 (x64), R 3.5.0
* Rhub
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Debian Linux, R-devel, GCC ASAN/UBSAN
  * Fedora Linux, R-devel, clang, gfortran
  * Ubuntu Linux 16.04 LTS, R-release, GCC
* win-builder (devel and release)

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES.

## Downstream dependencies

* This change differs from the previous release only by changes to the tests.
  Nonetheless I ran reverse dependency checks on all 232
  dependencies. There were no failures caused by these changes.
