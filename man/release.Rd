\name{release}
\alias{release}
\title{Release package to CRAN.}
\usage{
  release(pkg = ".", check = TRUE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{check}{if \code{TRUE}, run checking, otherwise omit
  it.  This is useful if you've just checked your package
  and you're ready to release it.}
}
\description{
  Run automated and manual tests, then ftp to CRAN.
}
\details{
  The package release process will:

  \itemize{

  \item Confirm that the package passes \code{R CMD check}
  \item Ask if you've checked your code on win-builder
  \item Confirm that news is up-to-date \item Confirm that
  DESCRIPTION is ok \item Ask if you've checked packages
  that depend on your package \item Build the package \item
  Upload the package to CRAN \item Draft an email to the
  CRAN maintainer. }

  You should also read the CRAN repository policy at
  \url{http://cran.r-project.org/web/packages/policies.html}
  and make sure you're in line with them.  \code{release}
  tries to automate as much of them as possible, but they
  do change and you should be familiar with them.
}

