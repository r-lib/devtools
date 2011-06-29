\name{install_github}
\alias{install_github}
\title{Attempts to install a package directly from github.}
\usage{install_github(repo, username="hadley", branch="master")}

\description{
  Attempts to install a package directly from github.
}
\arguments{
  \item{username}{Github username}
  \item{repo}{Repo name}
  \item{branch}{Desired branch - defaults to \code{"master"}}
}
\examples{\dontrun{
install_github("roxygen")
}}
