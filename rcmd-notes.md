* checking dependencies in R code ... NOTE
  Missing or unexported object: ‘roxygen2::clear_caches’
  See the information on DESCRIPTION files in the chapter ‘Creating R
  packages’ of the ‘Writing R Extensions’ manual.

  checking R code for possible problems ... NOTE
  document_roxygen2: no visible binding for global variable ‘parse.file’

  Or similar: devtools now conditionally supports two versions of roxygen2, 
  so some functions aren't found and some arguments don't match

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File ‘devtools/R/package-env.r’:
    attach(NULL, name = pkg_env_name(pkg))

  This is needed because devtools simulated package loading, and hence
  needs to attach environments to the search path.

* There are ::: calls to the package's namespace in its code. A package
  almost never needs to use ::: for its own objects:  ‘run_example’

  This is needed because that function actually generates an external
  file that is run in a fresh R session.

