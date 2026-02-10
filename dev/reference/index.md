# Package index

## Package development

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

- [`check_doc_fields()`](https://devtools.r-lib.org/dev/reference/check_doc_fields.md)
  : Check for missing documentation fields

- [`check_mac_release()`](https://devtools.r-lib.org/dev/reference/check_mac_release.md)
  [`check_mac_devel()`](https://devtools.r-lib.org/dev/reference/check_mac_release.md)
  : Check a package on macOS

- [`check_man()`](https://devtools.r-lib.org/dev/reference/check_man.md)
  :

  Check documentation, as `R CMD check` does

- [`check_win_devel()`](https://devtools.r-lib.org/dev/reference/check_win.md)
  [`check_win_release()`](https://devtools.r-lib.org/dev/reference/check_win.md)
  [`check_win_oldrelease()`](https://devtools.r-lib.org/dev/reference/check_win.md)
  : Check a package on Windows

- [`document()`](https://devtools.r-lib.org/dev/reference/document.md) :
  Use roxygen to document a package

- [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md) :
  Load complete package

- [`spell_check()`](https://devtools.r-lib.org/dev/reference/spell_check.md)
  : Spell checking

- [`test()`](https://devtools.r-lib.org/dev/reference/test.md)
  [`test_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  [`test_coverage()`](https://devtools.r-lib.org/dev/reference/test.md)
  [`test_coverage_active_file()`](https://devtools.r-lib.org/dev/reference/test.md)
  : Execute testthat tests in a package

## Package installation

- [`install()`](https://devtools.r-lib.org/dev/reference/install.md) :
  Install a local development package
- [`uninstall()`](https://devtools.r-lib.org/dev/reference/uninstall.md)
  : Uninstall a local development package

## Utilities

- [`dev_sitrep()`](https://devtools.r-lib.org/dev/reference/dev_sitrep.md)
  : Report package development situation
- [`lint()`](https://devtools.r-lib.org/dev/reference/lint.md) : Lint
  all source files in a package
- [`run_examples()`](https://devtools.r-lib.org/dev/reference/run_examples.md)
  : Run all examples in a package
- [`reexports`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`parse_deps`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`check_dep_version`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`with_debug`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`clean_dll`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`has_devel`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`find_rtools`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`is_loading`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`unload`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`session_info`](https://devtools.r-lib.org/dev/reference/reexports.md)
  [`package_info`](https://devtools.r-lib.org/dev/reference/reexports.md)
  : Objects exported from other packages
- [`source_gist()`](https://devtools.r-lib.org/dev/reference/source_gist.md)
  : Run a script on gist
- [`source_url()`](https://devtools.r-lib.org/dev/reference/source_url.md)
  : Run a script through some protocols such as http, https, ftp, etc
- [`save_all()`](https://devtools.r-lib.org/dev/reference/save_all.md) :
  Save all documents in an active IDE session

## Deprecated

- [`bash()`](https://devtools.r-lib.org/dev/reference/bash.md)
  **\[deprecated\]** : Open bash shell in package directory
- [`build_vignettes()`](https://devtools.r-lib.org/dev/reference/build_vignettes.md)
  **\[deprecated\]** : Build package vignettes
- [`clean_vignettes()`](https://devtools.r-lib.org/dev/reference/clean_vignettes.md)
  **\[deprecated\]** : Clean built vignettes
- [`create()`](https://devtools.r-lib.org/dev/reference/create.md)
  **\[deprecated\]** : Create a package
- [`dev_mode()`](https://devtools.r-lib.org/dev/reference/dev_mode.md)
  **\[deprecated\]** : Activate and deactivate development mode
- [`install_bioc()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_bitbucket()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_cran()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_dev()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_git()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_github()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_gitlab()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_local()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_svn()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_url()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`install_version()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`update_packages()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`dev_package_deps()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`github_pull()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  [`github_release()`](https://devtools.r-lib.org/dev/reference/install-deprecated.md)
  **\[deprecated\]** : Deprecated package installation functions
- [`install_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  [`install_dev_deps()`](https://devtools.r-lib.org/dev/reference/install_deps.md)
  **\[deprecated\]** : Install package dependencies if needed
- [`missing_s3()`](https://devtools.r-lib.org/dev/reference/missing_s3.md)
  **\[deprecated\]** : Find missing s3 exports
- [`reload()`](https://devtools.r-lib.org/dev/reference/reload.md)
  **\[deprecated\]** : Unload and reload package
- [`release()`](https://devtools.r-lib.org/dev/reference/release.md)
  **\[deprecated\]** : Release package to CRAN
- [`show_news()`](https://devtools.r-lib.org/dev/reference/show_news.md)
  **\[deprecated\]** : Show package news
- [`wd()`](https://devtools.r-lib.org/dev/reference/wd.md)
  **\[deprecated\]** : Set working directory
- [`test_file()`](https://devtools.r-lib.org/dev/reference/devtools-defunct.md)
  [`test_coverage_file()`](https://devtools.r-lib.org/dev/reference/devtools-defunct.md)
  : Defunct functions
