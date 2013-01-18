\name{document}
\alias{document}
\title{Use roxygen to make documentation.}
\usage{
  document(pkg = ".", clean = FALSE,
    roclets = c("collate", "namespace", "rd"),
    reload = TRUE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{clean}{if \code{TRUE} will automatically clear all
  roxygen caches and delete current \file{man/} contents to
  ensure that you have the freshest version of the
  documentation.}

  \item{roclets}{character vector of roclet names to apply
  to package}

  \item{reload}{if \code{TRUE} uses \code{load_all} to
  reload the package prior to documenting.  This is
  important because \pkg{roxygen2} uses introspection on
  the code objects to determine how to document them.}
}
\description{
  Use roxygen to make documentation.
}
\keyword{programming}

