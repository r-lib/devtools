\name{dev_mode}
\alias{dev_mode}
\title{Activate and deactivate development mode.}
\usage{
  dev_mode(on = NULL, path = "~/R-dev")
}
\arguments{
  \item{on}{turn dev mode on (\code{TRUE}) or off
  (\code{FALSE}).  If omitted will guess based on whether
  or not \code{path} is in \code{\link{.libPaths}}}

  \item{path}{directory to for library.}
}
\description{
  When activated, \code{dev_mode} creates a new library for
  storing installed packages. This new library is
  automatically created when \code{dev_mode} is activated
  if it does not already exist. This allows you to test
  development packages in a sandbox, without interfering
  with the other packages you have installed.
}
\examples{
\donttest{
dev_mode()
dev_mode()
}
}

