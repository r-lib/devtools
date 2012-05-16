\name{install_bitbucket}
\alias{install_bitbucket}
\title{Install a package directly from bitbucket}
\usage{
  install_bitbucket(repo, username, branch = "master", ...)
}
\arguments{
  \item{username}{bitbucket username}

  \item{repo}{Repo name}

  \item{branch}{Desired branch - defaults to
  \code{"master"}}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}
}
\description{
  This function is vectorised so you can install multiple
  packages in a single command.
}
\examples{
\dontrun{
install_bitbucket("paulhiemstra")
install_bitbucket(c("testrepo", "testrepo2")
}
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

