\name{check}
\alias{check}
\title{Build and check a package, cleaning up automatically on success.}
\usage{check(pkg)}

\description{
  Build and check a package, cleaning up automatically on
  success.
}

\details{
  \code{check} automatically builds a package before using
  \code{R CMD check} as this is the recommended way to
  check pakcages.  Note that this process runs in an
  independent realisation of R, so nothing in your current
  workspace will affect the proces.
}
\arguments{
  \item{pkg}{package description, can be path or package name.  See
\code{\link{as.package}} for more information}
}
