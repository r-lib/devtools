\name{run_onload}
\alias{run_onload}
\title{Run .onLoad if needed}
\usage{
  run_onload(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  This is run before copying objects from the namespace to
  the package environment. In a normal install + load, the
  namespace would be locked between these stages, but we
  don't do that with load_all.
}
\details{
  A variable called \code{onLoad} is created in the
  package's devtools metdata to indicate that it's
  attached.

  When a package is loaded with \code{library()} it calls
  \code{.onLoad(libpath, pkg)}, where \code{libpath} is the
  library path for package, and \code{pkg} is the name of
  the package. Because in-development packages are not
  installed to a library, this function can't call
  \code{.onLoad} with a proper libpath, so it uses
  \code{NULL} instead.
}

