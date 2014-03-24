* checking package dependencies ... NOTE

  Note about rstudio package included in DESCRIPTION.

* checking R code for possible problems ... NOTE
  Found the following calls to attach():
    File ‘devtools/R/package-env.r’:
    attach(NULL, name = pkg_env_name(pkg))

  This is needed because devtools simulates package loading, and hence
  needs to attach environments to the search path.

* There are ::: calls to the package's namespace in its code. A package
  almost never needs to use ::: for its own objects.

  This is needed because that function actually generates an external
  file that is run in a fresh R session.

