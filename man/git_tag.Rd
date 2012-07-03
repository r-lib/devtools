\name{git_tag}
\alias{git_tag}
\title{Add a tag to the git repository.}
\usage{
  git_tag(name, message, path = ".")
}
\arguments{
  \item{path}{The path to tag.}

  \item{name}{The name of the tag.}

  \item{message}{The message for the tag.}
}
\description{
  Add a tag to the git repository.
}
\seealso{
  Other git: \code{\link{git_add}},
  \code{\link{git_add_new}}, \code{\link{git_commit}},
  \code{\link{git_commit_all}}, \code{\link{git_status}},
  \code{\link{has_git}}, \code{\link{win_has_git}}
}

