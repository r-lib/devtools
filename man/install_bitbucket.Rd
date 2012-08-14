\name{install_bitbucket}
\alias{install_bitbucket}
\title{Install a package directly from bitbucket}
\usage{
  install_bitbucket(repo, username, ref = "master",
    branch = NULL, ...)
}
\arguments{
  \item{username}{bitbucket username}

  \item{repo}{Repo name}

  \item{ref}{Desired git reference. Could be a commit, tag,
  or branch name. Defaults to \code{"master"}.}

  \item{branch}{Deprecated. Use \code{ref} instead.}

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

