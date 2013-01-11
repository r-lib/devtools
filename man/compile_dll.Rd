\name{compile_dll}
\alias{compile_dll}
\title{Compile a .dll/.so from source}
\usage{
  compile_dll(pkg = ".", quiet = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{quiet}{if \code{TRUE} suppresses output from this
  function.}
}
\description{
  Support for compiling C, C++, and Fotran code is
  experimental, and will probably only work for simple
  cases where the code is to be compiled into a single DLL.
  It will work with Makevars files, but not with Makefiles.
}
\details{
  \code{compile_dll} will compile \code{.c}, \code{.cpp},
  and \code{.f} files, and save the resulting DLL file in
  the same directory as the source code, \code{/src/}.
  Depending on the platform, the DLL file will have the
  extension \code{.dll} or \code{.so}.

  Invisibly returns the names of the DLL.
}
\note{
  If this is used to compile code that uses Rcpp, you will
  need to add the following line to your \code{Makevars}
  file so that it knows where to find the Rcpp headers:
  \code{PKG_CPPFLAGS=`$(R_HOME)/bin/Rscript -e
  'Rcpp:::CxxFlags()'`}
}
\seealso{
  \code{\link{clean_dll}} to delete the compiled files.
}

