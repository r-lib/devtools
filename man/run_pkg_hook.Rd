\name{run_pkg_hook}
\alias{run_pkg_hook}
\alias{run_user_hook}
\title{Run user and package hooks.}
\usage{
  run_pkg_hook(pkg, hook)

  run_user_hook(pkg, hook)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{hook}{hook name: one of "load", "unload", "attach",
  or "detach"}
}
\description{
  Run user and package hooks.
}
\keyword{internal}

