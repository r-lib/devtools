# Package index

## Package Development

Primary commands used when developing a package.

- [`build()`](https://devtools.r-lib.org/dev/reference/build.md) : Build
  package

- [`build_manual()`](https://devtools.r-lib.org/dev/reference/build_manual.md)
  : Create package pdf manual

- [`build_rmd()`](https://devtools.r-lib.org/dev/reference/build_rmd.md)
  [`build_readme()`](https://devtools.r-lib.org/dev/reference/build_rmd.md)
  : Build a Rmarkdown files package

- [`build_site()`](https://devtools.r-lib.org/dev/reference/build_site.md)
  :

  Run
  [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)

- [`check()`](https://devtools.r-lib.org/dev/reference/check.md)
  [`check_built()`](https://devtools.r-lib.org/dev/reference/check.md) :
  Build and check a package

- [`check_mac_release()`](https://devtools.r-lib.org/dev/reference/check_mac_release.md)
  [`check_mac_devel()`](https://devtools.r-lib.org/dev/reference/check_mac_release.md)
  : Check a package on macOS

- [`check_man()`](https://devtools.r-lib.org/dev/reference/check_man.md)
  :

  Check documentation, as `R CMD check` does.

- [`check_win_devel()`](https://devtools.r-lib.org/dev/reference/check_win.md)
  [`check_win_release()`](https://devtools.r-lib.org/dev/reference/check_win.md)
  [`check_win_oldrelease()`](https://devtools.r-lib.org/dev/reference/check_win.md)
  : Check a package on Windows

- [`create()`](https://devtools.r-lib.org/dev/reference/create.md) :
  Create a package

- [`document()`](https://devtools.r-lib.org/dev/reference/document.md) :
  Use roxygen to document a package.

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md) :
  Load complete package

- [`reload()`](https://devtools.r-lib.org/dev/reference/reload.md) :
  Unload and reload package.

- [`spell_check()`](https://devtools.r-lib.org/dev/reference/spell_check.md)
  : Spell checking

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md)
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md)
  [`test_coverage_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  : Execute testthat tests in a package

## Package Installation

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) :
  Install a local development package.
- [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  [`install_dev_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  : Install package dependencies if needed.
- [`uninstall()`](https://devtools.r-lib.org/dev/reference/uninstall.md)
  : Uninstall a local development package

## Utilities

- [`bash()`](https://devtools.r-lib.org/dev/reference/bash.md) : Open
  bash shell in package directory.
- [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  : Report package development situation
- [`github_pull()`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`github_release()`](https://devtools.r-lib.org/dev/reference/reexports.md)
  : Objects exported from other packages
- [`lint()`](https://devtools.r-lib.org/dev/reference/lint.md) : Lint
  all source files in a package
- [`missing_s3()`](https://devtools.r-lib.org/dev/reference/missing_s3.md)
  : Find missing s3 exports.
- [`run_examples()`](https://devtools.r-lib.org/dev/reference/run_examples.md)
  : Run all examples in a package.
- [`show_news()`](https://devtools.r-lib.org/dev/reference/show_news.md)
  : Show package news
- [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md)
  : Run a script on gist
- [`source_url()`](https://devtools.r-lib.org/dev/reference/source_url.md)
  : Run a script through some protocols such as http, https, ftp, etc.
- [`install_bioc()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_cran()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_dev()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_git()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_github()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_gitlab()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_local()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_svn()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_url()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`install_version()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`update_packages()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  [`dev_package_deps()`](https://devtools.r-lib.org/dev/reference/remote-reexports.md)
  : Functions re-exported from the remotes package
- [`wd()`](https://devtools.r-lib.org/dev/reference/wd.md) : Set working
  directory.
- [`save_all()`](https://devtools.r-lib.org/dev/reference/save_all.md) :
  Save all documents in an active IDE session.

## Deprecated functions

- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  **\[deprecated\]** : Build package vignettes
- [`clean_vignettes()`](https://devtools.r-lib.org/dev/reference/clean_vignettes.md)
  **\[deprecated\]** : Clean built vignettes
- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  **\[deprecated\]** : Release package to CRAN.
