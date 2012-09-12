\name{check}
\alias{check}
\title{Build and check a package, cleaning up automatically on success.}
\usage{
  check(pkg = ".", document = TRUE, cleanup = TRUE,
    cran = TRUE, args = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{document}{if \code{TRUE} (the default), will update
  and check documentation before running formal check.}

  \item{cleanup}{if \code{TRUE} the check directory is
  removed if the check is successful - this allows you to
  inspect the results to figure out what went wrong. If
  \code{FALSE} the check directory is never removed.}

  \item{cran}{if \code{TRUE} (the default), check with
  CRAN.}

  \item{args}{An optional character vector of additional
  command line arguments to be passed to \code{R CMD
  check}.}
}
\description{
  \code{check} automatically builds a package before using
  \code{R CMD check} as this is the recommended way to
  check packages.  Note that this process runs in an
  independent realisation of R, so nothing in your current
  workspace will affect the process.
}
\details{
  After the \code{R CMD check}, this will run checks that
  are specific to devtools.
}

