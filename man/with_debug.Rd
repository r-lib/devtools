\name{with_debug}
\alias{with_debug}
\title{Temporarily set debugging compilation flags.}
\usage{
  with_debug(code,
    PKG_CFLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
    PKG_CXXFLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
    PKG_FFLAGS = "-g -O0", PKG_FCFLAGS = "-g -O0")
}
\arguments{
  \item{code}{to execute.}

  \item{PKG_CFLAGS}{flags for compiling C code}

  \item{PKG_CXXFLAGS}{flags for compiling C++ code}

  \item{PKG_FFLAGS}{flags for compiling Fortran code.}

  \item{PKG_FCFLAGS}{flags for Fortran 9x code.}
}
\description{
  Temporarily set debugging compilation flags.
}
\examples{
\dontrun{
install("mypkg")
with_debug(install("mypkg"))
}
}

