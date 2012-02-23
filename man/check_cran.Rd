\name{check_cran}
\alias{check_cran}
\title{Check a package from CRAN.}
\usage{
  check_cran(pkg, ...)
}
\arguments{
  \item{pkg}{Package name - note that unlike other
  \pkg{devtools} functions this is the name of a CRAN
  package, not a path.}

  \item{...}{other parameters passed onto
  \code{\link{download.packages}}}
}
\description{
  This is useful for automatically checking that
  dependencies of your packages work.
}
\details{
  The downloaded package and check directory are only
  removed if the check is successful - this allows you to
  inspect the results to figure out what went wrong.
}

