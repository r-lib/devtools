\name{compile_dll}
\alias{compile_dll}
\title{Compile a .dll/.so from source}
\usage{
  compile_dll(pkg)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  The DLL is stored in the same directory as the source
  code, \code{/src/}.
}
\details{
  Invisibly returns the names of the DLL.
}
\seealso{
  \code{\link{clean_dll}}
}

