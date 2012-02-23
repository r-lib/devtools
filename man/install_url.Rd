\name{install_url}
\alias{install_url}
\title{Install a package from a url}
\usage{
  install_url(url, name = NULL, ...)
}
\arguments{
  \item{url}{location of package on internet}

  \item{name}{optional package name, used to provide more
  informative messages}

  \item{...}{Other arguments passed on to
  \code{\link{install.packages}}.}
}
\description{
  This function is vectorised so you can install multiple
  packages in a single command.
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_version}}
}

