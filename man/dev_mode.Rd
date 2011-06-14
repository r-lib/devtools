\name{dev_mode}
\alias{dev_mode}
\title{Activate and deactivate development mode.}
\usage{dev_mode(on, path="~/R-dev")}

\description{
  Activate and deactivate development mode.
}

\details{
  When activated, \code{dev_mode} creates a new library for
  storing installed packages. This is automatically removed
  when \code{dev_mode} is activated. This allows you to
  test development packages in a sandbox, without
  interfering with the other packages you have installed.
}
\arguments{
  \item{on}{turn dev mode on (\code{TRUE}) or off (\code{FALSE}).  If omitted
will guess based on whether or not \code{path} is in
\code{\link{.libPaths}}}
  \item{path}{directory to for library.}
}
\examples{dev_mode()
dev_mode()}
