\name{get_path}
\alias{add_path}
\alias{get_path}
\alias{set_path}
\title{System Path Manipulations}
\usage{
  get_path()

  set_path(path)

  add_path(..., after = 0)
}
\arguments{
  \item{path}{character vector of locations}

  \item{...}{character locations}

  \item{after}{the place on the path, defaults to first}
}
\description{
  System Path Manipulations
}
\details{
  \code{get_path()} will retrieve the system path, also
  known as the $PATH, or %PATH% environment variable.  The
  system path the the set of directories that the system
  will search to find programs and executables.

  \code{get_path} will retrieve the system path as a
  caracter vector of directories.

  \code{set_path()} Takes a character vector of
  directories, and sets the path to that list. The changes
  remain in effect until the end of the session.

  add_path temporarily adds location(s) to the system path.
  Added paths will be available to R and to any sub
  processes until the end of the R session, or unless
  otherwise overwritten.
}
\examples{
(path <- get_path())
length(path)
add_path(R.home())
get_path()
}

