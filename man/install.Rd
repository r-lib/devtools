\name{install}
\alias{install}
\title{Install a local development package.}
\usage{
  install(pkg = ".", reload = TRUE, quick = FALSE,
    args = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{reload}{if \code{TRUE} (the default), will
  automatically reload the package after installing.}

  \item{quick}{if \code{TRUE} skips docs,
  multiple-architectures, and demos to make installation as
  fast as possible.}

  \item{args}{An optional character vector of additional
  command line arguments to be passed to \code{R CMD
  install}.}
}
\description{
  Uses \code{R CMD INSTALL} to install the package. Will
  also try to install dependencies of the package from
  CRAN, if they're not already installed.
}
\details{
  Installation takes place on a copy of the package
  produced by \code{R CMD build} to avoid modifying the
  local directory in any way.
}
\seealso{
  \code{\link{with_debug}} to install packages with
  debugging flags set.

  Other package installation:
  \code{\link{install_bitbucket}},
  \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

