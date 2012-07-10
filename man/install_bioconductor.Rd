\name{install_bioconductor}
\alias{install_bioconductor}
\title{Install a package from SVN on bioconductor}
\usage{
  install_bioconductor(pkgs, ...)
}
\arguments{
  \item{pkgs}{vector of packages names}

  \item{...}{further arguments passed to
  \code{\link{install}}}
}
\description{
  This function fetches the latest development version of
  each package, for testing purposes. In contrast, the
  \code{biocLite()} function provided by bioconductor
  installs a stable (hence usually older) version. It is
  vectorised so you can install multiple packages in a
  single command.
}
\details{
  Please note that the function has to download each file
  of the package separately from bioconductor, hence the
  download phase can be quite long.
}
\examples{
\dontrun{install_bioconductor(pkgs=c("ggbio", "pcaMethods"))
}
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_bitbucket}},
  \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

