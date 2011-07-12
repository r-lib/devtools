\name{release}
\alias{release}
\title{Release package to CRAN.}
\usage{
  release(pkg = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  The package release process will:
}
\details{
  \itemize{ %}

  \item Confirm that the package passes \code{R CMD check}
  \item Confirm that news is up-to-date \item Confirm that
  DESCRIPTION is ok \item Build the package \item Upload
  the pakcage to CRAN \item Draft an email to the CRAN
  maintainer. }
}

