## Test environments

* GitHub Actions - (ubuntu-18.04): 3.3, 3.4, 3.5, oldrel, release, devel
* GitHub Actions (windows): release
* Github Actions (macOS): release, devel

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES.

## revdepcheck results

We checked 331 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 3 new problems
 * We failed to check 2 packages

Issues with CRAN packages are summarised below.

### New problems
(This reports the first line of each new failure)

* box - Devtools is used in a box test that relies on the presence of a non-exported function from devtools. This private function was removed, which broke the test. We sent the box authors a pull request with the necessary change to fix their test. (https://github.com/klmr/box/pull/193)
  checking tests ... ERROR

* IalsaSynthesis - This is due to to removal of the `inst()` function from devtools. We notified these maintainers about this on 2020-07-30 (https://github.com/IALSA/IalsaSynthesis/issues/26), but they have not updated their package.
  checking tests ... ERROR

* NlsyLinks - This is due to to removal of the `inst()` function from devtools. We notified these maintainers about this on 2020-07-30 (https://github.com/LiveOak/NlsyLinks/issues/1), but they have not updated their package.
  checking tests ... ERROR
