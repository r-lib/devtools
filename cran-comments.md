This is a point release fixing failing tests on CRAN.

This release also makes Jim Hester the new maintainer of devtools. Hadley
Wickham will need to approve the change <hadley@rstudio.com>.

## Test environments

* local OS X install, R 3.4.3
* Ubuntu 12.04 (on travis-ci), R-oldrel, R-release, R-devel
* Windows Server 2012 R2 (x64), R 3.4.3
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

- amt - 'sessioninfo' >= * must be installed for this functionality.
- archivist - Error: ‘sessioninfo’ >= * must be installed for this functionality.
- assertive\* - could not find function "with_envvar"
- automagic - ‘github_pull’ is not exported by 'namespace:devtools'
- baytrends - Error: ‘sessioninfo’ >= * must be installed for this functionality.
- BiocWorkflowTools - Warning: 'create' is deprecated.
- CluMix - Error: ‘sessioninfo’ >= * must be installed for this functionality.
- cogena - lots of errors, is Bioc package, so no worried about it
- DataPackageR - not sure, bunch of tests + examples failing, maybe something with load_all?
- derfinderData - sessioninfo
- exampletestr - deprecated usethis functions
- fakemake - usethis
- ggalluvial - sessioninfo
- ggforce - sessioninfo
- githubinstall - github_pull not exported
- icd9 - Missing or unexported object: ‘devtools::load_data’
- metagenomeFeatures - 'sessioninfo' >= * must be installed for this functionality.
- microsamplingDesign - dev_package_deps
- miscset - Error: ‘sessioninfo’ >= * must be installed for this functionality.
- msgtools - usethis
- pacman - ‘devtools::github_pull’ ‘devtools::github_release’
- PKPDmisc - 'sessioninfo' >= * must be installed for this functionality.
- PSPManalysis - error: 'setup_rtools' is not an exported object from 'namespace:devtools'
- REDCapR - 'sessioninfo' >= * must be installed for this functionality.
- RIVER - 'sessioninfo' >= * must be installed for this functionality.
- spectrolab - usethis
- srnadiff - 'sessioninfo' >= * must be installed for this functionality.
- testthat - usethis
- tosca - looks like false positive
- unitizer - not sure - TODO investigate
- yearn - not sure - github_pull

