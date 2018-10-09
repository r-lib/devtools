This is a point release fixing failing tests on CRAN.

This release also makes Jim Hester the new maintainer of devtools. Hadley
Wickham will need to approve the change <hadley@rstudio.com>.

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

* I tested all 303 reverse dependencies on CRAN and Bioconductor. The full
  results can be viewed at
  https://github.com/r-lib/devtools/tree/master/revdep#readme

### 4 packages have additional warnings with devtools 2.0.0

These warnings are due to functions now deprecated in devtools that have been
moved to the usethis package. The maintainers were notified on 2018-09-21 they
should change their dependency from devtools to usethis.

- BiocWorkflowTools - Maintainer notified on 2018-09-21 to switch to the **usethis** package.
- fakemake  - Maintainer notified on 2018-09-21 to switch to the **usethis** package.
- msgtools  - Maintainer notified on 2018-09-21 to switch to the **usethis** package.
- spectrolab - Maintainer notified on 2018-09-21 to switch to the **usethis** package.

### 10 packages have additional errors with devtools 2.0.0

In all cases either pull requests were sent to the authors to fix the errors or
maintainers contacted via email.

- assertive\* - emailed on 2018-09-19, maintainer responded on same day saying they would
  update the packages.
- pacman - Already fixed in devel version - https://github.com/trinker/pacman/issues/113
- PSPManalysis - https://github.com/cran/PSPManalysis/blob/729b7b05b28a95b924773e17971589824fe7dd05/R/setup.R#L2-L13 - (emailed 2018-10-09)
- testthat - https://github.com/r-lib/testthat/pull/803
- unitizer - https://github.com/brodieG/unitizer/pull/255
