\name{load_all}
\alias{load_all}
\title{Load complete package.}
\usage{
  load_all(pkg = NULL, reset = FALSE, self = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{reset}{clear package environment and reset file
  cache before loading any pieces of the package.}

  \item{self}{For internal use only. (This is used when
  \code{load_all} is called from
  \code{\link{reload_devtools}})}
}
\description{
  Load complete package.
}
\keyword{programming}

