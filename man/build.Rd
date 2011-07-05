\name{build}
\alias{build}
\title{Build package in specified directory.}
\usage{
  build(pkg = NULL, path = tempdir())
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{path}{path in which to produce package}
}
\value{
  a string giving the location (including file name) of the
  built package
}
\description{
  Build package in specified directory.
}

