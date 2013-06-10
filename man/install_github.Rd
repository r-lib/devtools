\name{install_github}
\alias{install_github}
\title{Attempts to install a package directly from github.}
\usage{
  install_github(repo, username = getOption("github.user"),
    ref = "master", pull = NULL, subdir = NULL,
    branch = NULL, auth_user = NULL, password = NULL, ...)
}
\arguments{
  \item{username}{Github username}

  \item{repo}{Repo name}

  \item{ref}{Desired git reference. Could be a commit, tag,
  or branch name. Defaults to \code{"master"}.}

  \item{pull}{Desired pull request. A pull request refers
  to a branch, so you can't specify both \code{branch} and
  \code{pull}; one of them must be \code{NULL}.}

  \item{subdir}{subdirectory within repo that contains the
  R package.}

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
install_github("roxygen")
}
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_bitbucket}},
  \code{\link{install_git}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

