\name{bisect_install}
\alias{bisect_install}
\title{Install a package from source, for bisect tests.}
\usage{
  bisect_install(pkgdir = ".", on_fail = NA)
}
\arguments{
  \item{pkgdir}{The directory to load from}

  \item{on_fail}{What to do if installation fails (default
  NA, or mark as skip)}
}
\description{
  If the installation fails, the default behavior is to
  mark this commit as skip (by returning \code{NA}).
}
\details{
  This function is usually used together with
  \code{bisect_require}.
}
\seealso{
  \code{\link{bisect_require}}

  \code{\link{bisect_load_all}}

  \code{\link{bisect_runtest}}

  \code{\link{bisect_return_interactive}}
}

