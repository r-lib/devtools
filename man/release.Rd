\name{release}
\alias{release}
\title{Release package to CRAN.}
\usage{release(pkg)}

\description{
  Release package to CRAN.
}

\details{
  The package release process will:

  \itemize{ %}

  \item Confirm that the package passes \code{R CMD check}
  \item Confirm that news is up-to-date \item Confirm that
  DESCRIPTION is ok \item Build the package \item Upload
  the pakcage to CRAN \item Draft an email to the CRAN
  maintainer. }
}
\arguments{
  \item{pkg}{package description, can be path or package name.  See
\code{\link{as.package}} for more information}
}
