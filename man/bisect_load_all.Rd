\name{bisect_load_all}
\alias{bisect_load_all}
\title{Like \code{load_all}, but for bisect tests.}
\usage{
  bisect_load_all(pkgdir = ".", on_error = NA)
}
\arguments{
  \item{pkgdir}{The directory to load from}

  \item{on_error}{What to do if loading throws an error
  (default NA, or mark as skip)}
}
\description{
  If the package fails to load, mark this commit as skip
  (by returning \code{NA}).
}
\seealso{
  \code{\link{bisect_install}}

  \code{\link{bisect_runtest}}

  \code{\link{bisect_return_interactive}}
}

