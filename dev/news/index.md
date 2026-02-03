# Changelog

## devtools (development version)

- [`bash()`](https://devtools.r-lib.org/dev/reference/bash.md),
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md),
  [`missing_s3()`](https://devtools.r-lib.org/dev/reference/missing_s3.md),
  [`reload()`](https://devtools.r-lib.org/dev/reference/reload.md),
  [`show_news()`](https://devtools.r-lib.org/dev/reference/show_news.md),
  and [`wd()`](https://devtools.r-lib.org/dev/reference/wd.md) are now
  deprecated. These functions are all historical parts of our workflow
  that we no longer use or recommend.
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md) is
  superseded by
  [`usethis::create_package()`](https://usethis.r-lib.org/reference/create_package.html).
- [`build_manual()`](https://devtools.r-lib.org/dev/reference/build_manual.md)
  reports more details on failure
  ([\#2586](https://github.com/r-lib/devtools/issues/2586)).
- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  and
  [`clean_vignettes()`](https://devtools.r-lib.org/dev/reference/clean_vignettes.md)
  are now deprecated. We no longer recommend building vignettes in this
  way; instead use
  [`pkgdown::build_article()`](https://pkgdown.r-lib.org/reference/build_articles.html)
  to render articles locally
  ([\#2488](https://github.com/r-lib/devtools/issues/2488)).
- [`build_site()`](https://devtools.r-lib.org/dev/reference/build_site.md)
  now just calls
  [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html),
  meaning that you will get more (informative) output by default
  ([\#2578](https://github.com/r-lib/devtools/issues/2578)).
- New
  [`check_mac_devel()`](https://devtools.r-lib.org/dev/reference/check_mac_release.md)
  function to check a package using the macOS builder at
  <https://mac.r-project.org/macbuilder/submit.html>
  ([@nfrerebeau](https://github.com/nfrerebeau),
  [\#2507](https://github.com/r-lib/devtools/issues/2507))
- [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  now works correctly in Positron
  ([\#2618](https://github.com/r-lib/devtools/issues/2618)).
- [`is_loading()`](https://pkgload.r-lib.org/reference/load_all.html) is
  now re-exported from pkgload
  ([\#2556](https://github.com/r-lib/devtools/issues/2556)).
- Package installation functions are now deprecated:
  [`install_bioc()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_cran()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md),
  [`install_dev()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_dev_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md),
  [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_gitlab()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_local()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_svn()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_url()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`update_packages()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`dev_package_deps()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`github_pull()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  and
  [`github_release()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md).
  We now recommend pak (<https://pak.r-lib.org/>) for general package
  installation. See `?install-deprecated` for migration guidance.
- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  now errors if called recursively, i.e. if you accidentally include a
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  call in one of your R source files
  ([\#2617](https://github.com/r-lib/devtools/issues/2617)).
- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) is
  deprecated in favour of
  [`usethis::use_release_issue()`](https://usethis.r-lib.org/reference/use_release_issue.html).
- [`show_news()`](https://devtools.r-lib.org/dev/reference/show_news.md)
  now looks for NEWS files in the same locations as
  [`utils::news()`](https://rdrr.io/r/utils/news.html): `inst/NEWS.Rd`,
  `NEWS.md`, `NEWS`, and `inst/NEWS`
  ([@arcresu](https://github.com/arcresu),
  [\#2499](https://github.com/r-lib/devtools/issues/2499)).

## devtools 2.4.6

CRAN release: 2025-10-03

- Functions that use httr now explicitly check that it is installed
  ([@catalamarti](https://github.com/catalamarti),
  [\#2573](https://github.com/r-lib/devtools/issues/2573)).

- [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md)
  now works if the package has not been installed.

- [`test_coverage_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  now reports if any tests failed and does a better job of executing
  snapshot comparisons.

- [`dev_mode()`](https://devtools.r-lib.org/dev/reference/dev_mode.md)
  and
  [`check_rhub()`](https://devtools.r-lib.org/dev/reference/check_rhub.md)
  are deprecated.

## devtools 2.4.5

CRAN release: 2022-10-11

- `check(cleanup =)` was deprecated in devtools v1.11.0 (2016-04-12) and
  was made defunct in v2.4.4 (2022-07-20). The documentation is more
  clear now about recommended alternatives.

- `check(check_dir = NULL)` is the new default, to align with the
  default behaviour of the underlying
  [`rcmdcheck::rcmdcheck()`](http://r-lib.github.io/rcmdcheck/reference/rcmdcheck.md).

- `check(cran = TRUE)` sets the env var
  `_R_CHECK_PACKAGES_USED_IGNORE_UNUSED_IMPORTS_` to `FALSE`, in order
  to surface the `"Namespace in Imports field not imported from"` NOTE.
  This only applies to R \>= 4.2, due to favorable changes in the
  behaviour of `R CMD check --as-cran`
  ([\#2459](https://github.com/r-lib/devtools/issues/2459)).

- [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  passes the package onto to testthat so it can correctly set the
  `TESTTHAT_PKG` envvar
  ([\#2470](https://github.com/r-lib/devtools/issues/2470)).

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) and
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  once again work with testthat itself.

- [`dev_mode()`](https://devtools.r-lib.org/dev/reference/dev_mode.md)
  is deprecated ([@billdenney](https://github.com/billdenney),
  [\#2467](https://github.com/r-lib/devtools/issues/2467)).

## devtools 2.4.4

CRAN release: 2022-07-20

- `install(reload = TRUE)` now calls
  [`pkgload::unregister()`](https://pkgload.r-lib.org/reference/unload.html)
  instead of `pkload::unload()`
  ([\#2349](https://github.com/r-lib/devtools/issues/2349)). This allows
  the package to keep functioning if it is still in use in the R session
  (e.g. through event handlers).

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) no longer
  calls
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  twice.
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  now calls
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  via testthat.

- `aspell_env_var()` does a better job of matching `R CMD check`
  behaviour, which is only to use `aspell`, not `hunspell` or `ispell`
  ([\#2376](https://github.com/r-lib/devtools/issues/2376)).

- Installing devtools now installs pkgdown, profvis, bench, miniUI, and
  urlchecker, ensuring that you have everything needed for package
  development ([\#2388](https://github.com/r-lib/devtools/issues/2388)).

- [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  has been updated for the calendar-based version number scheme adopted
  by the RStudio IDE in September 2021
  ([\#2397](https://github.com/r-lib/devtools/issues/2397),
  [\#2410](https://github.com/r-lib/devtools/issues/2410)).

## devtools 2.4.3

CRAN release: 2021-11-30

- New
  [`check_mac_release()`](https://devtools.r-lib.org/dev/reference/check_mac_release.md)
  function to check a package using the macOS builder at
  <https://mac.r-project.org/macbuilder/submit.html>
  ([\#2375](https://github.com/r-lib/devtools/issues/2375))

- Jenny Bryan is now the official maintainer.

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) and
  [`submit_cran()`](https://devtools.r-lib.org/dev/reference/submit_cran.md)
  now record submission details using the Debian Control File format,
  for better machine-readability. This file has a new name,
  CRAN-SUBMISSION (instead of CRAN-RELEASE) and now includes package
  version, in addition to the full SHA and a timestamp.

## devtools 2.4.2

CRAN release: 2021-06-07

- [`check_man()`](https://devtools.r-lib.org/dev/reference/check_man.md)
  now works with R versions 4.1+
  ([\#2354](https://github.com/r-lib/devtools/issues/2354))

- [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  now again works on windows projects stored under the user’s home
  directory (`~`)
  ([\#2355](https://github.com/r-lib/devtools/issues/2355))

- `document(quiet = TRUE)` now works without failure on windows
  ([\#2351](https://github.com/r-lib/devtools/issues/2351))

- Minor test failure on R 4.2 has been fixed.

- New Rstudio addin for
  [`run_examples()`](https://devtools.r-lib.org/dev/reference/run_examples.md)
  ([\#2358](https://github.com/r-lib/devtools/issues/2358))

## devtools 2.4.1

CRAN release: 2021-05-05

- [`build_readme()`](https://devtools.r-lib.org/dev/reference/build_rmd.md)
  now uses the `path` argument, as designed
  ([\#2344](https://github.com/r-lib/devtools/issues/2344))

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md) no
  longer opens projects by default to avoid duplicate projects opened by
  the RStudio IDE project template
  ([\#2347](https://github.com/r-lib/devtools/issues/2347),
  [@malcolmbarrett](https://github.com/malcolmbarrett))

- The RStudio addins now use
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  and
  [`test_coverage_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  instead of the deprecated
  [`test_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  and
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  ([\#2339](https://github.com/r-lib/devtools/issues/2339))

- RStudio addins now run in interactive mode, rather than background
  mode ([@jennybc](https://github.com/jennybc),
  [\#2350](https://github.com/r-lib/devtools/issues/2350))

- `install(upgrade)` now defaults to ‘default’ rather than ‘ask’. This
  allows you to control the default asking behavior with the
  `R_REMOTES_UPGRADE` environment variable
  ([\#2345](https://github.com/r-lib/devtools/issues/2345))

## devtools 2.4.0

CRAN release: 2021-04-07

### Breaking changes and deprecated functions

- The `check_results()` function has been removed. It was not used by
  any CRAN package, and much better alternatives are available in the
  [rcmdcheck](https://github.com/r-lib/rcmdcheck) package.

- [`pkgload::inst()`](https://pkgload.r-lib.org/reference/inst.html) is
  no longer re-exported
  ([\#2218](https://github.com/r-lib/devtools/issues/2218)).

- [`test_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  has been renamed to
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  and
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  has been renamed to
  [`test_coverage_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  to avoid a name collision with
  [`testthat::test_file()`](https://testthat.r-lib.org/reference/test_file.html).
  The previous names have been soft deprecated in this release, they
  will be hard deprecated in the next release and eventually removed.
  ([\#2125](https://github.com/r-lib/devtools/issues/2125))

### Re-licensing

- devtools is now released under a MIT license
  ([\#2326](https://github.com/r-lib/devtools/issues/2326))

### Minor improvements and fixes

- [`build_readme()`](https://devtools.r-lib.org/dev/reference/build_rmd.md)
  now supports readme files located in `inst/README.Rmd`, as intended
  ([\#2333](https://github.com/r-lib/devtools/issues/2333))

- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  now creates more specific `.gitignore` entries
  ([@klmr](https://github.com/klmr),
  [\#2317](https://github.com/r-lib/devtools/issues/2317))

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  only re-documents if you have a matching version of roxygen2
  ([\#2263](https://github.com/r-lib/devtools/issues/2263)).

- `change_maintainer_email()` now has a check to assess whether the
  email is actually changed. If the email is not changed, the code now
  stops such that an email is not accidentally sent to the wrong
  recipient. ([@emilsjoerup](https://github.com/emilsjoerup),
  [\#2073](https://github.com/r-lib/devtools/issues/2073))

- `run_examples(fresh = TRUE)` again works without error
  ([\#2264](https://github.com/r-lib/devtools/issues/2264))

- The covr and DT packages have been moved from Imports to Suggests.
  They are only needed when running
  [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md)
  and
  [`test_coverage_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  so now you’ll be prompted to install them when needed.

- Switched to fs for all file system functions
  ([\#2331](https://github.com/r-lib/devtools/issues/2331),
  [@malcolmbarrett](https://github.com/malcolmbarrett))

- Now uses testthat 3.0.0 to power
  [`test()`](https://devtools.r-lib.org/dev/reference/test.md),
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md),
  [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md),
  and
  [`test_coverage_active_file()`](https://devtools.r-lib.org/dev/reference/test.md).
  The major difference is that
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  now generates a compact summary that takes up less space on the
  console.

## devtools 2.3.2

CRAN release: 2020-09-18

- Fix for compatibility with withr 2.3.0

## devtools 2.3.1

CRAN release: 2020-07-21

- `check_win_*()` function now resets the email to the original email
  after execution, this bug was fixed and crept back in
  ([@muschellij2](https://github.com/muschellij2),
  [\#2152](https://github.com/r-lib/devtools/issues/2152)).

- [`run_examples()`](https://devtools.r-lib.org/dev/reference/run_examples.md)
  arguments `run` and `test` are deprecated in favor of the (hopefully)
  more clear `run_dontrun` and `run_donttest` (pkgload/#107).

- Previously deprecated functions `dr_devtools()` and `dr_github()` have
  been removed.

- Documentation has been synced with remotes 2.2.0

## devtools 2.3.0

CRAN release: 2020-04-10

- [`build()`](https://devtools.r-lib.org/dev/reference/build.md) now
  errors with a more informative error message when passed an invalid
  `pkg`. ([\#2177](https://github.com/r-lib/devtools/issues/2177))

- New
  [`build_rmd()`](https://devtools.r-lib.org/dev/reference/build_rmd.md)
  can build any `.Rmd` file in a clean session.

- [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  now works correctly when R is out of date
  ([\#2204](https://github.com/r-lib/devtools/issues/2204))

## devtools 2.2.2

CRAN release: 2020-02-17

- [`install_dev_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  now passes formal args onto
  [`remotes::install_deps()`](https://remotes.r-lib.org/reference/install_deps.html)
  ([@t-gibson](https://github.com/t-gibson),
  [\#2166](https://github.com/r-lib/devtools/issues/2166))

- [`spell_check()`](https://devtools.r-lib.org/dev/reference/spell_check.md)
  now checks if `spelling` is installed and prompts users to install it
  if not ([@mikemahoney218](https://github.com/mikemahoney218),
  [\#2172](https://github.com/r-lib/devtools/issues/2172))

- [`submit_cran()`](https://devtools.r-lib.org/dev/reference/submit_cran.md)
  now returns a more informative error when the CRAN submission portal
  is down ([\#1958](https://github.com/r-lib/devtools/issues/1958))

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) gains a
  `vignettes` argument, to more easily disable checks for vignettes
  ([\#2165](https://github.com/r-lib/devtools/issues/2165)).

- `check_win_*()` function now resets the email to the original email
  after execution ([@muschellij2](https://github.com/muschellij2),
  [\#2152](https://github.com/r-lib/devtools/issues/2152)).

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  sets `NOT_CRAN=true` by default, as was originally intended
  ([\#2135](https://github.com/r-lib/devtools/issues/2135)).

- [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  now supports `options("devtools.ellipsis_action")` as well
  ([\#2169](https://github.com/r-lib/devtools/issues/2169))

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) now takes
  `stop_on_failure` as a formal argument (FALSE by default) instead of
  in `...`. Its value is still passed to
  [`testthat::test_dir`](https://testthat.r-lib.org/reference/test_dir.html)
  as before ([@infotroph](https://github.com/infotroph),
  [\#2129](https://github.com/r-lib/devtools/issues/2129)).

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) and
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  gain a `export_all` argument, which controls if all functions in a
  package are automatically exported
  ([\#1201](https://github.com/r-lib/devtools/issues/1201)).

- [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  now works if run outside a package directory
  ([\#2127](https://github.com/r-lib/devtools/issues/2127)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  works if the package root is not in the working directory.

## devtools 2.2.1

CRAN release: 2019-09-24

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) now sets
  the collation order to `C` before running, which matches the behavior
  of tests when run with `R CMD check`
  ([\#2121](https://github.com/r-lib/devtools/issues/2121))

- New `options("devtools.ellipsis_action")` option added to control the
  action of ellipsis in devtools. This should be one of

  - [`rlang::abort`](https://rlang.r-lib.org/reference/abort.html) - to
    emit an error if arguments are unused
  - [`rlang::warn`](https://rlang.r-lib.org/reference/abort.html) - to
    emit a warning if arguments are unused
  - [`rlang::inform`](https://rlang.r-lib.org/reference/abort.html) - to
    emit a message if arguments are unused
  - [`rlang::signal`](https://rlang.r-lib.org/reference/abort.html) - to
    emit a message if arguments are unused Using
    [`rlang::signal`](https://rlang.r-lib.org/reference/abort.html) will
    produce no output unless the custom condition is caught, so it is
    the best way to retain backwards compatibility with devtools
    behavior prior to 2.2.0. The default behavior was also changed to
    issue a warning rather than an error if any arguments are unused, as
    there are some cases where devtools does not need to install the
    package, so unused arguments are false positives
    ([\#2109](https://github.com/r-lib/devtools/issues/2109)).

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) now
  throws an error when it fails, as intended
  ([\#2120](https://github.com/r-lib/devtools/issues/2120))

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) now
  again reloads and re-attaches packages if they were previously loaded
  ([\#2111](https://github.com/r-lib/devtools/issues/2111)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) no
  longer calls the deprecated `dr_devtools()`
  ([\#2105](https://github.com/r-lib/devtools/issues/2105))

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) now
  explicitly passes `stop_on_failure = FALSE` to
  [`testthat::test_dir()`](https://testthat.r-lib.org/reference/test_dir.html)
  ([@jameslamb](https://github.com/jameslamb),
  [\#2099](https://github.com/r-lib/devtools/issues/2099))

## devtools 2.2.0

CRAN release: 2019-09-07

### New Features

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md) added
  back, the RStudio IDE uses
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md) in
  the create packages dialog, so removing it in version 2.1.0 broke old
  versions of the IDE.

- New
  [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  function to return information about your development environment and
  diagnose common problems. The former functions `dr_devtools()` and
  `dr_github()` have been deprecated.
  ([\#1970](https://github.com/r-lib/devtools/issues/1970))

- All functions taking `...` now use the ellipsis package. This catches
  errors when arguments are misspelled or incorrectly specified
  ([\#2016](https://github.com/r-lib/devtools/issues/2016))

### Minor improvements and fixes

- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  now correctly installs the vignette builder if it is not already
  installed ([\#2089](https://github.com/r-lib/devtools/issues/2089)).

- [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  now uses the same endpoint to detect the current RStudio version as
  the IDE ([\#2050](https://github.com/r-lib/devtools/issues/2050)).

- [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  gains a `quiet` parameter, to silence output and
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  passes its quiet argument to it
  ([\#1986](https://github.com/r-lib/devtools/issues/1986)).

- Add the DT package as a dependency, so that
  [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md)
  and
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  work without having to install additional packages
  ([\#2085](https://github.com/r-lib/devtools/issues/2085)).

- [`check_man()`](https://devtools.r-lib.org/dev/reference/check_man.md)
  now succeeds when
  [`tools::undoc()`](https://rdrr.io/r/tools/undoc.html) returns empty
  results ([\#1944](https://github.com/r-lib/devtools/issues/1944)).

- `check_win_*()` functions gain a `email` argument, so temporarily
  change the email the check results will be sent to
  ([\#1723](https://github.com/r-lib/devtools/issues/1723)).

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) now
  explicitly unloads packages before trying to install a new version
  ([\#2094](https://github.com/r-lib/devtools/issues/2094)).

- All `install_*()` functions now attach build tools to the PATH, which
  makes them work on Windows when RTools is not on the default PATH
  ([\#2093](https://github.com/r-lib/devtools/issues/2093)).

- [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  now works when there is not a 1 to 1 correspondence between test and
  source files
  ([\#2011](https://github.com/r-lib/devtools/issues/2011)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  works again when `pkg` is not the current working directory
  ([\#1974](https://github.com/r-lib/devtools/issues/1974)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  works without error when `options("repos")` is unnamed
  ([\#1956](https://github.com/r-lib/devtools/issues/1956)).

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md)
  added, the RStudio IDE uses
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md), so
  removing it in version 2.1.0 broke old versions of the IDE.

- In several places `http:` URLs were used instead of `https:`, the most
  critical being in the `cran_mirror`, `cran_pacakges`, and
  `cran_submission_url` values which could have enabled discrete
  activity disclosure and person-in-the-middle attacks (i.e. changing
  the contents while uploading/downloading). All `http:` URLS have been
  changed to `https:` URLs. ([@hrbrmstr](https://github.com/hrbrmstr),
  [\#2091](https://github.com/r-lib/devtools/issues/2091))

## devtools 2.1.0

CRAN release: 2019-07-06

### New Features

- `testthat` and `roxygen2` are now added to `Imports` rather than
  `Suggests`, so they are automatically installed when you install
  devtools.

### Deprecated functions now removed

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md),
  `create_description()`, `setup()` `use_appveyor()`,
  `use_build_ignore()`, `use_code_of_conduct()`, `use_coverage()`,
  `use_cran_badge()`, `use_cran_comments()`, `use_data()`,
  `use_data_raw()`, `use_dev_version()`, `use_git()`, `use_git_hook()`,
  `use_github()`, `use_github_links()`, `use_gpl3_license()`,
  `use_mit_license()`, `use_news_md()`, `use_package()`,
  `use_package_doc()`, `use_rcpp()`, `use_readme_md()`,
  `use_readme_rmd()`, `use_revdep()`, `use_rstudio()`, `use_test()`,
  `use_testthat()`, `use_travis()`, `use_vignette()`, have been removed
  after being deprecated in previous releases. Use the versions in the
  [usethis](https://usethis.r-lib.org/) package directly.

- `check_cran()`, `revdep_check()`, `revdep_check_print_problems()`,
  `revdep_check_reset()`, `revdep_check_resume()`,
  `revdep_check_save_summary()`, `revdep_email()` have been removed
  after being deprecated in previous releases. It is recommended to use
  the [revdepcheck](https://github.com/r-lib/revdepcheck) package
  instead.

- `system_check()`, `system_output()` have been removed after being
  deprecated in previous releases. It is recommend to use the
  [processx](https://processx.r-lib.org/) package instead.

- `build_win()` has been removed, after being deprecated in previous
  releases.

- `yesno()` as used in
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  has clearer synonyms for “yes”
  ([@mattmalin](https://github.com/mattmalin),
  [\#1993](https://github.com/r-lib/devtools/issues/1993))

### Minor improvements and fixes

- `check_rhub` gains a new argument `build_args` for arguments passed to
  `R CMD build`. `...` is now passed to
  [`rhub::check_for_cran()`](https://r-hub.github.io/rhub/reference/check_for_cran.html)
  ([@gaborcsardi](https://github.com/gaborcsardi),
  [@maelle](https://github.com/maelle),
  [\#2041](https://github.com/r-lib/devtools/issues/2041))

- [`build_manual()`](https://devtools.r-lib.org/dev/reference/build_manual.md)
  now fails if the manual fails to build.
  ([\#2056](https://github.com/r-lib/devtools/issues/2056))

- [`test_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  and
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  now work with C and C++ files in the src/ directory as well.

## devtools 2.0.2

CRAN release: 2019-04-08

- Two tests are now skipped when run on CRAN, as they fail due to an
  outdated pandoc and restrictions on writing to the package library
  respectively.

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  now accepts ‘package’ objects, regaining previous behavior in devtools
  prior to 2.0.0
  ([\#1923](https://github.com/r-lib/devtools/issues/1923))

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md),
  [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md)
  and
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  now set the `TESTTHAT_PKG` environment variable, so it is more
  consistent with running the tests during `R CMD check` (testthat#787).

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  replaces existing environment variables rather than appending them
  ([\#1914](https://github.com/r-lib/devtools/issues/1914)).

## devtools 2.0.1

CRAN release: 2018-10-26

This is a minor release mainly fixing bugs which snuck through in the
devtools 2.0.0 release.

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) now
  correctly passes the `upgrade` parameter to
  [`remotes::install_deps()`](https://remotes.r-lib.org/reference/install_deps.html)
  ([@Paxanator](https://github.com/Paxanator),
  [\#1898](https://github.com/r-lib/devtools/issues/1898)).

- [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  now again works from any directory within a package
  ([\#1905](https://github.com/r-lib/devtools/issues/1905))

- Add a RStudio addin for
  [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md).

- All tests which use remote resources are now skipped on CRAN, to avoid
  spurious failures

## devtools 2.0.0

CRAN release: 2018-10-19

Devtools 2.0.0 is a *major* release that contains work from the past
year and a half, since the major devtools release (1.13.0).

This release splits the functionality in **devtools** into a number of
smaller packages which are simpler to develop and also easier for other
packages to depend on. In particular the following packages have been
spun off in what we are calling the ‘conscious uncoupling’ of
**devtools**.

- remotes: Installing packages
  (i.e. [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)).
- pkgbuild: Building binary packages (including checking if build tools
  are available)
  (i.e. [`build()`](https://devtools.r-lib.org/dev/reference/build.md)).
- pkgload: Simulating package loading
  (i.e. [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)).
- rcmdcheck: Running R CMD check and reporting the results
  (i.e. [`check()`](https://devtools.r-lib.org/dev/reference/check.md)).
- revdepcheck: Running R CMD check on all reverse dependencies, and
  figuring out what’s changed since the last CRAN release
  (i.e. `revdep_check()`).
- sessioninfo: R session info
  (i.e. [`session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)).
- usethis: Automating package setup (i.e. `use_test()`).

devtools will remain the main package developers will interact with when
writing R packages; it will just rely on these other packages internally
for most of the functionality.

### Breaking changes

There have been a number of breaking changes in this release, while this
will cause some short term pain for users it will result in a easier to
understand API in the future, so we feel the tradeoff is worthwhile.

- [`devtools::install()`](https://devtools.r-lib.org/dev/reference/install.md)
  arguments have been changed as follows.

  - `local` -\> `build`
  - `force_deps` -\> `force`
  - `upgrade_dependencies` -\> `upgrade`
  - `threads` -\> Removed, but you can use `Ncpus`, which is passed by
    `...` to
    [`install.packages()`](https://rdrr.io/r/utils/install.packages.html)
  - `metadata` -\> Removed
  - `out_dir` -\> Removed
  - `skip_if_log_exists` -\> Removed

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md)
  argument `check_version` has been renamed to `remote` to better
  describe what tests are disabled
  ([\#1811](https://github.com/r-lib/devtools/issues/1811))

- `get_path()`, `set_path()`, `add_path()` and `on_path()` have been
  removed, this functionality is available with
  [`withr::with_path()`](https://withr.r-lib.org/reference/with_path.html)
  ([\#1796](https://github.com/r-lib/devtools/issues/1796)).

- The `lang` argument to
  [`spell_check()`](https://devtools.r-lib.org/dev/reference/spell_check.md)
  was removed, for compatibility with
  [spelling](https://CRAN.R-project.org/package=spelling) v1.1.
  ([\#1715](https://github.com/r-lib/devtools/issues/1715))

- The previously deprecated `with_` functions have now been removed. The
  functionality has been moved to the **withr** package.

- `RCMD()`, `clean_source()`, `eval_clean()` and `evalq_clean()` have
  been removed. These functions never worked terribly well, and have
  been replaced by the much better functions in **callr**.

- `build_win()` has been renamed to
  [`check_win_release()`](https://devtools.r-lib.org/dev/reference/check_win.md),
  [`check_win_devel()`](https://devtools.r-lib.org/dev/reference/check_win.md),
  and
  [`check_win_oldrelease()`](https://devtools.r-lib.org/dev/reference/check_win.md)
  ([\#1598](https://github.com/r-lib/devtools/issues/1598)).

### Deprecated functions

- Infrastructure functions (`use_*`) now use the implementations in
  **usethis** and the versions in **devtools** are deprecated. If you
  use these from a package you should switch your package to depend on
  **usethis** directly instead.

- The `revdep_check_*` functions have been deprecated in favor of the
  **revdepcheck** package.

- `system_check()` and `system_output()` have been deprecated in factor
  of the **processx** package.

### Major changes

- All `install_*()` functions are now re-exported from **remotes**
  rather than being defined in **devtools**

- **devtools** now depends on **roxygen2** 6.1.0: this considerably
  simplifies
  [`devtools::document()`](https://devtools.r-lib.org/dev/reference/document.md)
  and makes it more consistent with
  [`roxygen2::roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html).

- [`test_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  function added to test one or more files from a package
  ([\#1755](https://github.com/r-lib/devtools/issues/1755)).

- [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md)
  function added to provide a helper to compute test coverage using
  **covr** ([\#1628](https://github.com/r-lib/devtools/issues/1628)).

- [`test_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  and
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-deprecated.md)
  now have RStudio addins
  ([\#1650](https://github.com/r-lib/devtools/issues/1650))

- `test_file_coverage()` function added to show the test coverage of one
  or more files from a package.
  ([\#1755](https://github.com/r-lib/devtools/issues/1755)).

- [`session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)
  now uses the implementation in the **sessioninfo** package. Packages
  using
  [`devtools::session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)
  are encouraged to switch to using
  [`sessioninfo::session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)
  instead.

- [`package_info()`](https://sessioninfo.r-lib.org/reference/package_info.html)
  function now re-exported from the **sessioninfo** package.

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  uses **rcmdcheck** to run and parse R CMD check output
  ([\#1153](https://github.com/r-lib/devtools/issues/1153)).

- Code related to simulating package loading has been pulled out into a
  separate package, **pkgload**. The following functions have been moved
  to pkgload without a shim:
  [`clean_dll()`](https://pkgbuild.r-lib.org/reference/clean_dll.html),
  `compile_dll()`, `dev_example()`, `dev_help()`, `dev_meta()`,
  `find_topic()`, `imports_env()`, `inst()`, `load_code()`,
  `load_dll()`, `ns_env()`, `parse_ns_file()`, `pkg_env()`. These
  functions are primarily for internal use.

  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  and [`unload()`](https://pkgload.r-lib.org/reference/unload.html) have
  been moved to pkgload, but **devtools** provides shims since these are
  commonly used.

- [`find_rtools()`](https://pkgbuild.r-lib.org/reference/has_rtools.html),
  `setup_rtools()`,
  [`has_devel()`](https://pkgbuild.r-lib.org/reference/has_compiler.html),
  `compiler_flags()`,
  [`build()`](https://devtools.r-lib.org/dev/reference/build.md) and
  [`with_debug()`](https://pkgbuild.r-lib.org/reference/with_debug.html)
  have moved to the new **pkgbuild** package.
  [`build()`](https://devtools.r-lib.org/dev/reference/build.md) and
  [`with_debug()`](https://pkgbuild.r-lib.org/reference/with_debug.html)
  are re-exported by **devtools**

- The
  [`spell_check()`](https://devtools.r-lib.org/dev/reference/spell_check.md)
  code has been moved into the new **spelling** package and has thereby
  gained support for vignettes and package wordlists. The **devtools**
  function now wraps
  [`spelling::spell_check_package()`](https://docs.ropensci.org/spelling//reference/spell_check_package.html).

### Minor improvements and fixes

- `check_win_*()` now build the package with `manual = TRUE` by default
  ([\#1890](https://github.com/r-lib/devtools/issues/1890)).

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) output
  now works more nicely with recent changes to **rcmdcheck**
  ([\#1874](https://github.com/r-lib/devtools/issues/1874)).

- [`reload()`](https://devtools.r-lib.org/dev/reference/reload.md) now
  reloads loaded but not attached packages as well as attached ones.

- Executed `styler::style_pkg()` to update code style
  ([\#1851](https://github.com/r-lib/devtools/issues/1851),
  [@amundsenjunior](https://github.com/amundsenjunior)).

- [`save_all()`](https://devtools.r-lib.org/dev/reference/save_all.md)
  helper function wraps
  [`rstudioapi::documentSaveAll()`](https://rstudio.github.io/rstudioapi/reference/rstudio-documents.html)
  calls ([\#1850](https://github.com/r-lib/devtools/issues/1850),
  [@amundsenjunior](https://github.com/amundsenjunior)).

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  allows users to run without `--timings`
  ([\#1655](https://github.com/r-lib/devtools/issues/1655))

- [`update_packages()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  better documented to advertise it can be used to update packages
  installed by any of the `install_*` functions.

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) gains a
  `incoming` option to toggle the CRAN incoming checks.

- `build_vignette()` gains a `keep_md` option to allow keeping the
  intermediate markdown output
  ([\#1726](https://github.com/r-lib/devtools/issues/1726))

- `remote_sha.github()` now correctly looks up SHA in private
  repositories ([\#1827](https://github.com/r-lib/devtools/issues/1827),
  [@renozao](https://github.com/renozao)).

- **devtools** `use_*()` functions now temporarily set the active
  **usethis** project if given a pkg argument that is not the current
  directory. This provides backwards compatibility with previous
  behavior ([\#1823](https://github.com/r-lib/devtools/issues/1823)).

- Vignettes are now built in a separate process, and the package is
  installed before building the vignettes
  ([\#1822](https://github.com/r-lib/devtools/issues/1822))

- [`build_readme()`](https://devtools.r-lib.org/dev/reference/build_rmd.md)
  added to build the README.md from a README.Rmd
  ([\#1762](https://github.com/r-lib/devtools/issues/1762))

- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  now has a `clean` and `upgrade` arguments, to control cleaning of
  intermediate files and upgrading vignette dependencies respectively.
  ([\#1770](https://github.com/r-lib/devtools/issues/1770)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  gains an additional question ensuring you updated codemeta.json if one
  exists ([\#1774](https://github.com/r-lib/devtools/issues/1774),
  [\#1754](https://github.com/r-lib/devtools/issues/1754))

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) now sets
  `useFancyQuotes = FALSE` to better mimic the environment tests are run
  under with `R CMD check`
  ([\#1735](https://github.com/r-lib/devtools/issues/1735)).

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) no longer
  passes encoding argument to
  [`testthat::test_dir()`](https://testthat.r-lib.org/reference/test_dir.html)
  ([\#1776](https://github.com/r-lib/devtools/issues/1776))

- [`install_url()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  can now install package binaries on windows
  ([\#1765](https://github.com/r-lib/devtools/issues/1765))

- Fix skipping when installing from a full SHA
  ([\#1624](https://github.com/r-lib/devtools/issues/1624))

- add
  [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
  wrapper ([@kiwiroy](https://github.com/kiwiroy),
  [\#1777](https://github.com/r-lib/devtools/issues/1777))

- add pkgdown site (<https://devtools.r-lib.org>)
  ([\#1779](https://github.com/r-lib/devtools/issues/1779),
  [@jayhesselberth](https://github.com/jayhesselberth))

- [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  can now install current version of CRAN package on Windows and macOS
  ([@jdblischak](https://github.com/jdblischak),
  [\#1730](https://github.com/r-lib/devtools/issues/1730))

- The CRAN-RELEASE file is now added to .Rbuildignore
  ([\#1711](https://github.com/r-lib/devtools/issues/1711))

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) and
  [`check_built()`](https://devtools.r-lib.org/dev/reference/check.md)
  now have an `error_on` argument to specify if they should throw an
  error on check failures. When run non-interactively this is set to
  “warnings” unless specified.

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  sets `_R_CHECK_CRAN_INCOMING_REMOTE_` instead of
  `_R_CHECK_CRAN_INCOMING_`on R versions which support the former option
  ([\#1271](https://github.com/r-lib/devtools/issues/1271),
  [\#1276](https://github.com/r-lib/devtools/issues/1276),
  [\#1702](https://github.com/r-lib/devtools/issues/1702)).

- Now use cli package to draw rules - they are more aesthetically
  pleasing and the correct width in the RStudio build pane
  ([\#1627](https://github.com/r-lib/devtools/issues/1627)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) has
  been tweaked to reflect modern submission workflow and to ask
  questions rather than running code for you
  ([\#1632](https://github.com/r-lib/devtools/issues/1632)).

- [`document()`](https://devtools.r-lib.org/dev/reference/document.md),
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md),
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md),
  [`build()`](https://devtools.r-lib.org/dev/reference/build.md) and
  [`test()`](https://devtools.r-lib.org/dev/reference/test.md) now
  automatically save open files when they are run inside the RStudio
  IDE. ([\#1576](https://github.com/r-lib/devtools/issues/1576))

- New
  [`check_rhub()`](https://devtools.r-lib.org/dev/reference/check_rhub.md)
  function to check packages using `https://builder.r-hub.io/`.

- `run_examples` was mistakenly passing `show` to
  [`pkgload::run_example`](https://pkgload.r-lib.org/reference/dev_example.html),
  causing it to fail ([@amcdavid](https://github.com/amcdavid),
  [\#1449](https://github.com/r-lib/devtools/issues/1449))

- New
  [`build_manual()`](https://devtools.r-lib.org/dev/reference/build_manual.md)
  function that produces pdf manual for the package
  ([@twolodzko](https://github.com/twolodzko),
  [\#1238](https://github.com/r-lib/devtools/issues/1238)).

- If you use git
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  generates a file called `CRAN-RELEASE` that reminds you to tag the
  commit that you submitted to CRAN
  ([\#1198](https://github.com/r-lib/devtools/issues/1198)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  once again looks for additional release questions in the correct
  environment ([\#1434](https://github.com/r-lib/devtools/issues/1434)).

- [`submit_cran()`](https://devtools.r-lib.org/dev/reference/submit_cran.md)
  now checks that you’re ready to submit, since this is a potentially
  expensive operation
  ([\#1228](https://github.com/r-lib/devtools/issues/1228))

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md)
  defaults to running
  [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  only if you have used roxygen previously
  ([\#1437](https://github.com/r-lib/devtools/issues/1437)).

- Signal an error if commas are missing in between remote entries
  ([\#1511](https://github.com/r-lib/devtools/issues/1511),
  [@ianmcook](https://github.com/ianmcook)).

- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  gains a quiet argument
  ([\#1543](https://github.com/r-lib/devtools/issues/1543)).

- [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md)
  works once more when there is only a single file in the gist
  ([\#1266](https://github.com/r-lib/devtools/issues/1266)).

- In order to not run test helpers in
  [`document()`](https://devtools.r-lib.org/dev/reference/document.md),
  the `helpers` argument of
   [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  is set to `FALSE` ([@nbenn](https://github.com/nbenn),
  [\#1669](https://github.com/r-lib/devtools/issues/1669))

- The `my_unzip()` function is now able to use the
  [`utils::unzip`](https://rdrr.io/r/utils/unzip.html) fallback when R
  is compiled from source with no *unzip* package present
  ([@theGreatWhiteShark](https://github.com/theGreatWhiteShark),
  [\#1678](https://github.com/r-lib/devtools/issues/1678))

- If the **foghorn** package is installed,
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  displays the results of the CRAN checks
  ([\#1672](https://github.com/r-lib/devtools/issues/1672),
  [@fmichonneau](https://github.com/fmichonneau)).

## devtools 1.13.5

CRAN release: 2018-02-18

- Fix two test errors related to GitHub rate limiting and mocking base
  functions.

## devtools 1.13.4

CRAN release: 2017-11-09

- Fix test errors for upcoming testthat release.

## devtools 1.13.3

CRAN release: 2017-08-02

- Workaround a change in how Rcpp::compileAttributes stores the symbol
  names that broke tests.

## devtools 1.13.2

CRAN release: 2017-06-02

- Workaround a regression in Rcpp::compileAttributes. Add trimws
  implementation for R 3.1 support.

## devtools 1.13.1

CRAN release: 2017-05-13

- Bugfix for installing from git remote and not passing git2r
  credentials ([@james-atkins](https://github.com/james-atkins),
  [\#1498](https://github.com/r-lib/devtools/issues/1498))

- Bugfix for installation of dependencies of dependencies
  ([@jimhester](https://github.com/jimhester),
  [\#1409](https://github.com/r-lib/devtools/issues/1409)).

- Bugfix for installation of dependencies in CRAN-like repositories such
  as those created by drat ([@jimhester](https://github.com/jimhester),
  [\#1243](https://github.com/r-lib/devtools/issues/1243),
  [\#1339](https://github.com/r-lib/devtools/issues/1339)).

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  no longer automatically creates a description for you.

- `use_test()` template no longer includes useless comments
  ([\#1349](https://github.com/r-lib/devtools/issues/1349))

- Fix [`test()`](https://devtools.r-lib.org/dev/reference/test.md)
  compatibility with testthat versions 1.0.2
  ([\#1503](https://github.com/r-lib/devtools/issues/1503)).

- Fix
  [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_local()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_url()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_svn()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  [`install_bioc()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  gain `quiet` arguments and properly pass them to internal functions.
  ([\#1502](https://github.com/r-lib/devtools/issues/1502))

## devtools 1.13.0

CRAN release: 2017-05-08

### New Features

- `spell_check` gains a `dict` argument to set a custom language or
  dictionary

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  checks documentation for spelling errors by default.

- New `use_gpl3_license()` sets the license field in `DESCRIPTION` and
  includes a copy of the license in `LICENSE`.

### Revdep check improvements

- Various minor improvements around checking of reverse dependencies
  ([\#1284](https://github.com/r-lib/devtools/issues/1284),
  [@krlmlr](https://github.com/krlmlr)). All packages involved are
  listed at the start, the whole process is now more resilient against
  package installation failures.

- `revdep_check()` and `revdep_check_resume()` gain a skip argument
  which takes a character vector of packages to skip.

- `revdep_check()` and `check_cran()` gain a `quiet_check` argument. You
  can use `quiet_check = FALSE` to see the actual text of R CMD check as
  it runs (not recommending with multiple threads).

- `revdep_check_resume()` now takes `...` which can be used to override
  settings from `revdep_check()`. For debugging a problem with package
  checks, try `revdep_check(threads = 1, quiet_check = FALSE)`

- `revdep_check()` collects timing information in `timing.md`
  ([\#1319](https://github.com/r-lib/devtools/issues/1319),
  [@krlmlr](https://github.com/krlmlr)).

- Package names and examples are sorted in case-insensitive C collation
  ([\#1322](https://github.com/r-lib/devtools/issues/1322),
  [@krlmlr](https://github.com/krlmlr)).

- `use_revdep()` adds `.gitignore` entry for check database
  ([\#1321](https://github.com/r-lib/devtools/issues/1321),
  [@krlmlr](https://github.com/krlmlr)).

- Own package is installed in temporary library for revdep checking
  ([\#1338](https://github.com/r-lib/devtools/issues/1338),
  [@krlmlr](https://github.com/krlmlr)).

- Automated revdep check e-mails now can use the new `my_version` and
  `you_cant_install` variables. The e-mail template has been updated to
  use these variables
  ([\#1285](https://github.com/r-lib/devtools/issues/1285),
  [@krlmlr](https://github.com/krlmlr)).

- Installation failures are logged during revdep checking, by default in
  `revdep/install`. Once an installation has failed, it is not attempted
  a second time
  ([\#1300](https://github.com/r-lib/devtools/issues/1300),
  [@krlmlr](https://github.com/krlmlr)).

- Print summary table in README.md and problems.md
  ([\#1284](https://github.com/r-lib/devtools/issues/1284),
  [@krlmlr](https://github.com/krlmlr)).

- Revdep check improvements
  ([\#1284](https://github.com/r-lib/devtools/issues/1284))

### Bug fixes and minor improvements

- Handle case of un-installed package being passed to session_info
  ([\#1281](https://github.com/r-lib/devtools/issues/1281)).

- Using authentication to access Github package name.
  ([\#1262](https://github.com/r-lib/devtools/issues/1262),
  [@eriknil](https://github.com/eriknil)).

- [`spell_check()`](https://devtools.r-lib.org/dev/reference/spell_check.md)
  checks for hunspell before running
  ([\#1475](https://github.com/r-lib/devtools/issues/1475),
  [@jimvine](https://github.com/jimvine)).

- `add_desc_package()` checks for package dependencies correctly
  ([\#1463](https://github.com/r-lib/devtools/issues/1463),
  [@thomasp85](https://github.com/thomasp85)).

- Remove deprecated `args` argument from
  [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  to allow passthrough to `install`
  ([\#1373](https://github.com/r-lib/devtools/issues/1373),
  [@ReportMort](https://github.com/ReportMort)).

- added a `quiet` argument to
  [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md),
  with a default value of `FALSE` (fixes issue
  [\#1345](https://github.com/r-lib/devtools/issues/1345),
  [@plantarum](https://github.com/plantarum)).

- [`update_packages()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  allows for override of interactive prompt
  ([\#1260](https://github.com/r-lib/devtools/issues/1260),
  [@pkq](https://github.com/pkq)).

- `use_test()` template no longer includes useless comments
  ([\#1349](https://github.com/r-lib/devtools/issues/1349))

- Add encoding support in `test_dir()` call by adding reference to
  pkg\$encoding
  ([\#1306](https://github.com/r-lib/devtools/issues/1306),
  [@hansharhoff](https://github.com/hansharhoff))

- Parse valid Git remote URLs that lack trailing `.git`, e.g. GitHub
  browser URLs ([\#1253](https://github.com/r-lib/devtools/issues/1253),
  [@jennybc](https://github.com/jennybc)).

- Add a `check_bioconductor()` internal function to automatically
  install BiocInstaller() if it is not installed and the user wants to
  do so.

- Improve Git integration. `use_git_ignore()` and `use_git_config()`
  gain `quiet` argument, tests work without setting `user.name` and
  `user.email` Git configuration settings
  ([\#1320](https://github.com/r-lib/devtools/issues/1320),
  [@krlmlr](https://github.com/krlmlr)).

- Improve Git status checks used in
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  ([\#1205](https://github.com/r-lib/devtools/issues/1205),
  [@krlmlr](https://github.com/krlmlr)).

- Improved handling of local `file://` repositories in
  [`install()`](https://devtools.r-lib.org/dev/reference/install.md)
  ([\#1284](https://github.com/r-lib/devtools/issues/1284),
  [@krlmlr](https://github.com/krlmlr)).

- `setup()` and
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md) gain
  new `quiet` argument
  ([\#1284](https://github.com/r-lib/devtools/issues/1284),
  [@krlmlr](https://github.com/krlmlr)).

- Avoid unnecessary query of `available_packages()`
  ([\#1269](https://github.com/r-lib/devtools/issues/1269),
  [@krlmlr](https://github.com/krlmlr)).

- Add cache setting to AppVeyor template
  ([\#1290](https://github.com/r-lib/devtools/issues/1290),
  [@krlmlr](https://github.com/krlmlr)).

- Fix AppVeyor test by manually installing `curl`
  ([\#1301](https://github.com/r-lib/devtools/issues/1301)).

- `install(dependencies = FALSE)` doesn’t query the available packages
  anymore ([@krlmlr](https://github.com/krlmlr),
  [\#1269](https://github.com/r-lib/devtools/issues/1269)).

- `use_travis()` now opens a webpage in your browser to more easily
  activate a repo.

- `use_readme_rmd()` and `use_readme()` share a common template with
  sections for package overview, GitHub installation (if applicable),
  and an example ([@jennybc](https://github.com/jennybc),
  [\#1287](https://github.com/r-lib/devtools/issues/1287)).

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) doesn’t
  load helpers twice anymore ([@krlmlr](https://github.com/krlmlr),
  [\#1256](https://github.com/r-lib/devtools/issues/1256)).

- Fix auto download method selection for
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  on R 3.1 which lacks “libcurl” in
  [`capabilities()`](https://rdrr.io/r/base/capabilities.html).
  ([@kiwiroy](https://github.com/kiwiroy),
  [\#1244](https://github.com/r-lib/devtools/issues/1244))

- Fix removal of vignette files by not trying to remove files twice
  anymore ([\#1291](https://github.com/r-lib/devtools/issues/1291))

- add timestamp to messages in `build_win()`
  ([@achubaty](https://github.com/achubaty),
  [\#1367](https://github.com/r-lib/devtools/issues/1367)).

## devtools 1.12.0

CRAN release: 2016-06-24

### New features

- New
  [`install_bioc()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  function and bioc remote to install Bioconductor packages from their
  SVN repository.

- [`install_dev_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  gets everything you need to start development on source package - it
  installs all dependencies, and roxygen2
  ([\#1193](https://github.com/r-lib/devtools/issues/1193)).

- `use_dev_version()` automates the process of switching from a release
  version number by tweaking the `DESCRIPTION`, adding a heading to
  `NEWS.md` (if present), and checking into git (if you use it)
  ([\#1076](https://github.com/r-lib/devtools/issues/1076).)

- `use_github()` accepts a host argument, similar to
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  ([@ijlyttle](https://github.com/ijlyttle),
  [\#1101](https://github.com/r-lib/devtools/issues/1101))

### Bug fixes and minor improvements

- Update with Rtools-3.4 information,
  ([@jimhester](https://github.com/jimhester))

- devtools now uses https to access the RStudio CRAN mirror if it will
  work on your system
  ([\#1059](https://github.com/r-lib/devtools/issues/1059))

- Handle case when a GitHub request returns a non-JSON error response.
  ([@jimhester](https://github.com/jimhester),
  [\#1204](https://github.com/r-lib/devtools/issues/1204),
  [\#1211](https://github.com/r-lib/devtools/issues/1211))

- Suggested packages, including those specified as `Remotes:` are now
  installed after package installation. This allows you to use circular
  `Remotes:` dependencies for two related packages as long as one of the
  dependencies is a Suggested package.
  ([@jimhester](https://github.com/jimhester),
  [\#1184](https://github.com/r-lib/devtools/issues/1184),
  hadley/dplyr#1809)

- bug fix for installation of binary packages on windows, they must be
  installed directly from a zip file.
  ([@jimhester](https://github.com/jimhester),
  [\#1191](https://github.com/r-lib/devtools/issues/1191),
  [\#1192](https://github.com/r-lib/devtools/issues/1192))

- `build_vignette()` will now only install the “VignetteBuilder” if it’s
  not present, not try and upgrade it if it is
  ([\#1139](https://github.com/r-lib/devtools/issues/1139)).

- [`clean_dll()`](https://pkgbuild.r-lib.org/reference/clean_dll.html)
  Only removes package_name.def files and now operates recursively.
  ([@jimhester](https://github.com/jimhester),
  [\#1175](https://github.com/r-lib/devtools/issues/1175),
  [\#1159](https://github.com/r-lib/devtools/issues/1159),
  [\#1161](https://github.com/r-lib/devtools/issues/1161))

- [`check_man()`](https://devtools.r-lib.org/dev/reference/check_man.md)
  now prints a message if no problems are found
  ([\#1187](https://github.com/r-lib/devtools/issues/1187)).

- `install_*` functions and
  [`update_packages()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  refactored to allow updating of packages installed using any of the
  install methods. ([@jimhester](https://github.com/jimhester),
  [\#1067](https://github.com/r-lib/devtools/issues/1067))

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now uses `https://api.github.com` as the host argument, so users can
  specify ‘http:’ or other protocols if needed.
  ([@jimhester](https://github.com/jimhester),
  [\#1131](https://github.com/r-lib/devtools/issues/1131),
  [\#1200](https://github.com/r-lib/devtools/issues/1200))

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  runs package hooks before sourcing test helper files allowing test
  helper to make use of objects created when a package is loaded or
  attached. ([@imanuelcostigan](https://github.com/imanuelcostigan),
  [\#1146](https://github.com/r-lib/devtools/issues/1146))

- `revdep_check()` will now create the `revdep/` directory if it does
  not already exist
  ([\#1178](https://github.com/r-lib/devtools/issues/1178)).

- [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md)
  gains a `filename` argument to specify a particular file to source
  from a GitHub gist. ([@ateucher](https://github.com/ateucher),
  [\#1172](https://github.com/r-lib/devtools/issues/1172))

- Add a default codecov.yml file to turn off commenting with
  `use_coverage()` ([@jimhester](https://github.com/jimhester),
  [\#1188](https://github.com/r-lib/devtools/issues/1188))

- Bug fix for ‘nchar(text) : invalid multibyte string’ errors when
  running `write_dcf()` on DESCRIPTION files with non-ASCII encodings
  ([\#1224](https://github.com/r-lib/devtools/issues/1224),
  [@jimhester](https://github.com/jimhester)).

## devtools 1.11.1

CRAN release: 2016-04-21

- Bug fix in `search_path_for_rtools()` using the gcc-4.9.3 toolchain
  when there is no rtools setting in the windows registry.
  ([@jimhester](https://github.com/jimhester),
  [\#1155](https://github.com/r-lib/devtools/issues/1155))

## devtools 1.11.0

CRAN release: 2016-04-12

### Infrastructure helpers

- `create_description()` now sets `Encoding: UTF-8`. This helps
  non-English package authors
  ([\#1123](https://github.com/r-lib/devtools/issues/1123)).

- All `use_` function have been overhauled to be more consistent,
  particularly around notification. Most functions now also ask to
  overwrite if a file already exists
  ([\#1074](https://github.com/r-lib/devtools/issues/1074)).

- `use_coverage()` now adds covr to “Suggests”, rather than recommending
  you install it explicitly in `.travis.yml`.

- `use_cran_badge()` now uses HTTPS URL
  ([@krlmlr](https://github.com/krlmlr),
  [\#1124](https://github.com/r-lib/devtools/issues/1124)).

- `use_github()` now confirms that you’ve picked a good title and
  description ([\#1092](https://github.com/r-lib/devtools/issues/1092))
  and prints the url of the repo
  ([\#1063](https://github.com/r-lib/devtools/issues/1063)).

- `use_news()`, and `use_test()` open the files in RStudio (if you’re
  using it and have the rstudioapi package installed).

- `use_testthat()` tells you what it’s doing
  ([\#1056](https://github.com/r-lib/devtools/issues/1056)).

- `use_travis()` generates a template compatible with the newest
  R-travis.

- `use_readme_md()` creates a basic `README.md` template
  ([\#1064](https://github.com/r-lib/devtools/issues/1064)).

- `use_revdep()` has an updated template for the new revdep check system
  ([\#1090](https://github.com/r-lib/devtools/issues/1090),
  [@krlmlr](https://github.com/krlmlr)).

- Removed the deprecated `use_coveralls()`, `add_rstudio_project()`,
  `add_test_infrastructure()`, and `add_travis()`.

- Deprecated `build_github_devtools()` has been removed.

### Checks and release()

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  always succeeds (instead of throwing an error when `R CMD check` finds
  an `ERROR`), returning an object that summarises the check failures.

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) gains
  `run_dont_test` and `manual` arguments to control whether or not
  `\donttest{}` tests are tested, or manuals are built. This defaults to
  `FALSE`, but
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  runs check with it set to `TRUE`
  ([\#1071](https://github.com/r-lib/devtools/issues/1071);
  [\#1087](https://github.com/r-lib/devtools/issues/1087),
  [@krlmlr](https://github.com/krlmlr)).

- The `cleanup` argument to
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md) is
  deprecated: it now always returns the path to the check directory.

- [`check_built()`](https://devtools.r-lib.org/dev/reference/check.md)
  allows you to run `R CMD check` on an already built package.

- `check_cran()` suppresses X11 with `DISPLAY = ""`.

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) has
  been tweaked to improve the order of the questions, and to ensure that
  you’re ok with problems. It warns if both `inst/NEWS.Rd` and `NEWS.md`
  exist ([@krlmlr](https://github.com/krlmlr),
  [\#1135](https://github.com/r-lib/devtools/issues/1135)), doesn’t
  throw error if Git head is detached
  ([@krlmlr](https://github.com/krlmlr),
  [\#1136](https://github.com/r-lib/devtools/issues/1136)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  gains an `args` argument to control build options, e.g. to allow
  passing `args = "--compact-vignettes=both"` for packages with heavy
  PDF vignettes ([@krlmlr](https://github.com/krlmlr),
  [\#1077](https://github.com/r-lib/devtools/issues/1077)).

- `system_check()` gains new arguments `path` to controls the working
  directory of the command, and `throw` to control whether or not it
  throws an error on command failure. `env` has been renamed to the more
  explicit `env_vars`.

### Revdep checks

`revdep_check()` has been overhauled. All `revdep_` functions now work
like other devtools functions, taking a path to the package as the first
argument.

`revdep_check()` now saves its results to disk as `check/check.rds`, and
the other
[`revdep()`](https://devtools.r-lib.org/dev/reference/revdep.md)
functions read from that cache. This also allows you to resume a partial
run with `revdep_check_resume()`. This should be a big time saver if
something goes unexpected wrong in the middle of the checks. You can
blow away the cache and start afresh with `revdep_check_reset()`.

`revdep_check_save_summary()` now creates `README.md` to save one level
of clicking in github. It also creates a `problems.md` that contains
only results for only packages that had warnings or errors. Each problem
is limited to at most 25 lines of output - this avoids lengthy output
for failing examples. `revdep_check_print_problems()` prints a bulleted
list of problems, suitable for inclusion in your `cran-comments.md`.

Summary results are reported as they come in, every then messages you’ll
get a message giving elapsed and estimated remaining time.

An experimental `revdep_email()` emails individual maintainers with
their `R CMD check` summary results
([\#1014](https://github.com/r-lib/devtools/issues/1014)). See testthat
and dplyr for example usage.

There were a handful of smaller fixes:

- `revdep_check()` doesn’t complain about missing `git2r` package
  anymore ([\#1068](https://github.com/r-lib/devtools/issues/1068),
  [@krlmlr](https://github.com/krlmlr)).

- Package index caches for `revdep_check()` now time out after 30
  minutes.

- `revdep_check_save_logs()` has been removed - it is just not that
  useful.

- `revdep_check_summary()` has been removed - it never should have been
  part of the exported API.

### Other improvements

- Devtools now uses new gcc toolchain on windows, if installed
  ([@jimhester](https://github.com/jimhester)).

- [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now allows you to pass credentials to git2r to specify specific ssh
  credentials ([@onlymee](https://github.com/onlymee),
  [\#982](https://github.com/r-lib/devtools/issues/982))

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  now sources all test helpers if you use testthat. This makes it much
  easier to interactively run tests
  ([\#1125](https://github.com/r-lib/devtools/issues/1125)).
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  also correctly handles `unix` and `windows` subdirectories within `R`
  ([@gaborcsardi](https://github.com/gaborcsardi),
  [\#1102](https://github.com/r-lib/devtools/issues/1102))

- `build_win()` defaults to only R-devel, since this is most commonly
  what you want.

- Help shims now inform you that you’re using development documentation
  ([\#1049](https://github.com/r-lib/devtools/issues/1049)).

- `git_sha1()` Fix fetching the latest git commit so that it also works
  for shallow git clones, i.e. git clones which make use of depth.
  ([\#1048](https://github.com/r-lib/devtools/issues/1048),
  [\#1046](https://github.com/r-lib/devtools/issues/1046),
  [@nparley](https://github.com/nparley))

## devtools 1.10.0

CRAN release: 2016-01-23

### New features

- `curl`, `evaluate`, `roxygen2` and `rversions` have been moved from
  Imports to Suggests to lighten the dependency load of devtools. If you
  run a function that needs one of the packages, you’ll prompted to
  install it ([\#962](https://github.com/r-lib/devtools/issues/962),
  [@jimhester](https://github.com/jimhester)).

- Devtools uses a new strategy for detecting RTools on windows: it now
  only looks for Rtools if you need to
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  or [`build()`](https://devtools.r-lib.org/dev/reference/build.md) a
  package with compiled code. This should make it easier to work with
  devtools if you’re developing pure R packages
  ([\#947](https://github.com/r-lib/devtools/issues/947)).

- [`package_file()`](https://devtools.r-lib.org/dev/reference/package_file.md)
  lets you find files inside a package. It starts by finding the root
  directory of the package (i.e. the directory that contains
  `DESCRIPTION`)
  ([\#985](https://github.com/r-lib/devtools/issues/985)).

- `use_news_md()` adds a basic `NEWS.md` template
  ([\#957](https://github.com/r-lib/devtools/issues/957)).

- `use_mit_license()` writes the necessary infrastructure to declare and
  release an R package under the MIT license in a CRAN-compliant way.
  ([\#995](https://github.com/r-lib/devtools/issues/995),
  [@kevinushey](https://github.com/kevinushey))

- `check(cran = TRUE)` adds `--run-donttest` since you do need to test
  code in `\donttest()` for CRAN submission
  ([\#1002](https://github.com/r-lib/devtools/issues/1002)).

### Package installation

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md)
  installs packages specified in the `Additional_repositories` field,
  such as drat repositories.
  ([\#907](https://github.com/r-lib/devtools/issues/907),
  [\#1028](https://github.com/r-lib/devtools/issues/1028),
  [@jimhester](https://github.com/jimhester)). It correctly installs
  missing dependencies
  ([\#1013](https://github.com/r-lib/devtools/issues/1013),
  [@gaborcsardi](https://github.com/gaborcsardi)). If called on a
  Bioconductor package, include the Bioconductor repositories if they
  are not already set
  ([\#895](https://github.com/r-lib/devtools/issues/895),
  [@jimhester](https://github.com/jimhester)).

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md)
  gains a `metadata` argument which lets you add extra fields to the
  `DESCRIPTION` on install.
  ([\#1027](https://github.com/r-lib/devtools/issues/1027),
  [@rmflight](https://github.com/rmflight))

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  and
  [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  only downloads and installs the package if the remote SHA1 reference
  differs from the currently installed reference
  ([\#903](https://github.com/r-lib/devtools/issues/903),
  [@jimhester](https://github.com/jimhester)).

- [`install_local()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  captures git and github information and stores it in the `DESCRIPTION`
  ([\#1027](https://github.com/r-lib/devtools/issues/1027),
  [@rmflight](https://github.com/rmflight)).

- [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  is more robust when handling multiple repos
  ([\#943](https://github.com/r-lib/devtools/issues/943),
  [\#1030](https://github.com/r-lib/devtools/issues/1030),
  [@jimhester](https://github.com/jimhester)).

- Bugfix for `Remotes:` feature that prevented it from working if
  devtools was not attached as is done in travis-r
  ([\#936](https://github.com/r-lib/devtools/issues/936),
  [@jimhester](https://github.com/jimhester)).

### Bug fixes and minor improvements

- `check_dev_versions()` checks only package dependencies
  ([\#983](https://github.com/r-lib/devtools/issues/983)).

- [`check_man()`](https://devtools.r-lib.org/dev/reference/check_man.md)
  replaces `check_doc()` (since most other functions are named after the
  corresponding directory). `check_doc()` will hang around as an alias
  for the foreseeable future
  ([\#958](https://github.com/r-lib/devtools/issues/958)).

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md)
  produces a dummy namespace will fake comment so roxygen2 will
  overwrite silently
  ([\#1016](https://github.com/r-lib/devtools/issues/1016)).

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md) and
  `setup()` are more permissive – they now accept a path to either a new
  directory or empty directory.
  ([\#966](https://github.com/r-lib/devtools/issues/966),
  [@kevinushey](https://github.com/kevinushey))

- [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  now only runs `update_collate()` once.

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  resolves a longstanding lazy load database corruption issue when
  reloading packages which define S3 methods on generics from base or
  other packages
  ([\#1001](https://github.com/r-lib/devtools/issues/1001),
  [@jimhester](https://github.com/jimhester)).

- [`release_checks()`](https://devtools.r-lib.org/dev/reference/release_checks.md)
  gains two new checks:

  - `check_vignette_titles()` checks that your vignette titles aren’t
    the default “Vignette Title”
    ([\#960](https://github.com/r-lib/devtools/issues/960),
    [@jennybc](https://github.com/jennybc)).

  - `check_news_md()` checks that `NEWS.md` isn’t in your
    `.Rbuildignore` (since it’s now supported by CRAN,
    [\#1042](https://github.com/r-lib/devtools/issues/1042)).

- `revdep_check()`:

  - More verbose about which package is installed
    ([\#926](https://github.com/r-lib/devtools/issues/926),
    [@krlmlr](https://github.com/krlmlr))

  - Verifies the integrity of already downloaded package archives
    ([\#930](https://github.com/r-lib/devtools/issues/930),
    [@krlmlr](https://github.com/krlmlr))

  - Is now more tolerant of errors when retrieving the summary for a
    checked package
    ([\#929](https://github.com/r-lib/devtools/issues/929),
    [@krlmlr](https://github.com/krlmlr)).

  - When `ncpus > 1`, it includes the package name for when so you know
    which package has failed and can start looking at the output without
    needing to wait for all packages to finish
    ([@mattdowle](https://github.com/mattdowle)).

  - Uses proper repository when `BiocInstaller::useDevel(TRUE)`
    ([\#937](https://github.com/r-lib/devtools/issues/937),
    [@jimhester](https://github.com/jimhester)).

- Shimmed [`system.file()`](https://rdrr.io/r/base/system.file.html) now
  respects `mustWork = TRUE` and throws an error if the file does not
  exist ([\#1034](https://github.com/r-lib/devtools/issues/1034)).

- `use_appveyor()` template now creates `failure.zip` artifact instead
  of polluting the logs with `R CMD check` output
  ([\#1017](https://github.com/r-lib/devtools/issues/1017),
  [@krlmlr](https://github.com/krlmlr),
  [@HenrikBengtsson](https://github.com/HenrikBengtsson)).

- `use_cran_comments()` template has been improved
  ([\#1038](https://github.com/r-lib/devtools/issues/1038)).

- `use_data()` now warns when trying to save the same object twice, and
  stops if there is no object to save
  ([\#948](https://github.com/r-lib/devtools/issues/948),
  [@krlmlr](https://github.com/krlmlr)).

- `use_revdep_check()` no longer includes `revdep_check_save_logs` in
  default template. I found I never used the logs and they just
  cluttered up the package directory
  ([\#1003](https://github.com/r-lib/devtools/issues/1003)).

- `with_*()` functions have moved into the withr package, and devtools
  functions have been deprecated
  ([\#925](https://github.com/r-lib/devtools/issues/925),
  [@jimhester](https://github.com/jimhester)).

## devtools 1.9.1

CRAN release: 2015-09-11

- Avoid importing heavy dependencies to speed up loading
  ([\#830](https://github.com/r-lib/devtools/issues/830),
  [@krlmlr](https://github.com/krlmlr)).

- Remove explicit [`library(testthat)`](https://testthat.r-lib.org) call
  in [`test()`](https://devtools.r-lib.org/dev/reference/test.md)
  ([\#798](https://github.com/r-lib/devtools/issues/798),
  [@krlmlr](https://github.com/krlmlr)).

- [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  and
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  gain new argument `create`. Like other functions with a `pkg`
  argument,
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  looks for a `DESCRIPTION` file in parent directories - if
  `create = TRUE` it will be automatically created if there’s a `R/` or
  `data/` directory
  ([\#852](https://github.com/r-lib/devtools/issues/852),
  [@krlmlr](https://github.com/krlmlr)).

- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  gains dependencies argument
  ([\#825](https://github.com/r-lib/devtools/issues/825),
  [@krlmlr](https://github.com/krlmlr)).

- `build_win()` now uses `curl` instead of `RCurl` for ftp upload.

- `build_win()` asks for consent to receive e-mail at maintainer address
  in interactive mode
  ([\#800](https://github.com/r-lib/devtools/issues/800),
  [@krlmlr](https://github.com/krlmlr)).

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  uses a better strategy when `cran = TRUE`. Instead of attempting to
  simulate `--as-cran` behaviour by turning on certain env vars, it now
  uses `--as-cran` and turns off problematic checks with env vars
  ([\#866](https://github.com/r-lib/devtools/issues/866)). The
  problematic `cran_env_vars()` function has been removed.

- [`find_rtools()`](https://pkgbuild.r-lib.org/reference/has_rtools.html)
  now looks for registry keys in both HKCU (user) and HKLM (admin)
  locations ([@Kevin-Jin](https://github.com/Kevin-Jin),
  [\#844](https://github.com/r-lib/devtools/issues/844))

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) can
  now install dependencies from remote repositories by specifying them
  as `Remotes` in the `DESCRIPTION` file
  ([\#902](https://github.com/r-lib/devtools/issues/902),
  [@jimhester](https://github.com/jimhester)). See
  [`vignette("dependencies")`](https://devtools.r-lib.org/dev/articles/dependencies.md)
  for more details.

- `install_*()` detects if called on a Bioconductor package and if so,
  automatically includes the Bioconductor repositories if needed
  ([\#895](https://github.com/r-lib/devtools/issues/895),
  [@jimhester](https://github.com/jimhester)).

- [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  now automatically upgrades out of date dependencies. This is typically
  what you want when you’re working on a development version of a
  package. To suppress this behaviour, set
  `upgrade_dependencies = FALSE`
  ([\#863](https://github.com/r-lib/devtools/issues/863)).
  [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  is more careful with `...` - this means additional arguments to
  `install_*` are more likely to work
  ([\#870](https://github.com/r-lib/devtools/issues/870)).

- `install_gitorious()` has been removed since gitorious no longer
  exists ([\#913](https://github.com/r-lib/devtools/issues/913)).

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  no longer fails if a `useDynLib()` entry in the NAMESPACE is
  incorrect. This should make it easy to recover from an incorrect
  `@useDynLib`, because re-documenting() should now succeed.

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  works for packages not located at root of git repository
  ([\#845](https://github.com/r-lib/devtools/issues/845),
  [\#846](https://github.com/r-lib/devtools/issues/846),
  [@mbjones](https://github.com/mbjones)).

- `revdep_check()` now installs *suggested* packages by default
  ([\#808](https://github.com/r-lib/devtools/issues/808)), and sets
  `NOT_CRAN` env var to `false`
  ([\#809](https://github.com/r-lib/devtools/issues/809)). This makes
  testing more similar to CRAN so that more packages should pass
  cleanly. It also sets `RGL_USE_NULL` to `true` to stop rgl windows
  from popping up during testing
  ([\#897](https://github.com/r-lib/devtools/issues/897)). It also
  downloads all source packages at the beginning - this makes life a bit
  easier if you’re on a flaky internet connection
  ([\#906](https://github.com/r-lib/devtools/issues/906)).

- New
  [`uninstall()`](https://devtools.r-lib.org/dev/reference/uninstall.md)
  removes installed package
  ([\#820](https://github.com/r-lib/devtools/issues/820),
  [@krlmlr](https://github.com/krlmlr)).

- Add `use_coverage()` function to add codecov.io or coveralls.io to a
  project, deprecate `use_coveralls()`
  ([@jimhester](https://github.com/jimhester),
  [\#822](https://github.com/r-lib/devtools/issues/822),
  [\#818](https://github.com/r-lib/devtools/issues/818)).

- `use_cran_badge()` uses canonical url form preferred by CRAN.

- `use_data()` also works with data from the parent frame
  ([\#829](https://github.com/r-lib/devtools/issues/829),
  [@krlmlr](https://github.com/krlmlr)).

- `use_git_hook()` now creates `.git/hooks` if needed
  ([\#888](https://github.com/r-lib/devtools/issues/888))

- GitHub integration extended: `use_github()` gains a `protocol`
  argument (ssh or https), populates URL and BugReports fields of
  DESCRIPTION (only if non-existent or empty), pushes to the newly
  created GitHub repo, and sets a remote tracking branch.
  `use_github_links()` is a new exported function. `dr_github()`
  diagnoses more possible problems.
  ([\#642](https://github.com/r-lib/devtools/issues/642),
  [@jennybc](https://github.com/jennybc)).

- `use_travis()`: Default travis script leaves notifications on default
  settings.

- [`uses_testthat()`](https://devtools.r-lib.org/dev/reference/uses_testthat.md)
  and `check_failures()` are now exported
  ([\#824](https://github.com/r-lib/devtools/issues/824),
  [\#839](https://github.com/r-lib/devtools/issues/839),
  [@krlmlr](https://github.com/krlmlr)).

- `use_readme_rmd()` uses `uses_git()` correctly
  ([\#793](https://github.com/r-lib/devtools/issues/793)).

- [`with_debug()`](https://pkgbuild.r-lib.org/reference/with_debug.html)
  now uses `with_makevars()` rather than `with_env()`, because R reads
  compilation variables from the Makevars rather than the environment
  ([@jimhester](https://github.com/jimhester),
  [\#788](https://github.com/r-lib/devtools/issues/788)).

- Properly reset library path after `with_lib()`
  ([\#836](https://github.com/r-lib/devtools/issues/836),
  [@krlmlr](https://github.com/krlmlr)).

- `remove_s4classes()` performs a topological sort of the classes
  ([\#848](https://github.com/r-lib/devtools/issues/848),
  [\#849](https://github.com/r-lib/devtools/issues/849),
  [@famuvie](https://github.com/famuvie)).

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  warns (instead of failing) if importing symbols, methods, or classes
  from `NAMESPACE` fails ([@krlmlr](https://github.com/krlmlr),
  [\#921](https://github.com/r-lib/devtools/issues/921)).

## devtools 1.8.0

CRAN release: 2015-05-09

### Helpers

- New `dr_devtools()` runs some common diagnostics: are you using the
  latest version of R and devtools? It is run automatically by
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  ([\#592](https://github.com/r-lib/devtools/issues/592)).

- `use_code_of_conduct()` adds a contributor code of conduct from
  <http://contributor-covenant.org>.
  ([\#729](https://github.com/r-lib/devtools/issues/729))

- `use_coveralls()` allows you to easily add test coverage with
  coveralls ([@jimhester](https://github.com/jimhester),
  [\#680](https://github.com/r-lib/devtools/issues/680),
  [\#681](https://github.com/r-lib/devtools/issues/681)).

- `use_git()` sets up a package to use git, initialising the repo and
  checking the existing files.

- `use_test()` adds a new test file
  ([\#769](https://github.com/r-lib/devtools/issues/769),
  [@krlmlr](https://github.com/krlmlr)).

- New `use_cran_badge()` adds a CRAN status badge that you can copy into
  a README file. Green indicates package is on CRAN. Packages not yet
  submitted or accepted to CRAN get a red badge.

### Package installation and info

- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  automatically installs the VignetteBuilder package, if necessary
  ([\#736](https://github.com/r-lib/devtools/issues/736)).

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) and
  [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  gain a `...` argument, so additional arguments can be passed to
  [`utils::install.packages()`](https://rdrr.io/r/utils/install.packages.html)
  ([@jimhester](https://github.com/jimhester),
  [\#712](https://github.com/r-lib/devtools/issues/712)).
  [`install_svn()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  optionally accepts a revision
  ([@lev-kuznetsov](https://github.com/lev-kuznetsov),
  [\#739](https://github.com/r-lib/devtools/issues/739)).
  [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now knows how to look in multiple repos
  ([\#721](https://github.com/r-lib/devtools/issues/721)).

- `package_deps()` (and
  [`dev_package_deps()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md))
  determines all recursive dependencies and whether or not they’re
  up-to-date ([\#663](https://github.com/r-lib/devtools/issues/663)).
  Use `update(package_deps("xyz"))` to update out of date dependencies.
  This code is used in
  [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  and `revdep_check()` - it’s slightly more aggressive than previous
  code (i.e. it forces you to use the latest version), which should
  avoid problems when you go to submit to CRAN.

- New
  [`update_packages()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  will install a package (and its dependencies) only if they are missing
  or out of date
  ([\#675](https://github.com/r-lib/devtools/issues/675)).

- [`session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)
  can now take a vector of package names, in which case it will print
  the version of those packages and their dependencies
  ([\#664](https://github.com/r-lib/devtools/issues/664)).

### Git and github

- Devtools now uses the git2r package to inspect git properties and
  install remote git packages with
  [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md).
  This should be considerably more reliable than the previous strategy
  which involves calling the command line `git` client. It has two small
  downsides:
  [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  no longer accepts additional `args`, and must do a deep clone when
  installing.

- `dr_github()` checks for common problems with git/github setup
  ([\#643](https://github.com/r-lib/devtools/issues/643)).

- If you use git,
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  warns you if you have uncommited changes, or if you’ve forgotten to
  synchronise with the remote
  ([\#691](https://github.com/r-lib/devtools/issues/691)).

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  warns if repository contains submodules
  ([@ashander](https://github.com/ashander),
  [\#751](https://github.com/r-lib/devtools/issues/751)).

### Bug fixes and minor improvements

- Previously, devtools ran all external R processes with `R --vanilla`.
  Now it only suppresses user profiles, and constructs a custom
  `.Rprofile` to override the default. Currently, this `.Rprofile` sets
  up the `repos` option. Among others, this enables the cyclic
  dependency check in
  [`devtools::release`](https://devtools.r-lib.org/dev/reference/release.md)
  ([\#602](https://github.com/r-lib/devtools/issues/602),
  [@krlmlr](https://github.com/krlmlr)).

- `R_BROWSER` and `R_PDFVIEWER` environment variables are set to “false”
  to suppress random windows opening during checks.

- Devtools correctly identifies RTools 3.1 and 3.2
  ([\#738](https://github.com/r-lib/devtools/issues/738)), and preserves
  continuation lines in the `DESCRIPTION`
  ([\#709](https://github.com/r-lib/devtools/issues/709)).

- `dev_help()` now uses
  [`normalizePath()`](https://rdrr.io/r/base/normalizePath.html).
  Hopefully this will make it more likely to work if you’re on windows
  and have a space in the path.

- [`lint()`](https://devtools.r-lib.org/dev/reference/lint.md) gains a
  `cache` argument ([@jimhester](https://github.com/jimhester),
  [\#708](https://github.com/r-lib/devtools/issues/708)).

- Fixed namespace issues related to
  [`stats::setNames()`](https://rdrr.io/r/stats/setNames.html)
  ([\#734](https://github.com/r-lib/devtools/issues/734),
  [\#772](https://github.com/r-lib/devtools/issues/772)) and
  [`utils::unzip()`](https://rdrr.io/r/utils/unzip.html)
  ([\#761](https://github.com/r-lib/devtools/issues/761),
  [@robertzk](https://github.com/robertzk)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  reminds you to check the existing CRAN check results page
  ([\#613](https://github.com/r-lib/devtools/issues/613)) and shows file
  size before uploading to CRAN
  ([\#683](https://github.com/r-lib/devtools/issues/683),
  [@krlmlr](https://github.com/krlmlr)).

- `RCMD()` and `system_check()` are now exported so they can be used by
  other packages. ([@jimhester](https://github.com/jimhester),
  [\#699](https://github.com/r-lib/devtools/issues/699)).

- `revdep_check()` creates directories if needed
  ([\#759](https://github.com/r-lib/devtools/issues/759)).

- `system_check()` combines arguments with , not `,`.
  ([\#753](https://github.com/r-lib/devtools/issues/753))

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) gains an
  `...` argument so that additional arguments can be passed to
  [`testthat::test_dir`](https://testthat.r-lib.org/reference/test_dir.html)
  ([@jimhester](https://github.com/jimhester),
  [\#747](https://github.com/r-lib/devtools/issues/747))

- `use_travis()` now suggests you link to the svg icon since that looks
  a little sharper. Default template sets
  `CRAN: http://cran.rstudio.com/` to enable the cyclic dependency
  check.

- `NOT_CRAN` envvar no longer overrides externally set variable.

- `check(check_version = TRUE)` also checks spelling of the
  `DESCRIPTION`; if no spell checker is installed, a warning is given
  ([\#784](https://github.com/r-lib/devtools/issues/784),
  [@krlmlr](https://github.com/krlmlr)).

## devtools 1.7.0

CRAN release: 2015-01-17

### Improve reverse dependency checking

Devtools now supports a new and improved style of revdep checking with
`use_revdep()`. This creates a new directory called `revdep` which
contains a `check.R` template. Run this template to check all reverse
dependencies, and save summarised results to `check/summary.md`. You can
then check this file into git, making it much easier to track how
reverse dependency results change between versions. The documentation
for `revdep_check()` is much improved, and should be more useful
([\#635](https://github.com/r-lib/devtools/issues/635))

I recommend that you specify a library to use when checking with
`options("devtools.revdep.libpath")`. (This should be a directory that
already exists). This should be difference from your default library to
keep the revdep environment isolated from your development environment.

I’ve also tweaked the output of
[`revdep_maintainers()`](https://devtools.r-lib.org/dev/reference/revdep.md)
so it’s easier to copy and paste into an email
([\#634](https://github.com/r-lib/devtools/issues/634)). This makes life
a little easier pre-release.

### New helpers

- [`lint()`](https://devtools.r-lib.org/dev/reference/lint.md) runs
  [`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html)
  to check style consistency and errors in a package.
  ([@jimhester](https://github.com/jimhester),
  [\#694](https://github.com/r-lib/devtools/issues/694))

- `use_appveyor()` sets up a package for testing with AppVeyor
  ([@krlmlr](https://github.com/krlmlr),
  [\#549](https://github.com/r-lib/devtools/issues/549)).

- `use_cran_comments()` creates a `cran-comments.md` template and adds
  it to `.Rbuildignore` to help with CRAN submissions.
  ([\#661](https://github.com/r-lib/devtools/issues/661))

- `use_git_hook()` allows you to easily add a git hook to a package.

- `use_readme_rmd()` sets up a template to generate a `README.md` from a
  `README.Rmd` with knitr.

### Minor improvements

- Deprecated `doc_clean` argument to
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md) has
  been removed.

- Initial package version in
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md) is
  now `0.0.0.9000`
  ([\#632](https://github.com/r-lib/devtools/issues/632)).
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md) and
  `create_description()` checks that the package name is valid
  ([\#610](https://github.com/r-lib/devtools/issues/610)).

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  runs
  [`roxygen2::update_collate()`](https://roxygen2.r-lib.org/reference/update_collate.html)
  before loading code. This ensures that files are sourced in the way
  you expect, as defined by roxygen `@include` tags. If you don’t have
  any `@include` tags, the collate will be not be touched
  ([\#623](https://github.com/r-lib/devtools/issues/623)).

- [`session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)
  gains `include_base` argument to also display loaded/attached base
  packages ([\#646](https://github.com/r-lib/devtools/issues/646)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md) no
  longer asks if you’ve read the CRAN policies since the CRAN submission
  process now asks the same question
  ([\#692](https://github.com/r-lib/devtools/issues/692)).

  `release(check = TRUE)` now runs some additional custom checks. These
  include:

  - Checking that you don’t depend on a development version of a
    package.

  - Checking that the version number has exactly three components
    ([\#633](https://github.com/r-lib/devtools/issues/633)).

  [`release()`](https://devtools.r-lib.org/dev/reference/release.md) now
  builds packages without the `--no-manual` switch, both for checking
  and for actually building the release package
  ([\#603](https://github.com/r-lib/devtools/issues/603),
  [@krlmlr](https://github.com/krlmlr)).
  [`build()`](https://devtools.r-lib.org/dev/reference/build.md) gains
  an additional argument `manual`, defaulting to `FALSE`, and
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md) gains
  `...` unmodified to
  [`build()`](https://devtools.r-lib.org/dev/reference/build.md).

- `use_travis()` now sets an environment variable so that any WARNING
  will also cause the build to fail
  ([\#570](https://github.com/r-lib/devtools/issues/570)).

- [`with_debug()`](https://pkgbuild.r-lib.org/reference/with_debug.html)
  and `compiler_flags()` set `CFLAGS` etc instead of `PKG_CFLAGS`.
  `PKG_*` are for packages to use, the raw values are for users to set.
  (According to
  <http://cran.rstudio.com/doc/manuals/r-devel/R-exts.html#Using-Makevars>)

- New `setup()` works like
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md) but
  assumes an existing, not necessarily empty, directory
  ([\#627](https://github.com/r-lib/devtools/issues/627),
  [@krlmlr](https://github.com/krlmlr)).

### Bug fixes

- When installing a pull request,
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now uses the repository associated with the pull request’s branch (and
  not the repository of the user who created the pull request)
  ([\#658](https://github.com/r-lib/devtools/issues/658),
  [@krlmlr](https://github.com/krlmlr)).

- [`missing_s3()`](https://devtools.r-lib.org/dev/reference/missing_s3.md)
  works once again
  ([\#672](https://github.com/r-lib/devtools/issues/672))

- Fixed scoping issues with
  [`unzip()`](https://rdrr.io/r/utils/unzip.html).

- `load_code()` now executes the package’s code with the package’s root
  as working directory, just like `R CMD build` et
  al. ([\#640](https://github.com/r-lib/devtools/issues/640),
  [@krlmlr](https://github.com/krlmlr)).

## devtools 1.6.1

CRAN release: 2014-10-07

- Don’t set non-portable compiler flags on Solaris.

- The file `template.Rproj` is now correctly installed and the function
  `use_rstudio` works as it should.
  ([\#595](https://github.com/r-lib/devtools/issues/595),
  [@hmalmedal](https://github.com/hmalmedal))

- The function `use_rcpp` will now create the file `src/.gitignore` with
  the correct wildcards. ([@hmalmedal](https://github.com/hmalmedal))

- The functions `test`, `document`, `load_all`, `build`, `check` and any
  function that applies to some package directory will work from
  subdirectories of a package (like the “R” or “inst/tests”
  directories). ([\#616](https://github.com/r-lib/devtools/issues/616),
  [@robertzk](https://github.com/robertzk))

## devtools 1.6

CRAN release: 2014-09-23

### Tool templates and `create()`

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md) no
  longer generates `man/` directory - roxygen2 now does this
  automatically. It also no longer generates an package-level doc
  template. If you want this, use `use_package_doc()`. It also makes a
  dummy namespace so that you can build & reload without running
  [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  first.

- New `use_data()` makes it easy to include data in a package, either in
  `data/` (for exported datasets) or in `R/sysdata.rda` (for internal
  data). ([\#542](https://github.com/r-lib/devtools/issues/542))

- New `use_data_raw()` creates `data-raw/` directory for reproducible
  generation of `data/` files
  ([\#541](https://github.com/r-lib/devtools/issues/541)).

- New `use_package()` allows you to set dependencies
  ([\#559](https://github.com/r-lib/devtools/issues/559)).

- New `use_package_doc()` sets up an Roxygen template for package-level
  docs.

- New `use_rcpp()` sets up a package to use Rcpp.

- `use_travis()` now figures out your github username and repo so it can
  construct the markdown for the build image.
  ([\#546](https://github.com/r-lib/devtools/issues/546))

- New `use_vignette()` creates a draft vignette using Rmarkdown
  ([\#572](https://github.com/r-lib/devtools/issues/572)).

- renamed `add_rstudio_project()` to `use_rstudio()`, `add_travis()` to
  `use_travis()`, `add_build_ignore()` to `use_build_ignore()`, and
  `add_test_infrastructure()` to `use_testthat()` (old functions are
  aliased to new)

### The release process

- You can add arbitrary extra questions to
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md) by
  defining a function `release_questions()` in your package. Your
  `release_questions()` should return a character vector of questions to
  ask ([\#451](https://github.com/r-lib/devtools/issues/451)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  uses new CRAN submission process, as implemented by
  [`submit_cran()`](https://devtools.r-lib.org/dev/reference/submit_cran.md)
  ([\#430](https://github.com/r-lib/devtools/issues/430)).

### Package installation

- All `install_*` now use the same code and store much useful metadata.
  Currently only
  [`session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)
  takes advantage of this information, but it will allow the development
  of future tools like generic update functions.

- Vignettes are no longer installed by default because they potentially
  require all suggested packages to also be installed. Use
  `build_vignettes = TRUE` to force building and to install all
  suggested packages
  ([\#573](https://github.com/r-lib/devtools/issues/573)).

- [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  has been bought into alignment with
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md):
  this means you can now specify repos with the compact
  `username/repo@ref` syntax. The `username` is now deprecated.

- [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  has been simplified and many of the arguments have changed names for
  consistency with metadata for other package installs.

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  has been considerably improved:

  - `username` is deprecated - please include the user in the repo name:
    `rstudio/shiny`, `hadley/devtools` etc.

  - `dependencies = TRUE` is no longer forced (regression in 1.5)
    ([@krlmlr](https://github.com/krlmlr),
    [\#462](https://github.com/r-lib/devtools/issues/462)).

  - Deprecated parameters `auth_user`, `branch`, `pull` and `password`
    have all been removed.

  - New `host` argument which allows you to install packages from github
    enterprise ([\#410](https://github.com/r-lib/devtools/issues/410),
    [\#506](https://github.com/r-lib/devtools/issues/506)).

  - The GitHub API is used to download archive file
    ([@krlmlr](https://github.com/krlmlr),
    [\#466](https://github.com/r-lib/devtools/issues/466)) - this makes
    it less likely to break in the future.

  - To download a specified pull request, use `ref = github_pull(...)`
    ([@krlmlr](https://github.com/krlmlr),
    [\#509](https://github.com/r-lib/devtools/issues/509)). To install
    the latest release, use `"user/repo@*release"` or
    `ref = github_release()` ([@krlmlr](https://github.com/krlmlr),
    [\#350](https://github.com/r-lib/devtools/issues/350)).

- `install_gitorious()` has been bought into alignment with
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md):
  this means you can now specify repos with the compact
  `username/repo@ref` syntax. You must now always supply user (project)
  name and repo.

- [`install_svn()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  lets you install an R package from a subversion repository (assuming
  you have subversion installed).

- `decompress()` and hence
  [`install_url()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now work when the downloaded file decompresses without additional
  top-level directory
  ([\#537](https://github.com/r-lib/devtools/issues/537)).

### Other minor improvements and bug fixes

- If you’re using RStudio, and you’re trying to build a binary package
  without the necessary build tools, RStudio will prompt to download and
  install the right thing.
  ([\#488](https://github.com/r-lib/devtools/issues/488))

- Commands are no longer run with `LC_ALL=C` - this no longer seems
  necessary ([\#507](https://github.com/r-lib/devtools/issues/507)).

- `build(binary = TRUE)` creates an even-more-temporary package library
  avoid conflicts
  ([\#557](https://github.com/r-lib/devtools/issues/557)).

- `check_dir()` no longer fails on UNC paths
  ([\#522](https://github.com/r-lib/devtools/issues/522)).

- `check_devtools()` also checks for dependencies on development
  versions of packages
  ([\#534](https://github.com/r-lib/devtools/issues/534)).

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  no longer fails on partial loading of a package containing S4 or RC
  classes ([\#577](https://github.com/r-lib/devtools/issues/577)).

- On windows,
  [`find_rtools()`](https://pkgbuild.r-lib.org/reference/has_rtools.html)
  is now run on package load, not package attach.

- [`help()`](https://rdrr.io/r/utils/help.html), `?`, and
  [`system.file()`](https://rdrr.io/r/base/system.file.html) are now
  made available when a package is loaded with
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md),
  even if the devtools package isn’t attached.

- `httr` 0.3 required ([@krlmlr](https://github.com/krlmlr),
  [\#466](https://github.com/r-lib/devtools/issues/466)).

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  no longer gives an error when objects listed as exports are missing.

- Shim added for
  [`library.dynam.unload()`](https://rdrr.io/r/base/library.dynam.html).

- [`loaded_packages()`](https://devtools.r-lib.org/dev/reference/loaded_packages.md)
  now returns package name and path it was loaded from.
  ([\#486](https://github.com/r-lib/devtools/issues/486))

- The `parenvs()` function has been removed from devtools, because is
  now in the pryr package.

- [`missing_s3()`](https://devtools.r-lib.org/dev/reference/missing_s3.md)
  uses a better heuristic for determining if a function is a S3 method
  ([\#393](https://github.com/r-lib/devtools/issues/393)).

- New
  [`session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html)
  provides useful information about your R session. It’s a little more
  focussed than
  [`sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html) and
  includes where packages where installed from
  ([\#526](https://github.com/r-lib/devtools/issues/526)).

- `rstudioapi` package moved from suggests to imports, since it’s always
  needed (it’s job is to figure out if rstudio is available,
  [\#458](https://github.com/r-lib/devtools/issues/458))

- Implemented own version
  [`utils::unzip()`](https://rdrr.io/r/utils/unzip.html) that throws
  error if command fails and doesn’t print unneeded messages on
  non-Windows platforms
  ([\#540](https://github.com/r-lib/devtools/issues/540)).

- Wrote own version of [`write.dcf()`](https://rdrr.io/r/base/dcf.html)
  that doesn’t butcher whitespace and fieldnames.

### Removed functionality

- The `fresh` argument to
  [`test()`](https://devtools.r-lib.org/dev/reference/test.md) has been
  removed - this is best done by the editor since it can run the tests
  in a completely clean environment by starting a new R session.

- `compile_dll()` can now build packages located in R’s
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html) directory
  ([@richfitz](https://github.com/richfitz),
  [\#531](https://github.com/r-lib/devtools/issues/531)).

## devtools 1.5

CRAN release: 2014-04-07

Four new functions make it easier to add useful infrastructure to
packages:

- `add_test_infrastructure()` will create test infrastructure for a new
  package. It is called automatically from
  [`test()`](https://devtools.r-lib.org/dev/reference/test.md) if no
  test directories are found, the session is interactive and you agree.

- `add_rstudio_project()` adds an RStudio project file to your package.
  [`create()`](https://devtools.r-lib.org/dev/reference/create.md) gains
  an `rstudio` argument which will automatically create an RStudio
  project in the package directory. It defaults to `TRUE`: if you don’t
  use RStudio, just delete the file.

- `add_travis()` adds a basic travis template to your package.
  `.travis.yml` is automatically added to `.Rbuildignore` to avoid
  including it in the built package.

- `add_build_ignore()` makes it easy to add files to `.Rbuildignore`,
  correctly escaping special characters

Two dependencies were incremented:

- devtools requires at least R version 3.0.2.

- [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  requires at least roxygen2 version 3.0.0.

### Minor improvements

- `build_win()` now builds R-release and R-devel by default
  ([@krlmlr](https://github.com/krlmlr),
  [\#438](https://github.com/r-lib/devtools/issues/438)). It also gains
  parameter `args`, which is passed on to
  [`build()`](https://devtools.r-lib.org/dev/reference/build.md)
  ([@krlmlr](https://github.com/krlmlr),
  [\#421](https://github.com/r-lib/devtools/issues/421)).

- `check_doc()` now runs
  [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  automatically.

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md)
  gains `thread` argument which allows you to install multiple packages
  in parallel ([@mllg](https://github.com/mllg),
  [\#401](https://github.com/r-lib/devtools/issues/401)). `threads`
  argument to `check_cran()` now defaults to `getOption("Ncpus")`

- `install_deps(deps = T)` no longer installs all dependencies of
  dependencies ([\#369](https://github.com/r-lib/devtools/issues/369)).

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now prefers personal access tokens supplied to `auth_token` rather
  than passwords ([\#418](https://github.com/r-lib/devtools/issues/418),
  [@jeroenooms](https://github.com/jeroenooms)).

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now defaults to `dependencies = TRUE` so you definitely get all the
  packages you need to build from source.

- devtools supplies its own version of
  [`system.file()`](https://rdrr.io/r/base/system.file.html) so that
  when the function is called from the R console, it will have special
  behavior for packages loaded with devtools.

- devtools supplies its own version of `help` and `?`, which will search
  devtools-loaded packages as well as normally-loaded packages.

### Bug fixes

- `check_devtools()` no longer called by
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md) because
  the relevant functionality is now included in `R CMD CHECK` and it was
  causing false positives
  ([\#446](https://github.com/r-lib/devtools/issues/446)).

- `install_deps(TRUE)` now includes packages listed in `VignetteBuilder`
  ([\#396](https://github.com/r-lib/devtools/issues/396))

- [`build()`](https://devtools.r-lib.org/dev/reference/build.md) no
  longer checks for `pdflatex` when building vignettes, as many modern
  vignettes don’t need it
  ([\#398](https://github.com/r-lib/devtools/issues/398)). It also uses
  `--no-build-vignettes` for \>3.0.0 compatibility
  ([\#391](https://github.com/r-lib/devtools/issues/391)).

- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  does a better job of opening your email client if you’re inside of
  RStudio ([\#433](https://github.com/r-lib/devtools/issues/433)).

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  correctly reports the location of the `R CMD check` output when called
  with a custom `check_dir`. (Thanks to
  [@brentonk](https://github.com/brentonk))

- `check_cran()` records check times for each package tested.

- Improved default `DESCRIPTION` file created by `create_description()`.
  (Thanks to [@ncarchedi](https://github.com/ncarchedi),
  [\#428](https://github.com/r-lib/devtools/issues/428))

- Fixed bug in
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  that prevented installing a pull request by supplying
  `repo = "username/repo#pull"`.
  ([\#388](https://github.com/r-lib/devtools/issues/388))

- explicitly specify user agent when querying user name and ref for pull
  request in `install_github`. (Thanks to Kirill Müller,
  [\#405](https://github.com/r-lib/devtools/issues/405))

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now removes blank lines found in a package `DESCRIPTION` file,
  protecting users from the vague `error: contains a blank line` error.
  ([\#394](https://github.com/r-lib/devtools/issues/394))

- `with_options()` now works, instead of throwing an error (Thanks to
  [@krlmlr](https://github.com/krlmlr),
  [\#434](https://github.com/r-lib/devtools/issues/434))

## devtools 1.4.1

CRAN release: 2013-11-27

- Fixed bug in [`wd()`](https://devtools.r-lib.org/dev/reference/wd.md)
  when `path` was omitted.
  ([\#374](https://github.com/r-lib/devtools/issues/374))

- Fixed bug in `dev_help()` that prevented it from working when not
  using RStudio.

- [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md)
  respects new github policy by sending user agent (hadley/devtools)

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now takes repo names of the form
  `[username/]repo[/subdir][@ref|#pull]` - this is now the recommended
  form to specify username, subdir, ref and/or pull for install_github.
  (Thanks to Kirill Müller,
  [\#376](https://github.com/r-lib/devtools/issues/376))

## devtools 1.4

CRAN release: 2013-11-20

### Installation improvements

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) now
  respects the global option `keep.source.pkgs`.

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md)
  gains a `build_vignettes` which defaults to TRUE, and ensures that
  vignettes are built even when doing a local install. It does this by
  forcing `local = FALSE` if the package has vignettes, so `R CMD build`
  can follow the usual process.
  ([\#344](https://github.com/r-lib/devtools/issues/344))

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now takes repo names of the form `username/repo` - this is now the
  recommended form for install_github if your username is not hadley ;)

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now adds details on the source of the installed package
  (e.g. repository, SHA1, etc.) to the package DESCRIPTION file. (Thanks
  to JJ Allaire)

- Adjusted
  [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  to new meta data structure on CRAN. (Thanks to Kornelius Rohmeyer)

- Fixed bug so that
  [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  works with version numbers that contain hyphens. (Thanks to Kornelius
  Rohmeyer)

- [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  is now exported, making it easier to install the dependencies of a
  package.

### Other minor improvements

- `build(binary = TRUE)` now no longer installs the package as a
  side-effect. ([\#335](https://github.com/r-lib/devtools/issues/335))

- `build_github_devtools()` is a new function which makes it easy for
  Windows users to upgrade to the development version of devtools.

- `create_description()` does a better job of combining defaults and
  user specified options.
  ([\#332](https://github.com/r-lib/devtools/issues/332))

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md)
  also installs the dependencies that do not have the required versions;
  besides, the argument `dependencies` now works like
  [`install.packages()`](https://rdrr.io/r/utils/install.packages.html)
  (in previous versions, it was essentially
  `c("Depends", "Imports", "LinkingTo")`) (thanks, Yihui Xie,
  [\#355](https://github.com/r-lib/devtools/issues/355))

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) and
  `check_cran()` gain new `check_dir` argument to control where checking
  takes place ([\#337](https://github.com/r-lib/devtools/issues/337))

- `check_devtools()` no longer incorrectly complains about a
  `vignettes/` directory

- Decompression of zip files now respects `getOption("unzip")`
  ([\#326](https://github.com/r-lib/devtools/issues/326))

- `dev_help` will now use the RStudio help pane, if you’re using a
  recent version of RStudio
  ([\#322](https://github.com/r-lib/devtools/issues/322))

- Release is now a little bit smarter: if it’s a new package, it’ll ask
  you to read and agree to the CRAN policies; it will only ask about
  dependencies if it has any.

- [`source_url()`](https://devtools.r-lib.org/dev/reference/source_url.md)
  (and
  [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md))
  accept SHA1 prefixes.

- [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md)
  uses the GitHub API to reliably locate the raw gist. Additionally it
  now only attempts to source files with `.R` or `.r` extensions, and
  gains a `quiet` argument.
  ([\#348](https://github.com/r-lib/devtools/issues/348))

- Safer installation of source packages, which were previously extracted
  directly into the temp directory; this could be a problem if directory
  names collide. Instead, source packages are now extracted into unique
  subdirectories.

## devtools 1.3

CRAN release: 2013-07-04

### Changes to best practices

- The documentation for many devtools functions has been considerably
  expanded, aiming to give the novice package developer more hints about
  what they should be doing and why.

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  now defaults to `reset = TRUE` so that changes to the NAMESPACE etc.
  are incorporated. This makes it slightly slower (but hopefully not
  noticeably so), and generally more accurate, and a better simulation
  of the install + restart + reload cycle.

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) now looks
  in both `inst/test` and `tests/testthat` for unit tests. It is
  recommended to use `tests/testthat` because it allows users to choose
  whether or not to install test. If you move your tests from
  `inst/tests` to `tests/testthat`, you’ll also need to change
  `tests/test-all.R` to run `test_check()` instead of `test_package()`.
  This change requires testthat 0.8 which will be available on CRAN
  shortly.

- New devtools guarantee: if because of a devtools bug, a CRAN
  maintainer yells at you, I’ll send you a hand-written apology note.
  Just forward me the email and your address.

### New features

- New
  [`install_local()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  function for installing local package files (as zip, tar, tgz, etc.)
  (Suggested by landroni)

- [`parse_deps()`](https://pkgload.r-lib.org/reference/parse_deps.html),
  which parses R’s package dependency strings, is now exported.

- All package and user events (e.g. load, unload, attach and detach) are
  now called in the correct place.

### Minor improvements and bug fixes

- [`build()`](https://devtools.r-lib.org/dev/reference/build.md) gains
  `args` parameter allowing you to add additional arbitrary arguments,
  and [`check()`](https://devtools.r-lib.org/dev/reference/check.md)
  gains similar `build_args` parameter.

- `install_git` gains `git_arg` parameter allowing you to add arbitrary
  additional arguments.

- Files are now loaded in a way that preserves srcreferences - this
  means that you will get much better locations on error messages, which
  should considerably aid debugging.

- Fixed bug in
  [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  which prevented files in `inst/doc` from being updated

- [`as.package()`](https://devtools.r-lib.org/dev/reference/as.package.md)
  no longer uses the full path, which should make for nicer error
  messages.

- More flexibility when installing package dependencies with the
  `dependencies` argument to `install_*()` (thanks to Martin Studer)

- The deprecated `show_rd()` function has now been removed.

- [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  gains `auth_user` and `password` params so that you can install from
  private repos (thanks to Brian Bolt)

- Better git detection on windows (thanks to Mikhail Titov)

- Fix bug so that
  [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  will automatically create `man/` directory

- Default `DESCRIPTION` gains `LazyData: true`

- `create_description()` now checks that the directory is probably a
  package by looking for `R/`, `data/` or `src/` directories

- Rolled back required R version from 3.0 to 2.15.

- Add missing import for `digest()`

- Bump max compatible version of R with RTools 3.0, and add details for
  RTools 3.1

## devtools 1.2

CRAN release: 2013-04-17

### Better installation

- `install` gains a `local` option for installing the package from the
  local package directory, rather than from a built tar.gz. This is now
  used by default for all package installations. If you want to
  guarantee a clean build, run `local = FALSE`

- `install` now uses option `devtools.install.args` for default
  installation arguments. This allows you to set any useful defaults
  (e.g. `--no-multiarch`) in your Rprofile.

- `install_git` gains `branch` argument to specify branch or tag (Fixes
  [\#255](https://github.com/r-lib/devtools/issues/255))

### Clean sessions

- `run_examples` and `test` gain a `fresh` argument which forces them to
  run in a fresh R session. This completely insulates the examples/tests
  from your current session but means that interactive code (like
  [`browser()`](https://rdrr.io/r/base/browser.html)) won’t work.(Fixes
  [\#258](https://github.com/r-lib/devtools/issues/258))

- New functions `eval_clean` and `evalq_clean` make it easy to evaluate
  code in a clean R session.

- `clean_source` loses the `vanilla` argument (which did not work) and
  gains a `quiet` argument

### New features

- `source_url` and `source_gist` now allow you to specify a sha, so you
  can make sure that files you source from the internet don’t change
  without you knowing about it. (Fixes
  [\#259](https://github.com/r-lib/devtools/issues/259))

- `build_vignettes` builds using `buildVignette()` and movies/copies
  outputs using the same algorithm as `R CMD build`. This means that
  [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  now exactly mimics R’s regular behaviour, including building
  non-Sweave vignettes
  ([\#277](https://github.com/r-lib/devtools/issues/277)), building in
  the correct directory
  ([\#231](https://github.com/r-lib/devtools/issues/231)), using make
  files (if present), and copying over extra files.

- devtools now sets best practice compiler flags: from
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md),
  `-Wall -pedantic` and from
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md),
  `-Wall -pedantic -g -O0 -UNDEBUG`. These are prefixed to existing
  environment variables so that you can override them if desired. (Fixes
  [\#257](https://github.com/r-lib/devtools/issues/257))

- If there’s no `DESCRIPTION` file present,
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  will automatically create one using `create_description()`. You can
  set options in your `.Rprofile` to control what it contains: see
  [`package?devtools`](https://devtools.r-lib.org/dev/reference/devtools-package.md)
  for more details.

### Minor improvements

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  also sets environment variable `_R_CHECK_CODE_DATA_INTO_GLOBALENV_` to
  TRUE (to match current `--as-cran` behaviour) (Fixes
  [\#256](https://github.com/r-lib/devtools/issues/256))

- Improved default email sent by
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md),
  eliminating
  [`create.post()`](https://rdrr.io/r/utils/create.post.html)
  boilerplate

- `revdep` includes LinkingTo by default.

- Fixed regular expression problem that caused RTools `3.0.*` to fail to
  be found on Windows.

- `load_data()` got an overhaul and now respects `LazyData` and
  correctly exports datasets by default (Fixes
  [\#242](https://github.com/r-lib/devtools/issues/242))

- `with_envvar` gains the option to either replace, prefix or suffix
  existing environmental variables. The default is to replace, which was
  the previous behaviour.

- `check_cran` includes
  [`sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html) in the
  summary output (Fixes
  [\#273](https://github.com/r-lib/devtools/issues/273))

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md) gains
  a `check` argument which defaults to FALSE.

- `with_env` will be deprecated in 1.2 and removed in 1.3

- When
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md)
  calls `.onAttach()` and `.onLoad()`, it now passes the lib path to
  those functions.

## devtools 1.1

CRAN release: 2013-02-09

- [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md)
  has been updated to accept new gist URLs with username. (Fixes
  [\#247](https://github.com/r-lib/devtools/issues/247))

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md) and
  [`document()`](https://devtools.r-lib.org/dev/reference/document.md)
  now set environment variables, including NOT_CRAN.

- Test packages have been renamed to avoid conflicts with existing
  packages on CRAN. This bug prevented devtools 1.0 from passing check
  on CRAN for some platforms.

- Catch additional case in
  [`find_rtools()`](https://pkgbuild.r-lib.org/reference/has_rtools.html):
  previously installed, but directory empty/deleted (Fixes
  [\#241](https://github.com/r-lib/devtools/issues/241))

## devtools 1.0

CRAN release: 2013-01-22

### Improvements to package loading

- Rcpp attributes are now automatically compiled during build.

- Packages listed in depends are
  [`require()`](https://rdrr.io/r/base/library.html)d (Fixes
  [\#161](https://github.com/r-lib/devtools/issues/161),
  [\#178](https://github.com/r-lib/devtools/issues/178),
  [\#192](https://github.com/r-lib/devtools/issues/192))

- `load_all` inserts a special version of `system.file` into the
  package’s imports environment. This tries to simulate the behavior of
  [`base::system.file`](https://rdrr.io/r/base/system.file.html) but
  gives modified results because the directory structure of installed
  packages and uninstalled source packages is different. (Fixes
  [\#179](https://github.com/r-lib/devtools/issues/179)). In other
  words, `system.file` should now just work even if the package is
  loaded with devtools.

- Source files are only recompiled if they’ve changed since the last
  run, and the recompile will be clean (`--preclean`) if any exported
  header files have changed. (Closes
  [\#224](https://github.com/r-lib/devtools/issues/224))

- The compilation process now performs a mock install instead of using
  `R CMD SHLIB`. This means that `Makevars` and makefiles will now be
  respected and generally there should be fewer mismatches between
  `load_all` and the regular install and reload process.

- S4 classes are correctly loaded and unloaded.

### Windows

- Rtools detection on windows has been substantially overhauled and
  should both be more reliable, and when it fails give more information
  about what is wrong with your install.

- If you don’t have rtools installed, devtools now automatically sets
  the TAR environment variable to internal so you can still build
  packages.

### Minor features

- `check_cran` now downloads packages from cran.rstudio.com.

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md) now
  makes the CRAN version check optional, and off by default. The
  [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  function still checks the version number against CRAN.

- In [`check()`](https://devtools.r-lib.org/dev/reference/check.md), it
  is optional to require suggested packages, using the `force_suggests`
  option.

- When [`check()`](https://devtools.r-lib.org/dev/reference/check.md) is
  called, the new default behavior is to not delete existing .Rd files
  from man/. This behavior can be set with the “devtools.cleandoc”
  option.

- [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now always uses lowercase repo names. (Thanks to mnel)

- New function `with_lib()`, which runs an expression code with a
  library path prepended to the existing libpaths. It differs slightly
  from `with_libpaths()`, which replaces the existing libpaths.

- New function
  [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  installs a package directly from a git repository. (Thanks to David
  Coallier)

- If `pdflatex` isn’t available, don’t try to build vignettes with
  [`install()`](https://devtools.r-lib.org/dev/reference/install.md) or
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md). (Fixes
  [\#173](https://github.com/r-lib/devtools/issues/173))

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  now downloads from a new URL, to reflect changes on how files are
  hosted on GitHub.

- [`build()`](https://devtools.r-lib.org/dev/reference/build.md) now has
  a `vignettes` option to turn off rebuilding vignettes.

- `install(quick=TRUE)` now builds the package without rebuilding
  vignettes. (Fixes
  [\#167](https://github.com/r-lib/devtools/issues/167))

- All R commands called from `devtools` now have the environment
  variable `NOT_CRAN` set, so that you can perform tasks when you know
  your code is definitely not running on CRAN. (Closes
  [\#227](https://github.com/r-lib/devtools/issues/227))

- Most devtools functions can a quiet argument that suppresses output.
  This is particularly useful for testing.

### Bug fixes

- Fixed path issue when looking for Rtools on windows when registry
  entry is not present. (Fixes
  [\#201](https://github.com/r-lib/devtools/issues/201))

- Reloading a package that requires a forced-unload of the namespace now
  works.

- When reloading a package that another loaded package depends on, if
  there was an error loading the code, devtools would print out
  something about an error in `unloadNamespace`, which was confusing. It
  now gives more useful errors.

- An intermittent error in `clear_topic_index` related to using
  [`rm()`](https://rdrr.io/r/base/rm.html) has been fixed. (Thanks to
  Gregory Jefferis)

- [`revdep()`](https://devtools.r-lib.org/dev/reference/revdep.md) now
  lists “Suggests” packages, in addition to “Depends” and “Imports”.

- `revdep_check()` now correctly passes the `recursive` argument to
  [`revdep()`](https://devtools.r-lib.org/dev/reference/revdep.md).

- The collection of check results at the end of `check_cran()`
  previously did not remove existing results, but now it does.

- When a package is loaded with
  [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md),
  it now passes the name of the package to the `.onLoad()` function.
  (Thanks to Andrew Redd)

## devtools 0.8.0

### New features

- `create` function makes it easier to create a package skeleton using
  devtools standards.

- [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  can now install from a pull request – it installs the branch
  referenced in the pull request.

- `install_github` now accepts `auth_user` and `password` arguments if
  you want to install a package in a private github repo. You only need
  to specify `auth_user` if it’s not your package (i.e. it’s not your
  `username`) (Fixes
  [\#116](https://github.com/r-lib/devtools/issues/116))

- new `dev_help` function replaces `show_rd` and makes it easy to get
  help on any topic in a development package (i.e. a package loaded with
  `load_all`) (Fixes
  [\#110](https://github.com/r-lib/devtools/issues/110))

- `dev_example` runs the examples for one in-development package. (Fixes
  [\#108](https://github.com/r-lib/devtools/issues/108))

- `build_vignettes` now looks in modern location for vignettes
  (`vignettes/`) and warn if vignettes found in old location
  (`inst/doc`). Building now occurs in a temporary directory (to avoid
  polluting the package with build artefacts) and only final pdf files
  are copied over.

- new `clean_vignettes` function to remove pdfs in `inst/doc` that were
  built from vignettes in `vignettes/`

- `load_all` does a much better job at simulating package loading (see
  LOADING section). It also compiles and loads C/C++/Fortran code.

- [`unload()`](https://pkgload.r-lib.org/reference/unload.html) is now
  an exported function, which unloads a package, trying harder than just
  `detach`. It now also unloads DLLs. (Winston Chang. Fixes
  [\#119](https://github.com/r-lib/devtools/issues/119))

- `run_examples` now has parameters `show`, `test`, `run` to control
  which of `\dontrun{}`, `\dontshow{}`, `\donttest{}` and `\testonly{}`
  are commented out. The `strict` parameter has been removed since it is
  no longer necessary because `load_all` can respect namespaces. (Fixes
  [\#118](https://github.com/r-lib/devtools/issues/118))

- [`build()`](https://devtools.r-lib.org/dev/reference/build.md),
  [`check()`](https://devtools.r-lib.org/dev/reference/check.md),
  [`install()`](https://devtools.r-lib.org/dev/reference/install.md) etc
  now run R in `--vanilla` mode which prevents it from reading any of
  your site or personal configuration files. This should prevent
  inconsistencies between the environment in which the package is run
  between your computer and other computers (e.g. the CRAN server)
  (Fixes [\#145](https://github.com/r-lib/devtools/issues/145))

- All system R command now print the full command used to make it easier
  to understand what’s going on.

### Package paths

- `as.package` no longer uses `~/.Rpackages`.

- `as.package` provides more informative error messages when path does
  not exist, isn’t a directory, or doesn’t contain a `DESCRIPTION` file.

- New function `inst()` takes the name of a package and returns the
  installed path of that package. (Winston Chang. Fixes
  [\#130](https://github.com/r-lib/devtools/issues/130)). This makes it
  possible to use `devtools` functions (e.g. `unload`) with regular
  installed packages, not just in-development source packages.

- New function `devtest()` returns paths to an internal testing packages
  in devtools.

### Loading

- Development packages are now loaded into a namespace environment, ,
  and then the objects namespace are copied to the package environment,
  . This more accurately simulates how packages are normally loaded.
  However, all of the objects (not just the exported ones) are still
  copied to the package environment. (Winston Chang. Fixes
  [\#3](https://github.com/r-lib/devtools/issues/3),
  [\#60](https://github.com/r-lib/devtools/issues/60), and
  [\#125](https://github.com/r-lib/devtools/issues/125))

- Packages listed in Imports and Depends are now loaded into an imports
  environment, with name attribute “imports:xxxx”, which is the parent
  of the namespace environment. The imports environment is in turn a
  child of the

- The NAMESPACE file is now used for loading imports, instead of the
  DESCRIPTION file. Previously, `load_all` loaded all objects from the
  packages listed in DESCRIPTION. Now it loads packages (and, when
  ‘importFrom’ is used, specific objects from packages) listed in
  NAMESPACE. This more closely simulates normal package loading. It
  still checks version numbers of packages listed in DESCRIPTION.
  (Winston Chang)

- `load_all` can now be used to properly reload devtools. It does this
  by creating a copy of the devtools namespace environment, and calling
  `load_all` from that environment. (Winston Chang)

- The `.onLoad` and `.onAttach` functions for a development package are
  now both called when loading a package for the first time, or with
  `reset=TRUE`, and the order more correctly simulates normal package
  loading (create the namespace, call `.onLoad`, copy objects to the
  package environment, and then call `.onAttach`). (Winston Chang)

- `load_all` will now throw a warning if a dependency package does not
  satisfy the version requirement listed in DESCRIPTION. (Winston Chang.
  Fixes [\#109](https://github.com/r-lib/devtools/issues/109))

- The package environment now has a ‘path’ attribute, similar to a
  package loaded the normal way. (Winston Chang)

- `load_all` now has an option `export_all`. When set to TRUE, only the
  objects listed as exports in NAMESPACE are exported. (Winston Chang)

- `load_all` now compiles C files in the /src directory. (Winston Chang)

- New functions `compile_dll()` and
  [`clean_dll()`](https://pkgbuild.r-lib.org/reference/clean_dll.html),
  which compile C/C++/ Fortran source code, and clean up the compiled
  objects, respectively. (Winston Chang. Fixes
  [\#131](https://github.com/r-lib/devtools/issues/131))

### Bug fixes

- `load_code` now properly skips missing files. (Winston Chang)

- Add `--no-resave-data` to default build command.

- The subject line of the email created by `release` is now “CRAN
  submission \[package\] \[version\]”, per CRAN repository policy.

- `install_bitbucket` properly installs zip files of projects stored in
  Mercurial repositories. (Winston Chang. Fixes
  [\#148](https://github.com/r-lib/devtools/issues/148))

- `build` now builds vignettes because `install` does not. (Fixes
  [\#155](https://github.com/r-lib/devtools/issues/155))

### Introspection

- New function
  [`loaded_packages()`](https://devtools.r-lib.org/dev/reference/loaded_packages.md),
  which returns the names of packages that are loaded and attached.

- Packages loaded with `load_all` now store devtools metadata in their
  namespace environment, in a variable called `.__DEVTOOLS__`. This can
  be accessed with the `dev_meta` function. (Winston Chang. Fixes
  [\#128](https://github.com/r-lib/devtools/issues/128))

- `dev_mode` now stores the path it uses in option `dev_path`. That
  makes it easy for other applications to detect when it is on and to
  act accordingly.

- New function `parse_ns_file()`, which parses a NAMESPACE file for a
  package.

- New function `parenvs()`, which parents the parent environments of an
  object. (Winston Chang)

## devtools 0.7.1

CRAN release: 2012-07-02

- bump dependency to R 2.15

- `load_code` now also looks for files ending in `.q` - this is not
  recommended, but is needed for some older packages

## devtools 0.7

CRAN release: 2012-06-19

### Installation

- `install_bitbucket` installs R packages on bitbucket.

- `install` now uses `--with-keep.source` to make debugging a little
  easier.

- All remote install functions give better error messages in the case of
  http errors (Fixes
  [\#82](https://github.com/r-lib/devtools/issues/82)).

- `install` has new quick option to make package installation faster, by
  sacrificing documentation, demos and multi-architecture binaries.
  (Fixes [\#77](https://github.com/r-lib/devtools/issues/77))

- `install_url`, `install_github` and `install_gitorious` gain a subdir
  argument which makes it possible to install packages that are
  contained within a sub-directory of a repository or compressed file.
  (Fixes [\#64](https://github.com/r-lib/devtools/issues/64))

### Checking

- `with_debug` function temporarily sets env vars so that compilation is
  performed with the appropriate debugging flags set. Contributed by
  Andrew Redd.

- `revdep`, `revdep_maintainers` and `revdep_check` for calculating
  reverse dependencies, finding their maintainers and running
  `R CMD check`. (Fixes
  [\#78](https://github.com/r-lib/devtools/issues/78))

- `check_cran` has received a massive overhaul: it now checks multiple
  packages, installs dependencies (in user specified library), and parse
  check output to extract errors and warnings

- `check` uses new `--as-cran` option to make checking as close to CRAN
  as possible (fixes
  [\#68](https://github.com/r-lib/devtools/issues/68))

### Other new features

- devtools now uses options `devtools.path` to set the default path to
  use with devmode, and `github.user` to set the default user when
  installing packages from github.

- if no package supplied, and no package has been worked with
  previously, all functions now will try the working directory. (Fixes
  [\#87](https://github.com/r-lib/devtools/issues/87))

- on windows, devtools now looks in the registry to find where Rtools is
  installed, and does a better a job of locating gcc. (Contributed by
  Andrew Redd)

- `show_rd` passes `...` on to `Rd2txt` - this is useful if you’re
  checking how build time `\Sexpr`s are generated.

- A suite of `with` functions that allow you to temporarily alter the
  environment in which code is run: `in_dir`, `with_collate`,
  `with_locale`, `with_options`, `with_path`, … (Fixes
  [\#89](https://github.com/r-lib/devtools/issues/89))

- `release` ask more questions and randomises correct answers so you
  really need to read them (Fixes
  [\#79](https://github.com/r-lib/devtools/issues/79))

- `source_gist` now accepts default url such as
  “<https://gist.github.com/nnn>”

- New system path manipulation functions, `get_path`, `set_path`,
  `add_path` and `on_path`, contributed by Andrew Redd.

- If you’re on windows, `devtools` now suppresses the unimportant
  warning from CYGWIN about the dos style file paths

### Bug fixes

- `decompress` now uses target directory as defined in the function call
  when expanding a compressed file. (Fixes
  [\#84](https://github.com/r-lib/devtools/issues/84))

- `document` is always run in a C locale so that `NAMESPACE` sort order
  is consistent across platforms.

- `install` now quotes `libpath` and build path so paths with embedded
  spaces work (Fixes [\#73](https://github.com/r-lib/devtools/issues/73)
  and [\#76](https://github.com/r-lib/devtools/issues/76))

- `load_data` now also loads `.RData` files (Fixes
  [\#81](https://github.com/r-lib/devtools/issues/81))

- `install` now has `args` argument to pass additional command line
  arguments on to `R CMD install` (replaces `...` which didn’t actually
  do anything). (Fixes
  [\#69](https://github.com/r-lib/devtools/issues/69))

- `load_code` does a better job of reconciling files in DESCRIPTION
  collate with files that actually exist in the R directory. (Fixes
  [\#14](https://github.com/r-lib/devtools/issues/14))

## devtools 0.6

CRAN release: 2012-02-28

### New features

- `test` function takes `filter` argument which allows you to restrict
  which tests are to be run

- `check` runs with example timings, as is done on CRAN. Run with new
  param `cleanup = F` to access the timings.

- `missing_s3` function to help figure out if you’ve forgotten to export
  any s3 methods

- `check_cran` downloads and checks a CRAN package - this is useful to
  run as part of the testing process of your package if you want to
  check the dependencies of your package

- `strict` mode for `run_examples` which runs each example in a clean
  environment. This is much slower than the default (running in the
  current environment), but ensures that each example works standalone.

- `dev_mode` now updates prompt to indicate that it’s active (Thanks to
  Kohske Takahashi)

- new `source_url` function for sourcing script on a remote server via
  protocols other than http (e.g. https or ftp). (Thanks to Kohske
  Takahashi)

- new `source_gist` function to source R code stored in a github gist.
  (Thanks to Kohske Takahashi)

- `load_all` now also loads all package dependencies (including
  suggestions) - this works around some bugs in the way that devtools
  attaches the development environment into the search path in a way
  that fails to recreate what happens normally during package loading.

### Installation

- remote installation will ensure the configure file is executable.

- all external package installation functions are vectorised so you can
  install multiple packages at time

- new `install_gitorious` function install packages in gitorious repos.

- new `install_url` function for installing package from an arbitrary
  url

- include `install_version` function from Jeremy Stephens for installing
  a specific version of a CRAN package from the archive.

### Better windows behaviour

- better check for OS type (thanks to Brian Ripley)

- better default paths for 64-bit R on windows (Fixes
  [\#35](https://github.com/r-lib/devtools/issues/35))

- check to see if Rtools is already available before trying to mess with
  the paths. (Fixes [\#55](https://github.com/r-lib/devtools/issues/55))

### Bug fixes

- if an error occurs when calling loading R files, the cache will be
  automatically cleared so that all files are loaded again next time you
  try (Fixes [\#55](https://github.com/r-lib/devtools/issues/55))

- functions that run R now do so with `R_LIBS` set to the current
  [`.libPaths()`](https://rdrr.io/r/base/libPaths.html) - this will
  ensure that checking uses the development library if you are in
  development mode. `R_ENVIRON_USER` is set to an empty file to avoid
  your existing settings overriding this.

- `load_data` (called by `load_all`) will also load data defined in R
  files in the data directory. (Fixes
  [\#45](https://github.com/r-lib/devtools/issues/45))

- `dev_mode` performs some basic tests to make sure you’re not setting
  your development library to a directory that’s not already an R
  library. (Fixes [\#25](https://github.com/r-lib/devtools/issues/25))

## devtools 0.5.1

CRAN release: 2011-12-07

- Fix error in that was causing R commands to fail on windows.

## devtools 0.5

CRAN release: 2011-12-04

### New functions

- new `show_rd` function that will show the development version of a
  help file.

### Improvements and bug fixes

- external R commands always run in locale `C`, because that’s what the
  CRAN severs do.

- `clean_source` sources an R script into a fresh R environment,
  ensuring that it can run independently of your current working
  environment. Optionally (`vanilla = T`), it will source in a vanilla R
  environment which ignores all local environment settings.

- On windows, `devtools` will also add the path to `mingw` on startup.
  (Thanks to pointer from Dave Lovell)

## devtools 0.4

CRAN release: 2011-07-23

### New functions

- new `wd` function to change the working directory to a package
  subdirectory.

- `check_doc` now checks package documentation as a whole, in the same
  way that `R CMD check` does, rather than low-level syntax checking,
  which is done by
  `roxygen2. DESCRIPTION checking has been moved into`load_all`.`check_rd\`
  has been removed.

- `build` is now exported, and defaults to building in the package’s
  parent directory. It also gains a new `binary` parameter controls
  whether a binary or a source version (with no vignettes or manuals) is
  built. Confusingly, binary packages are built with `R CMD INSTALL`.

- `build_win` sends your package to the R windows builder, allowing you
  to make a binary version of your package for windows users if you’re
  using linux or macOS (if you’re using windows already, use
  `build(binary = T)`)

### Improvements and bug fixes

- if using `.Rpackages` config file, default function is used last, not
  first.

- on Windows, `devtools` now checks for the presence of `Rtools` on
  startup, and will automatically add it to the path if needed.

- `document` uses `roxygen2` instead of `roxygen`. It now loads package
  dependency so that they’re available when roxygen executes the package
  source code.

- `document` has new parameter `clean` which clears all roxygen caches
  and removes all existing man files. `check` now runs `document` in
  this mode.

- `dev_mode` will create directories recursively, and complain if it
  can’t create them. It should also work better on windows.

- `install_github` now allows you to specify which branch to download,
  and automatically reloads package if needed.

- `reload` now will only reload if the package is already loaded.

- `release` gains `check` parameter that allows you to skip package
  check (if you’ve just done it.)

- `test` automatically reloads code so you never run tests on old code

## devtools 0.3

CRAN release: 2011-06-30

- new [`bash()`](https://devtools.r-lib.org/dev/reference/bash.md)
  function that starts bash shell in package directory. Useful if you
  want to use git etc.

- removed inelegant `update_src()` since now superseded by
  [`bash()`](https://devtools.r-lib.org/dev/reference/bash.md)

- fix bug in ftp upload that was adding extraneous space

- `build` function builds package in specified directory. `install`,
  `check` and `release` now all use this function.

- `build`, `install`, `check` and `release` better about cleaning up
  after themselves - always try to both work in session temporary
  directory and delete any files/directories that they create

## devtools 0.2

CRAN release: 2011-06-29

- `install_github` now uses `RCurl` instead of external `wget` to
  retrieve package. This should make it more robust wrt external
  dependencies.

- `load_all` will skip missing files with a warning (thanks to
  suggestion from Jeff Laake)

- `check` automatically deletes `.Rcheck` directory on successful
  completion

- Quote the path to R so it works even if there are spaces in the path.

## devtools 0.1

CRAN release: 2011-06-22

- Check for presence of `DESCRIPTION` when loading packages to avoid
  false positives

- `install` now works correctly with `devel_mode` to install packages in
  your development library

- `release` prints news so you can more easily check it

- All `R CMD xxx` functions now use the current R, not the first R found
  on the system path.
