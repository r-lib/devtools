\name{install_github}
\alias{install_github}
\title{Attempts to install a package directly from github.}
\usage{
  install_github(repo, username = "hadley",
    branch = "master", ...)
}
\arguments{
  \item{username}{Github username}

  \item{repo}{Repo name}

  \item{branch}{Desired branch - defaults to
  \code{"master"}}

  \item{...}{Other arguments passed on to
  \code{\link{install.packages}}.}
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
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

