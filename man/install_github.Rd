\name{install_github}
\alias{install_github}
\title{Attempts to install a package directly from github.}
\usage{
  install_github(repo, username = getOption("github.user"),
    branch = "master", subdir = NULL, ...)
}
\arguments{
  \item{username}{Github username}

  \item{repo}{Repo name}

  \item{branch}{Desired branch - defaults to
  \code{"master"}}

  \item{subdir}{subdirectory within repo that contains the
  R package.}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}
}
\description{
  This function is vectorised so you can install multiple
  packages in a single command.
}
\examples{
\dontrun{
install_github("roxygen")
}
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_bitbucket}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

