\name{install_git_single}
\alias{install_git_single}
\title{Install a single package from a git repository}
\usage{
install_git_single(git_url, name = NULL, subdir = NULL, branch = NULL,
  git_args = character(), git_binary = NULL, ...)
}
\arguments{
  \item{git_url}{Location of package. The url should point
  to a public or private repository.}

  \item{name}{Optional package name, used to provide more
  informative messages.}

  \item{subdir}{A sub-directory withing a git repository
  that may contain the package we are interested in
  installing.}

  \item{git_args}{A character vector providing extra
  arguments to pass on to}

  \item{git_binary}{A custom git-binary to use instead of
  default system's git version.}

  \item{...}{passed on to \code{\link{install}}}
}
\description{
  This function allows you to install a single package from
  a git repository.
}
\details{
  See \code{\link{install_git}} for more information about
  the paraemeters.
}
\keyword{internal}

