\name{install_gitorious}
\alias{install_gitorious}
\title{Attempts to install a package directly from gitorious.}
\usage{
  install_gitorious(repo, project = repo,
    branch = "master")
}
\arguments{
  \item{project}{Gitorious project name}

  \item{repo}{Repo name}

  \item{branch}{Desired branch - defaults to
  \code{"master"}}
}
\description{
  Attempts to install a package directly from gitorious.
}
\examples{
\dontrun{
install_gitorious("r-mpc-package")
}
}

