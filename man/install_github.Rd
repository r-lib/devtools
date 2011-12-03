\name{install_github}
\alias{install_github}
\title{Attempts to install a package directly from github.}
\usage{
  install_github(repo, username = "hadley",
    branch = "master")
}
\arguments{
  \item{username}{Github username}

  \item{repo}{Repo name}

  \item{branch}{Desired branch - defaults to
  \code{"master"}}
}
\description{
  Attempts to install a package directly from github.
}
\examples{
\dontrun{
install_github("roxygen")
}
}

