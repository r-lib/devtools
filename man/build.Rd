\name{build}
\alias{build}
\title{Build package in specified directory.}
\usage{
  build(pkg = ".", path = NULL, binary = FALSE,
    vignettes = TRUE, quiet = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{path}{path in which to produce package.  If
  \code{NULL}, defaults to the parent directory of the
  package.}

  \item{binary}{Produce a binary (\code{--binary}) or
  source ( \code{--no-manual --no-resave-data}) version of
  the package.}

  \item{vignettes}{For source packages: if \code{FALSE},
  don't build PDF vignettes (\code{--no-vignettes}).}

  \item{quiet}{if \code{TRUE} suppresses output from this
  function.}
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

