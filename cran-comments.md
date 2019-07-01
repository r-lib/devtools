This release removes previously deprecated functions

## Test environments

* local OS X install, R 3.5.1
* Ubuntu 14.04 (on travis-ci), R-oldrel, R-release, R-devel
* Windows Server 2012 R2 (x64), R 3.5.1
* Rhub
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 16.04 LTS, R-release, GCC
* win-builder (devel and release)

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES.

## Downstream dependencies

I ran `R CMD check` on all 316 reverse dependencies
(https://github.com/r-lib/devtools/tree/master/revdep) there were 6 regressions
detected.

* available - submitted release 1.0.3 to fix the issue
* googleAuthR - sent PR https://github.com/MarkEdmondson1234/googleAuthR/pull/150 to fix the issue.
* packagedocs - sent PR https://github.com/hafen/packagedocs/pull/32 to fix the issue.
* soilcarbon - sent PR
  https://github.com/powellcenter-soilcarbon/soilcarbon/pull/19 to remove the
  devtools dependency, the issue also seems to have been already fixed in the
  devel version of the package.
* understandBPMN - sent email to maintainer, patch to fix available at
  https://github.com/cran/understandBPMN/compare/master...jimhester:remove-devtools.patch
* zebu - sent PR https://github.com/oliviermfmartin/zebu/pull/2 to remove the devtools dependency
