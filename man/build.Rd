\name{build}
\alias{build}
\title{Build package in specified directory.}
\usage{
  build(pkg = NULL, path = NULL, binary = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{path}{path in which to produce package.  If
  \code{NULL}, defaults to the parent directory of the
  package.}

  \item{binary}{Produce a binary (\code{--binary}) or
  source ( \code{--no-manual --no-vignettes}) version of
  the package.}
}
\value{
  a string giving the location (including file name) of the
  built package
}
\description{
  Build package in specified directory.
}
\seealso{
  Other build functions: \code{\link{build_win}}
}

