I have not run revdep checks for this small patch release (v2.5.2).

The notes below pertain to the recent minor version release (v2.5.0), which was on 2026-03-14, about 6 weeks ago.

## revdepcheck results

We checked 549 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 3 new problems
 * We failed to check 3 packages

Issues with CRAN packages are summarised below.

### New problems

All maintainers were alerted to this breakage >2 weeks ago.

It is all related to devtools deprecating its `install_*()` functions, in favor direct use of pak.

(This reports the first line of each new failure)

* ggtaxplot
  checking re-building of vignette outputs ... ERROR

* riskmetric
  checking tests ... ERROR

* srcpkgs
  checking examples ... ERROR
  checking tests ... ERROR
  checking re-building of vignette outputs ... ERROR

### Failed to check

* caugi       (NA)
* ClustAssess (NA)
* streamDAG   (NA)
