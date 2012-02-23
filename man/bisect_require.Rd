\name{bisect_require}
\alias{bisect_require}
\title{Load a package like \code{require()}, for bisect tests.}
\usage{
  bisect_require(package, on_fail = NA)
}
\arguments{
  \item{package}{Name of package}

  \item{on_fail}{What to do if loading fails (default NA,
  or mark as skip)}
}
\description{
  If the package fails to load, the default behavior is to
  mark this commit as skip (by returning \code{NA}).
}
\details{
  This function is usually used together with
  \code{bisect_install}.
}
\seealso{
  \code{\link{bisect_install}}

  \code{\link{bisect_load_all}}

  \code{\link{bisect_runtest}}

  \code{\link{bisect_return_interactive}}
}

