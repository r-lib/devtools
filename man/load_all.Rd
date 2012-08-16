\name{load_all}
\alias{load_all}
\title{Load complete package.}
\usage{
  load_all(pkg = NULL, reset = FALSE, recompile = FALSE,
    self = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{reset}{clear package environment and reset file
  cache before loading any pieces of the package.}

  \item{recompile}{force a recompile of DLL from source
  code, if present.}

  \item{self}{For internal use only. (This is used when
  \code{load_all} is called from
  \code{\link{reload_devtools}})}
}
\description{
  \code{load_all} loads a package. It roughly simulates
  what happens when a package is installed and loaded with
  \code{\link{library}}.
}
\details{
  To unload and reload a package, use \code{reset=TRUE}.
  When reloading a package, A, that another package, B,
  depends on, \code{load_all} might not be able to cleanly
  unload and reload A. If this causes problems, try using
  unloading package B with \code{\link{unload}} before
  using \code{load_all} on A.

  Support for packages with compiled C/C++/Fortran code in
  the \code{/src/} directory is experimental. See
  \code{\link{compile_dll}} for more information about
  compiling code.
}
\keyword{programming}

