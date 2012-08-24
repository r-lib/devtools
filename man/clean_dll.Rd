\name{clean_dll}
\alias{clean_dll}
\title{Remove compiled objects from /src/ directory}
\usage{
  clean_dll(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  Invisibly returns the names of the deleted files.
}
\seealso{
  \code{\link{compile_dll}}
}

