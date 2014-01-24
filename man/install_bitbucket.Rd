\name{install_bitbucket}
\alias{install_bitbucket}
\title{Install a package directly from bitbucket}
\usage{
install_bitbucket(repo, username, ref = "master", pull = NULL,
  branch = NULL, auth_user = NULL, password = NULL, ...)
}
\arguments{
  \item{repo}{repo name}

  \item{username}{bitbucket username.}

  \item{ref}{Desired git reference. Could be a commit, tag,
  or branch name. Defaults to \code{"master"}.}

  \item{pull}{Desired pull request. A pull request refers
  to a branch, so you can't specify both \code{branch} and
  \code{pull}; one of them must be \code{NULL}.}

  \item{branch}{Deprecated. Use \code{ref} instead.}

  \item{auth_user}{your account username if you're
  attempting to install a package hosted in a private
  repository (and your username is different to
  \code{username})}

  \item{password}{your password}

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
install_bitbucket(c("testrepo", "testrepo2"))
}
}
\seealso{
Bitbucket API docs:
\url{https://confluence.atlassian.com/display/BITBUCKET/Use+the+Bitbucket+REST+APIs}
\url{http://restbrowser.bitbucket.org}

Other package installation: \code{\link{install_github}};
\code{\link{install_gitorious}}; \code{\link{install_git}};
\code{\link{install_url}}; \code{\link{install_version}};
\code{\link{install}}
}

