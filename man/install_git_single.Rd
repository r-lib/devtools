\name{install_git_single}
\alias{install_git_single}
\title{Install a single package from a git repository}
\usage{
  install_git_single(git_url, name = NULL, subdir = NULL,
    branch = NULL, git_binary = NULL, recursive = FALSE,
    ...)
}
\arguments{
  \item{git_url}{Location of package. The url should point
  to a public or private repository.}

  \item{name}{Optional package name, used to provide more
  informative messages.}

  \item{subdir}{A sub-directory withing a git repository
  that may contain the package we are interested in
  installing.}

  \item{branch}{Name of branch or tag to use, if not
  master.}

  \item{git_binary}{A custom git-binary to use instead of
  default system's git version.}

  \item{recursive}{Clone git repository recursively with
  all submodules.}

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

