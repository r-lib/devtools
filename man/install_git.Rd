\name{install_git}
\alias{install_git}
\title{Install a package from a git repository}
\usage{
  install_git(git_url, name = NULL, subdir = NULL,
    git_binary = NULL, git_args = NULL, ...)
}
\arguments{
  \item{git_url}{Location of package. The url should point
  to a public or private repository.}

  \item{name}{Optional package name, used to provide more
  informative messages.}

  \item{subdir}{A sub-directory withing a git repository
  that may contain the package we are interested in
  installing.}

  \item{git_binary}{A custom git-binary to use instead of
  default system's git version.}

  \item{git_args}{Extra arguments to git.}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}
}
\description{
  This function requires \code{git} to be installed on your
  system in order to be used.
}
\details{
  It is vectorised so you can install multiple packages
  with a single command.
}
\examples{
\dontrun{
install_git("git://github.com/hadley/stringr.git")
install_git("git://github.com/hadley/reshape.git", git_args = c("--branch", "reshape2"))
install_git("git://github.com/mlt/swap2r.git", git_args = "--recursive")
}
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_bitbucket}},
  \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

