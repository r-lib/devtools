\name{install_bioconductor}
\alias{install_bioconductor}
\title{Install packages from SVN on bioconductor}
\usage{
  install_bioconductor(pkgs, ...)
}
\arguments{
  \item{pkgs}{vector of packages names}

  \item{...}{further arguments passed to
  \code{\link{install}}}
}
\description{
  This function installs the latest development version of
  the packages, which is useful for testing purposes. In
  contrast, the \code{biocLite()} function provided by
  bioconductor installs a stable (hence usually older)
  version, which should be preferred for production work.
  It is vectorised so you can install multiple packages in
  a single command.
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

