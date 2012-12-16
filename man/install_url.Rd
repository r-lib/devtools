\name{install_url}
\alias{install_url}
\title{Install a package from a url}
\usage{
  install_url(url, name = NULL, subdir = NULL,
    config = list(), ...)
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

