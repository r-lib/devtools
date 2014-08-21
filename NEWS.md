# devtools 1.5.0.99

## The release process

* You can add arbitrary extra questions to `release()` by defining a function 
  `release_questions()` in your package. Your `release_questions()` should 
  return a character vector of questions to ask (#451). 

* `release()` uses new CRAN submission process, as implemented by 
  `submit_cran()` (#430).

## Tool templates and `create()`

* `create()` no longer generates `man/` directory - roxygen2 now does
  this automatically. It also no longer generates an package-level doc
  template, instead call `use_package_doc()`.

* New `use_data()` makes it easy to include data in a package, either 
  in `data/` (for exported datasets) or in `R/sysdata.rda` (for internal
  data). (#542)
  
* New `use_data_raw()` to create `data-raw/` directory for reproducible
  generation of `data/` files (#541).

* New `use_rcpp()` sets up a package to use Rcpp.

* New `use_knitr()` sets up a package to use knitr for vignettes.

* New `use_package_doc()` sets up an Roxygen template for package-level
  docs.

* New function `install_svn()` to install an R package from a subversion
  repository.

* Wrote own version of `write.dcf()` that doesn't butcher whitespace and 
  fieldnames.

* renamed `add_rstudio_project()` to `use_rstudio()`, `add_travis()` to 
  `use_travis()`, `add_build_ignore()` to `use_build_ignore()`, and 
  `add_test_infrastructure()` to `use_testthat()` (old functions are 
  aliased to new)
  
* `use_travis()` now figures out what your github username and repo are so
  it can construct the markdown build image for you. (#546)

* `create()` now makes a dummy namespace so that you can build & reload
  without running `document()` first.

## Package installation

* All `install_*` now use the same code and store much useful metadata.
  Currently only `session_info()` takes advantage of this information,
  but it will allow the development of future tools like generic update
  functions.
  
* `install_bitbucket()` has been bought into alignment with `install_github()`:
  this means you can now specify repos with the compact `username/repo@ref`
  syntax. The `username` is now deprecated. 
  
* `install_github()` gains new `host` argument which allows you to install
  packages from github enterprise (#410, #506). 
  
* `install_github()` uses GitHub API to download archive file (@krlmlr, #466).

* `install_github()` now supports the new syntax `ref = github_pull(...)` to
  install a specific pull request. The parameter `pull` is now deprecated,
  neither `pull` nor `branch` are included in the formal parameters
  (@krlmlr, #509).

* The `username` paramter of `install_github()` is deprecated - please include
  in the repo name: `rstudio/shiny`, `hadley/devtools` etc. Deprecated 
  parameters `auth_user`, `branch`, `pull` and `password` have all been 
  removed.
  
* `install_git()` has been simplified and many of the arguments have changed 
  names for consistency with metadata for other package installs.

* `install_gitorious()` has been bought into alignment with `install_github()`:
  this means you can now specify repos with the compact `username/repo@ref`
  syntax. You must now always supply user (project) name and repo.

* `install_svn()` now only downloads the branch that you need, rather than
  the complete repo.

## Other minor improvements and bug fixes

* `build(binary = TRUE)` creates an even-more-temporary package library
  avoid conflicts (#557).

* New `session_info()` provides useful information about your R session.
  It's a little more focussed than `sessionInfo()` and includes where
  packages where installed from (#526).

* `load_all()` no longer gives an error when objects listed as exports are
  missing.
  
* `check_dir()` no longer fails on UNC paths (#522).

* `check_devtools()` also checks for dependencies on development versions
  of packages (#534).

* If you're using Rstudio, and you you're trying to build a binary package
  without the necessary build tools, Rstudio will prompt to download and
  install the right thing. (#488)

* devtools no longer runs commands with `LC_ALL=C` - this no longer seems
  to be necessary (#507).

* `help()`, `?`, and `system.file()` are now made available when a package is
  loaded with `load_all()`, even if the devtools package isn't attached.

* `dependencies = TRUE` is not forced anymore in `install_github()` (regression
  in 1.5) (@krlmlr, #462).

* `loaded_packages()` now returns package name and path it was loaded from. 
  (#486)

* `rstudioapi` package moved from suggests to imports, since it's always 
  needed (it's job is to figure out if rstudio is available, #458)

* `httr` 0.3 required (@krlmlr, #466).

* Implemented own version `utils::unzip()` that throws error if command
  fails and doesn't print unneeded messages on non-Windows platforms (#540).

* The `parenvs()` function has been removed from devtools, because is now in the
  pryr package.

# devtools 1.5

Four new functions make it easier to add useful infrastructure to packages:

* `add_test_infrastructure()` will create test infrastructure for a new package.
  It is called automatically from `test()` if no test directories are
  found, the session is interactive and you agree.

* `add_rstudio_project()` adds an Rstudio project file to your package.
  `create()` gains an `rstudio` argument which will automatically create
  an Rstudio project in the package directory. It defaults to `TRUE`:
  if you don't use Rstudio, just delete the file.

* `add_travis()` adds a basic travis template to your package. `.travis.yml`
  is automatically added to `.Rbuildignore` to avoid including it in the built
  package.

* `add_build_ignore()` makes it easy to add files to `.Rbuildignore`,
  correctly escaping special characters

Two dependencies were incremented:

* devtools requires at least R version 3.0.2.

* `document()` requires at least roxygen2 version 3.0.0.

## Minor improvements

* `build_win()` now builds R-release and R-devel by default (@krlmlr, #438).
  It also gains parameter `args`, which is passed on to `build()`
  (@krlmlr, #421).

* `check_doc()` now runs `document()` automatically.

* `install()` gains `thread` argument which allows you to install multiple
  packages in parallel (@mllg, #401). `threads` argument to `check_cran()`
  now defaults to `getOption("Ncpus")`

* `install_deps(deps = T)` no longer installs all dependencies of
  dependencies (#369).

* `install_github()` now prefers personal access tokens supplied to
  `auth_token` rather than passwords (#418, @jeroenooms).

* `install_github()` now defaults to `dependencies = TRUE` so you definitely
  get all the packages you need to build from source.

* devtools supplies its own version of `system.file()` so that when the function
  is called from the R console, it will have special behavior for packages
  loaded with devtools.

* devtools supplies its own version of `help` and `?`, which will search
  devtools-loaded packages as well as normally-loaded packages.

## Bug fixes

* `check_devtools()` no longer called by `check()` because the relevant
  functionality is now included in `R CMD CHECK` and it was causing
  false positives (#446).

* `install_deps(TRUE)` now includes packages listed in `VignetteBuilder` (#396)

* `build()` no longer checks for `pdflatex` when building vignettes, as
  many modern vignettes don't need it (#398). It also uses
  `--no-build-vignettes` for >3.0.0 compatibility (#391).

* `release()` does a better job of opening your email client if you're inside
  of Rstudio (#433).

* `check()` now correctly reports the location of the `R CMD
  check` output when called with a custom `check_dir`. (Thanks to @brentonk)

* `check_cran()` records check times for each package tested.

* Improved default `DESCRIPTION` file created by `create_description()`.
  (Thanks to @ncarchedi, #428)

* Fixed bug in `install_github()` that prevented installing a pull request by
  supplying `repo = "username/repo#pull"`. (#388)

* explicitly specify user agent when querying user name and ref for pull request
  in `install_github`. (Thanks to Kirill Müller, #405)

* `install_github()` now removes blank lines found in a package `DESCRIPTION`
  file, protecting users from the vague `error: contains a blank line` error.
  (#394)

* `with_options()` now works, instead of throwing an error (Thanks to
  @krlmlr, #434)

# devtools 1.4.1

* Fixed bug in `wd()` when `path` was ommitted. (#374)

* Fixed bug in `dev_help()` that prevented it from working when not using
  Rstudio.

* `source_gist()` respects new github policy by sending user agent
  (hadley/devtools)

* `install_github()` now takes repo names of the form
  `[username/]repo[/subdir][@ref|#pull]` -
  this is now the recommended form to specify username, subdir, ref and/or
  pull for install_github. (Thanks to Kirill Müller, #376)

# devtools 1.4

## Installation improvements

* `install()` now respects the global option `keep.source.pkgs`.

* `install()` gains a `build_vignettes` which defaults to TRUE, and ensures
  that vignettes are built even when doing a local install. It does this
  by forcing `local = FALSE` if the package has vignettes, so `R CMD build`
  can follow the usual process. (#344)

* `install_github()` now takes repo names of the form `username/repo` -
  this is now the recommended form for install_github if your username is
  not hadley ;)

* `install_github()` now adds details on the source of the installed package
  (e.g. repository, SHA1, etc.) to the package DESCRIPTION file. (Thanks to JJ
  Allaire)

* Adjusted `install_version()` to new meta data structure on CRAN.
  (Thanks to Kornelius Rohmeyer)

* Fixed bug so that `install_version()` works with version numbers that
  contain hyphens. (Thanks to Kornelius Rohmeyer)

* `install_deps()` is now exported, making it easier to install the dependencies
  of a package.

## Other minor improvements

* `build(binary = TRUE)` now no longer installs the package as a side-effect.
  (#335)

* `build_github_devtools()` is a new function which makes it easy for Windows
  users to upgrade to the development version of devtools.

* `create_description()` does a better job of combining defaults and user
  specified options. (#332)

* `install()` also installs the dependencies that do not have the required
  versions; besides, the argument `dependencies` now works like
  `install.packages()` (in previous versions, it was essentially
  `c("Depends", "Imports", "LinkingTo")`) (thanks, Yihui Xie, #355)

* `check()` and `check_cran()` gain new `check_dir` argument to control where
  checking takes place (#337)

* `check_devtools()` no longer incorrectly complains about a `vignettes/`
  directory

* Decompression of zip files now respects `getOption("unzip")` (#326)

* `dev_help` will now use the Rstudio help pane, if you're using a recent
  version of Rstudio (#322)

* Release is now a little bit smarter: if it's a new package, it'll ask you
  to read and agree to the CRAN policies; it will only ask about
  dependencies if it has any.

* `source_url()` (and `source_gist()`) accept SHA1 prefixes.

* `source_gist()` uses the github api to reliably locate the raw gist.
  Additionally it now only attempts to source files with `.R` or `.r`
  extensions, and gains a `quiet` argument. (#348)

* Safer installation of source packages, which were previously extracted
  directly into the temp directory; this could be a problem if directory
  names collide. Instead, source packages are now extracted into unique
  subdirectories.


# devtools 1.3

## Changes to best practices

* The documentation for many devtools functions has been considerably expanded,
  aiming to give the novice package developer more hints about what they should
  be doing and why.

* `load_all()` now defaults to `reset = TRUE` so that changes to the NAMESPACE
  etc are incorporated. This makes it slightly slower (but hopefully not
  noticeably so), and generally more accurate, and a better simulation of
  the install + restart + reload cycle.

* `test()` now looks in both `inst/test` and `tests/testthat` for unit tests.
  It is recommended to use `tests/testthat` because it allows users to
  choose whether or not to install test. If you move your tests from
  `inst/tests` to `tests/testthat`, you'll also need to change
  `tests/test-all.R` to run `test_check()` instead of `test_package()`.
  This change requires testthat 0.8 which will be available on CRAN shortly.

* New devtools guarantee: if because of a devtools bug, a CRAN maintainer yells
  at you, I'll send you a hand-written apology note. Just forward me the email
  and your address.

## New features

* New `install_local()` function for installing local package files
 (as zip, tar, tgz, etc.) (Suggested by landroni)

* `parse_deps()`, which parses R's package dependency strings, is now exported.

* All package and user events (e.g. load, unload, attach and detach) are now
  called in the correct place.

## Minor improvements and bug fixes

* `build()` gains `args` parameter allowing you to add additional arbitrary
  arguments, and `check()` gains similar `build_args` parameter.

* `install_git` gains `git_arg` parameter allowing you to add arbitrary
  additional arguments.

* Files are now loaded in a way that preserves srcreferences - this means
  that you will get much better locations on error messages, which should
  considerably aid debugging.

* Fixed bug in `build_vignettes()` which prevented files in `inst/doc` from
  being updated

* `as.package()` no longer uses the full path, which should make for nicer
  error messages.

* More flexibility when installing package dependencies with the
 `dependencies` argument to `install_*()` (thanks to Martin Studer)

* The deprecated `show_rd()` function has now been removed.

* `install_bitbucket()` gains `auth_user` and `password` params so that you can
  install from private repos (thanks to Brian Bolt)

* Better git detection on windows (thanks to Mikhail Titov)

* Fix bug so that `document()` will automatically create `man/` directory

* Default `DESCRIPTION` gains `LazyData: true`

* `create_description()` now checks that the directory is probably a package
  by looking for `R/`, `data/` or `src/` directories

* Rolled back required R version from 3.0 to 2.15.

* Add missing import for `digest()`

* Bump max compatible version of R with RTools 3.0, and add details for
  RTools 3.1

# devtools 1.2

## Better installation

* `install` gains a `local` option for installing the package from the local
  package directory, rather than from a built tar.gz.  This is now used by
  default for all package installations. If you want to guarantee a clean
  build, run `local = FALSE`

* `install` now uses option `devtools.install.args` for default installation
  arguments. This allows you to set any useful defaults (e.g. `--no-multiarch`)
  in your Rprofile.

* `install_git` gains `branch` argument to specify branch or tag (Fixes #255)

## Clean sessions

* `run_examples` and `test` gain a `fresh` argument which forces them to run
  in a fresh R session. This completely insulates the examples/tests from your
  current session but means that interactive code (like `browser()`) won't work.(Fixes #258)

* New functions `eval_clean` and `evalq_clean` make it easy to evaluate code
  in a clean R session.

* `clean_source` loses the `vanilla` argument (which did not work) and gains
  a `quiet` argument

## New features

* `source_url` and `source_gist` now allow you to specify a sha, so you can
  make sure that files you source from the internet don't change without you
  knowing about it. (Fixes #259)

* `build_vignettes` builds using `buildVignette()` and movies/copies outputs
  using the same algorithm as `R CMD build`. This means that
  `build_vignettes()` now exactly mimics R's regular behaviour, including
  building non-Sweave vignettes (#277), building in the correct directory
  (#231), using make files (if present), and copying over extra files.

* devtools now sets best practice compiler flags: from `check()`,
  `-Wall -pedantic` and from `load_all()`, `-Wall -pedantic -g -O0 -UNDEBUG`.
  These are prefixed to existing environment variables so that you can override
  them if desired. (Fixes #257)

* If there's no `DESCRIPTION` file present, `load_all()` will automatically
  create one using `create_description()`.  You can set options in your
  `.Rprofile` to control what it contains: see `package?devtools` for more
  details.

## Minor improvements

* `check()` now also sets environment variable
  `_R_CHECK_CODE_DATA_INTO_GLOBALENV_` to TRUE (to match current `--as-cran`
  behaviour) (Fixes #256)

* Improved default email sent by `release()`, eliminating `create.post()`
  boilerplate

* `revdep` includes LinkingTo by default.

* Fixed regular expression problem that caused RTools `3.0.*` to fail to be
  found on Windows.

* `load_data()` got an overhaul and now respects `LazyData` and correctly
  exports datasets by default (Fixes #242)

* `with_envvar` gains the option to either replace, prefix or suffix existing
  environmental variables. The default is to replace, which was the previous
  behaviour.

* `check_cran` includes `sessionInfo()` in the summary output (Fixes #273)

* `create()` gains a `check` argument which defaults to FALSE.

* `with_env` will be deprecated in 1.2 and removed in 1.3

* When `load_all()` calls `.onAttach()` and `.onLoad()`, it now passes the
  lib path to those functions.

# devtools 1.1

* `source_gist()` has been updated to accept new gist URLs with username.
  (Fixes #247)

* `test()` and `document()` now set environment variables, including NOT_CRAN.

* Test packages have been renamed to avoid conflicts with existing packages on
  CRAN. This bug prevented devtools 1.0 from passing check on CRAN for some
  platforms.

* Catch additional case in `find_rtools()`: previously installed, but directory
  empty/deleted (Fixes #241)

# devtools 1.0

## Improvements to package loading

* Rcpp attributes are now automatically compiled during build.

* Packages listed in depends are `require()`d (Fixes #161, #178, #192)

* `load_all` inserts a special version of `system.file` into the package's
  imports environment. This tries to simulate the behavior of
  `base::system.file` but gives modified results because the directory structure
  of installed packages and uninstalled source packages is different.
  (Fixes #179). In other words, `system.file` should now just work even if the
  package is loaded with devtools.

* Source files are only recompiled if they've changed since the last run, and
  the recompile will be clean (`--preclean`) if any exported header files have
  changed. (Closes #224)

* The compilation process now performs a mock install instead of using
  `R CMD SHLIB`. This means that `Makevars` and makefiles will now be respected
  and generally there should be fewer mismatches between `load_all` and
  the regular install and reload process.

* S4 classes are correctly loaded and unloaded.

## Windows

* Rtools detection on windows has been substantially overhauled and should both
  be more reliable, and when it fails give more information about what is wrong
  with your install.

* If you don't have rtools installed, devtools now automatically sets the TAR
  environment variable to internal so you can still build packages.

## Minor features

* `check_cran` now downloads packages from cran.rstudio.com.

* `check()` now makes the CRAN version check optional, and off by default. The
  `release()` function still checks the version number against CRAN.

* In `check()`, it is optional to require suggested packages, using the
  `force_suggests` option.

* When `check()` is called, the new default behavior is to not delete existing
  .Rd files from man/. This behavior can be set with the "devtools.cleandoc"
  option.

* `install_bitbucket()` now always uses lowercase repo names. (Thanks to mnel)

* New function `with_lib()`, which runs an expression code with a library path
  prepended to the existing libpaths. It differs slightly from
  `with_libpaths()`, which replaces the existing libpaths.

* New function `install_git()` installs a package directly from a git
  repository. (Thanks to David Coallier)

* If `pdflatex` isn't available, don't try to build vignettes with `install()`
  or `check()`. (Fixes #173)

* `install_github()` now downloads from a new URL, to reflect changes on how
  files are hosted on GitHub.

* `build()` now has a `vignettes` option to turn off rebuilding vignettes.

* `install(quick=TRUE)` now builds the package without rebuilding vignettes.
  (Fixes #167)

* All R commands called from `devtools` now have the environment variable
  `NOT_CRAN` set, so that you can perform tasks when you know your code
  is definitely not running on CRAN. (Closes #227)

* Most devtools functions can a quiet argument that suppresses output. This is
  particularly useful for testing.

## Bug fixes

* Fixed path issue when looking for Rtools on windows when registry entry is not present. (Fixes #201)

* Reloading a package that requires a forced-unload of the namespace now works.

* When reloading a package that another loaded package depends on, if there
  was an error loading the code, devtools would print out something about an
  error in `unloadNamespace`, which was confusing. It now gives more useful
  errors.

* An intermittent error in `clear_topic_index` related to using `rm()` has
  been fixed. (Thanks to Gregory Jefferis)

* `revdep()` now lists "Suggests" packages, in addition to "Depends" and
  "Imports".

* `revdep_check()` now correctly passes the `recursive` argument to `revdep()`.

* The collection of check results at the end of `check_cran()` previously did
  not remove existing results, but now it does.

* When a package is loaded with `load_all()`, it now passes the name of the
  package to the `.onLoad()` function. (Thanks to Andrew Redd)

# devtools 0.8.0

## New features

* `create` function makes it easier to create a package skeleton using
  devtools standards.

* `install_github()` can now install from a pull request -- it installs
  the branch referenced in the pull request.

* `install_github` now accepts `auth_user` and `password` arguments if you
  want to install a package in a private github repo. You only need to specify
  `auth_user` if it's not your package (i.e. it's not your `username`)
  (Fixes #116)

* new `dev_help` function replaces `show_rd` and makes it easy to get help on
  any topic in a development package (i.e. a package loaded with `load_all`)
  (Fixes #110)

* `dev_example` runs the examples for one in-development package. (Fixes #108)

* `build_vignettes` now looks in modern location for vignettes (`vignettes/`)
   and warn if vignettes found in old location (`inst/doc`).  Building now
   occurs in a temporary directory (to avoid polluting the package with
   build artefacts) and only final pdf files are copied over.

* new `clean_vignettes` function to remove pdfs in `inst/doc` that were built
  from vignettes in `vignettes/`

* `load_all` does a much much better job at simulating package loading (see
  LOADING section). It also compiles and loads C/C++/Fortran code.

* `unload()` is now an exported function, which unloads a package, trying
  harder than just `detach`. It now also unloads DLLs. (Winston Chang.
  Fixes #119)

* `run_examples` now has parameters `show`, `test`, `run` to control which of
  `\dontrun{}`, `\dontshow{}`, `\donttest{}` and `\testonly{}` are commented
  out. The `strict` parameter has been removed since it is no longer necessary
  because `load_all` can respect namespaces. (Fixes #118)

* `build()`, `check()`, `install()` etc now run R in `--vanilla` mode which
  prevents it from reading any of your site or personal configuration files.
  This should prevent inconsistencies between the environment in which the
  package is run between your computer and other computers (e.g. the CRAN
  server) (Fixes #145)

* All system R command now print the full command used to make it easier to
  understand what's going on.

## Package paths

* `as.package` no longer uses `~/.Rpackages`.

* `as.package` provides more informative error messages when path does not
  exist, isn't a directory, or doesn't contain a `DESCRIPTION` file.

* New function `inst()` takes the name of a package and returns the installed
  path of that package. (Winston Chang. Fixes #130). This makes it possible to
  use `devtools` functions (e.g. `unload`) with regular installed packages,
  not just in-development source packages.

* New function `devtest()` returns paths to an internal testing packages
  in devtools.

## Loading

* Development packages are now loaded into a namespace environment,
  <namespace:xxxx>, and then the objects namespace are copied to the
  package environment, <package:xxxx>. This more accurately simulates
  how packages are normally loaded. However, all of the objects (not
  just the exported ones) are still copied to the package environment.
  (Winston Chang. Fixes #3, #60, and #125)

* Packages listed in Imports and Depends are now loaded into an imports
  environment, with name attribute "imports:xxxx", which is the parent
  of the namespace environment. The imports environment is in turn a
  child of the <namespace:base> environment, which is a child of the
  global environment. This more accurately simulates how packages are
  normally loaded.  These packages previously were loaded and attached.
  (Winston Chang. Fixes #85)

* The NAMESPACE file is now used for loading imports, instead of the
  DESCRIPTION file. Previously, `load_all` loaded all objects from the
  packages listed in DESCRIPTION. Now it loads packages (and, when
  when 'importfrom' is used, specific objects from packages) listed in
  NAMESPACE. This more closely simulates normal package loading. It
  still checks version numbers of packages listed in DESCRIPTION.
  (Winston Chang)

* `load_all` can now be used to properly reload devtools. It does this
  by creating a copy of the devtools namespace environment, and calling
  `load_all` from that environment. (Winston Chang)

* The `.onLoad` and `.onAttach` functions for a development package are
  now both called when loading a package for the first time, or with
  `reset=TRUE`, and the order more correctly simulates normal package
  loading (create the namespace, call `.onLoad`, copy objects to the
  package environment, and then call `.onAttach`). (Winston Chang)

* `load_all` will now throw a warning if a dependency package does not
  satisfy the version requirement listed in DESCRIPTION. (Winston Chang.
  Fixes #109)

* The package environment now has a 'path' attribute, similar to a
  package loaded the normal way. (Winston Chang)

* `load_all` now has an option `export_all`. When set to TRUE, only the
  objects listed as exports in NAMESPACE are exported. (Winston Chang)

* `load_all` now compiles C files in the /src directory. (Winston Chang)

* New functions `compile_dll()` and `clean_dll()`, which compile C/C++/
  Fortan source code, and clean up the compiled objects, respectively.
  (Winston Chang. Fixes #131)

## Bug fixes

* `load_code` now properly skips missing files. (Winston Chang)

* Add `--no-resave-data` to default build command.

* The subject line of the email created by `release` is now "CRAN submission
  [package] [version]", per CRAN repository policy.

* `install_bitbucket` properly installs zip files of projects stored
  in Mercurial repositories. (Winston Chang. Fixes #148)

* `build` now builds vignettes because `install` does not. (Fixes #155)

## Introspection

* New function `loaded_packages()`, which returns the names of packages
  that are loaded and attached.

* Packages loaded with `load_all` now store devtools metadata in their
  namespace environment, in a variable called `.__DEVTOOLS__`. This can
  be accessed with the `dev_meta` function. (Winston Chang. Fixes #128)

* `dev_mode` now stores the path it uses in option `dev_path`. That makes it
  easy for other applications to detect when it is on and to act accordingly.

* New function `parse_ns_file()`, which parses a NAMESPACE file for a
  package.

* New function `parenvs()`, which parents the parent environments
  of an object. (Winston Chang)

# devtools 0.7.1

* bump dependency to R 2.15

* `load_code` now also looks for files ending in `.q` - this is not
  recommended, but is needed for some older packages

# devtools 0.7

## Installation

* `install_bitbucket` installs R packages on bitbucket.

* `install` now uses `--with-keep.source` to make debugging a little easier.

* All remote install functions give better error messages in the case of http
  errors (Fixes #82).

* `install` has new quick option to make package installation faster, by
  sacrificing documentation, demos and multi-architecture binaries.
  (Fixes #77)

* `install_url`, `install_github` and `install_gitorious` gain a subdir
  argument which makes it possible to install packages that are contained
  within a sub-directory of a repository or compressed file. (Fixes #64)

## Checking

* `with_debug` function temporarily sets env vars so that compilation is
  performed with the appropriate debugging flags set. Contributed by Andrew
  Redd.

* `revdep`, `revdep_maintainers` and `revdep_check` for calculating reverse
  dependencies, finding their maintainers and running `R CMD check`.
  (Fixes #78)

* `check_cran` has received a massive overhaul: it now checks multiple
  packages, installs dependencies (in user specified library), and parse check
  output to extract errors and warnings

* `check` uses new `--as-cran` option to make checking as close to CRAN as
  possible (fixes #68)

## Other new features

* devtools now uses options `devtools.path` to set the default path to use
  with devmode, and `github.user` to set the default user when installing
  packages from github.

* if no package supplied, and no package has been worked with previously, all
  functions now will try the working directory. (Fixes #87)

* on windows, devtools now looks in the registry to find where Rtools is
  installed, and does a better a job of locating gcc. (Contributed by Andrew
  Redd)

* `show_rd` passes `...` on to `Rd2txt` - this is useful if you're checking
  how build time `\Sexpr`s are generated.

* A suite of `with` functions that allow you to temporarily alter the
  environment in which code is run: `in_dir`, `with_collate`, `with_locale`,
  `with_options`, `with_path`, ... (Fixes #89)

* `release` ask more questions and randomises correct answers so you really
  need to read them (Fixes #79)

* `source_gist` now accepts default url such as "https://gist.github.com/nnn"

* New system path manipulation functions, `get_path`, `set_path`, `add_path`
  and `on_path`, contributed by Andrew Redd.

* If you're on windows, `devtools` now suppresses the unimportant warning from
  CYGWIN about the dos style file paths

## Bug fixes

* `decompress` now uses target directory as defined in the function call
  when expanding a compressed file. (Fixes #84)

* `document` is always run in a C locale so that `NAMESPACE` sort order is
  consistent across platforms.

* `install` now quotes `libpath` and build path so paths with embedded spaces
  work (Fixes #73 and #76)

* `load_data` now also loads `.RData` files (Fixes #81)

* `install` now has `args` argument to pass additional command line arguments
  on to `R CMD install` (replaces `...` which didn't actually do anything).
  (Fixes #69)

* `load_code` does a better job of reconciling files in DESCRIPTION collate
  with files that actually exist in the R directory. (Fixes #14)

# devtools 0.6

## New features

* `test` function takes `filter` argument which allows you to restrict which
  tests are to be run

* `check` runs with example timings, as is done on CRAN. Run with new param
  `cleanup = F` to access the timings.

* `missing_s3` function to help figure out if you've forgotten to export any
  s3 methods

* `check_cran` downloads and checks a CRAN package - this is useful to run as
  part of the testing process of your package if you want to check the
  dependencies of your package

* `strict` mode for `run_examples` which runs each example in a clean
  environment. This is much slower than the default (running in the current
  environment), but ensures that each example works standalone.

* `dev_mode` now updates prompt to indicate that it's active (Thanks to Kohske
  Takahashi)

* new `source_url` function for sourcing script on a remote server via
  protocols other than http (e.g. https or ftp). (Thanks to Kohske Takahashi)

* new `source_gist` function to source R code stored in a github gist. (Thanks
  to Kohske Takahashi)

* `load_all` now also loads all package dependencies (including suggestions) -
  this works around some bugs in the way that devtools attaches the
  development environment into the search path in a way that fails to recreate
  what happens normally during package loading.

## Installation

* remote installation will ensure the configure file is executable.

* all external package installation functions are vectorised so you can
  install multiple packages at time

* new `install_gitorious` function install packages in gitorious repos.

* new `install_url` function for installing package from an arbitrary url

* include `install_version` function from Jeremy Stephens for installing a
  specific version of a CRAN package from the archive.

## Better windows behaviour

* better check for OS type (thanks to Brian Ripley)

* better default paths for 64-bit R on windows (Fixes #35)

* check to see if Rtools is already available before trying to mess with the
  paths. (Fixes #55)

## Bug fixes

* if an error occurs when calling loading R files, the cache will be
  automatically cleared so that all files are loaded again next time you try
  (Fixes #55)

* functions that run R now do so with `R_LIBS` set to the current
  `.libPaths()` - this will ensure that checking uses the development library
  if you are in development mode. `R_ENVIRON_USER` is set to an empty file to
  avoid your existing settings overriding this.

* `load_data` (called by `load_all`) will also load data defined in R files in
  the data directory. (Fixes #45)

* `dev_mode` performs some basic tests to make sure you're not setting your
  development library to a directory that's not already an R library.
  (Fixes #25)

# devtools 0.5.1

* Fix error in that was causing R commands to fail on windows.

# devtools 0.5

## New functions

* new `show_rd` function that will show the development version of a help
  file.

## Improvements and bug fixes

* external R commands always run in locale `C`, because that's what the CRAN
  severs do.

* `clean_source` sources an R script into a fresh R environment, ensuring that
  it can run independently of your current working environment. Optionally
  (`vanilla = T`), it will source in a vanilla R environment which ignores all
  local environment settings.

* On windows, `devtools` will also add the path to `mingw` on startup. (Thanks
  to pointer from Dave Lovell)

# devtools 0.4

## New functions

* new `wd` function to change the working directory to a package subdirectory.

* `check_doc` now checks package documentation as a whole, in the same way
  that `R CMD check` does, rather than low-level syntax checking, which is
  done by `roxygen2. DESCRIPTION checking has been moved into `load_all`.
  `check_rd` has been removed.

* `build` is now exported, and defaults to building in the package's parent
  directory. It also gains a new `binary` parameter controls whether a binary
  or a source version (with no vignettes or manuals) is built. Confusingly,
  binary packages are built with `R CMD INSTALL`.

* `build_win` sends your package to the R windows builder, allowing you to
  make a binary version of your package for windows users if you're using
  linux or a max (if you're using windows already, use `build(binary = T)`)

## Improvements and bug fixes

* if using `.Rpackages` config file, default function is used last, not first.

* on Windows, `devtools` now checks for the presence of `Rtools` on startup,
  and will automatically add it to the path if needed.

* `document` uses `roxygen2` instead of `roxygen`. It now loads package
  dependency so that they're available when roxygen executes the package
  source code.

* `document` has new parameter `clean` which clears all roxygen caches and
  removes all existing man files. `check` now runs `document` in this mode.

* `dev_mode` will create directories recursively, and complain if it can't
  create them.  It should also work better on windows.

* `install_github` now allows you to specify which branch to download, and
  automatically reloads package if needed.

* `reload` now will only reload if the package is already loaded.

* `release` gains `check` parameter that allows you to skip package check (if
  you've just done it.)

* `test` automatically reloads code so you never run tests on old code

# devtools 0.3

* new `bash()` function that starts bash shell in package directory. Useful if
  you want to use git etc.

* removed inelegant `update_src()` since now superseded by `bash()`

* fix bug in ftp upload that was adding extraneous space

* `build` function builds package in specified directory. `install`, `check`
  and `release` now all use this function.

* `build`, `install`, `check` and `release` better about cleaning up after
  themselves - always try to both work in session temporary directory and
  delete any files/directories that they create

# devtools 0.2

* `install_github` now uses `RCurl` instead of external `wget` to retrieve
  package. This should make it more robust wrt external dependencies.

* `load_all` will skip missing files with a warning (thanks to suggestion from Jeff Laake)

* `check` automatically deletes `.Rcheck` directory on successful completion

* Quote the path to R so it works even if there are spaces in the path.

# devtools 0.1

* Check for presence of `DESCRIPTION` when loading packages to avoid false
  positives

* `install` now works correctly with `devel_mode` to install packages in your
  development library

* `release` prints news so you can more easily check it

* All `R CMD xxx` functions now use the current R, not the first R found on
  the system path.
