\name{install_git}
\alias{install_git}
\title{Install a package from a git repository}
\usage{
install_git(git_url, name = NULL, subdir = NULL, branch = NULL,
  git_args = character(0), git_binary = NULL, ...)
}
\arguments{
  \item{branch}{Name of branch or tag to use, if not
  master.}

  \item{...}{Other arguments passed on to
  \code{\link{install}}}

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
}
\description{
This function requires \code{git} to be installed on your
system in order to be used.
}
\details{
It is vectorised so you can install multiple packages with
a single command.
}
\examples{
\dontrun{
install_git("git://github.com/hadley/stringr.git")
install_git("git://github.com/hadley/stringr.git", branch = "stringr-0.2")
}
}
\seealso{
Other package installation: \code{\link{install}},
\code{\link{install_bitbucket}},
\code{\link{install_github}},
\code{\link{install_gitorious}}, \code{\link{install_url}},
\code{\link{install_version}}
}

