\name{install}
\alias{install}
\alias{install_debug}
\title{Install a local development package.}
\usage{
  install(pkg = NULL, reload = TRUE, quick = FALSE,
    args = NULL)

  install_debug(pkg = NULL, reload = TRUE, quick = FALSE,
    args = NULL,
    PKG_CFLAGS = "-UNDEBUG -Wall -pedanitc -g -O0",
    PKG_CXXFLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
    PKG_FFLAGS = "-g -O0", PKG_FCFLAGS = "-g -O0")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{reload}{if \code{TRUE} (the default), will
  automatically reload the package after installing.}

  \item{quick}{if \code{TRUE} skips docs,
  multiple-architectures, and demos to make installation as
  fast as possible.}

  \item{args}{An optional character vector of additional
  command line arguments to be passed to \code{R CMD
  install}.}

  \item{PKG_CFLAGS}{The flags should be set to for
  compiling c code}

  \item{PKG_CXXFLAGS}{The flags for compiling c++ code}

  \item{PKG_FFLAGS}{The flags for compiling Fortran code.}

  \item{PKG_FCFLAGS}{The flags for Fortrans 9x code.}
}
\description{
  Uses \code{R CMD INSTALL} to install the package. Will
  also try to install dependencies of the package from
  CRAN, if they're not already installed.

  \code{install_debug} will install the package with
  debugging compilation flags set.
  \code{PKG_CXXFLAGS="-Wall -pedantic -g -O0"}
}
\details{
  Installation takes place on a copy of the package
  produced by \code{R CMD build} to avoid modifying the
  local directory in any way.
}
\seealso{
  Writing R Exentsions Manual.

  Other package installation: \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

