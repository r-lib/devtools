\name{document}
\alias{document}
\title{Use roxygen to make documentation.}
\usage{
  document(pkg = NULL, clean = FALSE,
    roclets = c("collate", "namespace", "rd"))
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{clean}{if \code{TRUE} will automatically clear all
  roxygen caches and delete current \file{man/} contents to
  ensure that you have the freshest version of the
  documentation.  check documentation after running
  roxygen.}

  \item{roclets}{character vector of roclet names to apply
  to package}
}
\description{
  Use roxygen to make documentation.
}
\keyword{programming}

