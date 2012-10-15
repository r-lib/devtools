\name{install_git}
\alias{install_git}
\title{Install a package from a Git repository url.}
\usage{
  install_git(git_url, name = NULL, subdir = NULL,
    git_binary = NULL, config = list(), ...)
}
\arguments{
  \item{git_url}{location of repository containing the package on internet. 
  The git repository url should point to a public git repository or a private
  git repository you have access to.}

  \item{name}{optional package name, used to provide more
  informative messages.}

  \item{subdir}{subdirectory within url bundle that
  contains the R package.}

  \item{git_binary}{specific git binary to use to clone the packages.}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}
}
\description{
  This function is vectorised so you can install multiple
  packages from multiple repositories in a single command.
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_url}},
  \code{\link{install_bitbucket}},
  \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_version}}
}

