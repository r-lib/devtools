\name{install_gitorious}
\alias{install_gitorious}
\title{Attempts to install a package directly from gitorious.}
\usage{
  install_gitorious(repo, project = repo,
    branch = "master", subdir = NULL, ...)
}
\arguments{
  \item{project}{Gitorious project name}

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
install_gitorious("r-mpc-package")
}
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_bitbucket}},
  \code{\link{install_github}}, \code{\link{install_url}},
  \code{\link{install_version}}
}

