\name{bisect_load_all}
\alias{bisect_load_all}
\title{Like \code{load_all}, but for bisect tests. If the package fails to
load, mark this commit as skip (by returning \code{NA}).}
\usage{
  bisect_load_all(pkgdir = ".", on_error = NA)
}
\arguments{
  \item{dir}{The directory to load from}

  \item{on_error}{What to do if loading throws an error
  (default NA, or mark as skip)}
}
\description{
  Like \code{load_all}, but for bisect tests. If the
  package fails to load, mark this commit as skip (by
  returning \code{NA}).
}
\seealso{
  \code{\link{bisect_load_and_test}}

  \code{\link{bisect_runtest}}

  \code{\link{bisect_return_interactive}}
}

