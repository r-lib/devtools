\name{install_svn_single}
\alias{install_svn_single}
\title{Install a single package from a svn repository}
\usage{
install_svn_single(svn_url, name = NULL, subdir = "trunk", branch = NULL,
  svn_args = character(), svn_binary = NULL, ...)
}
\arguments{
  \item{svn_url}{Location of package. The url should point
  to a public or private repository.}

  \item{name}{Optional package name, used to provide more
  informative messages.}

  \item{subdir}{A sub-directory withing a svn repository
  that may contain the package we are interested in
  installing. By default, this points to the 'trunk'
  directory.}

  \item{svn_args}{A character vector providing extra
  arguments to pass on to}

  \item{svn_binary}{A custom svn-binary to use instead of
  default system's svn version.}

  \item{...}{passed on to \code{\link{install}}}
}
\description{
This function allows you to install a single package from a svn repository.
}
\details{
See \code{\link{install_svn}} for more information about the paraemeters.
}
\keyword{internal}

