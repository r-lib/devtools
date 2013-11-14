\name{install_url}
\alias{install_url}
\title{Install a package from a url}
\usage{
install_url(url, name = NULL, subdir = NULL, config = list(),
  before_install = NULL, ...)
}
\arguments{
  \item{url}{location of package on internet. The url
  should point to a zip file, a tar file or a
  bzipped/gzipped tar file.}

  \item{name}{optional package name, used to provide more
  informative messages}

  \item{subdir}{subdirectory within url bundle that
  contains the R package.}

  \item{config}{additional configuration argument (e.g.
  proxy, authentication) passed on to
  \code{\link[httr]{GET}}.}

  \item{before_install}{a function that can modify the
  contents of the package source directory prior to
  installation. Accepts two parameters: bundle (the full
  path to the downloaded package zip file) and pkg_path
  (the path where the package source is staged prior to
  installation)}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}
}
\description{
  This function is vectorised so you can install multiple
  packages in a single command.
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_bitbucket}},
  \code{\link{install_git}}, \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_version}}
}

