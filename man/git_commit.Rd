\name{git_commit}
\alias{git_commit}
\alias{git_commit_all}
\title{Commit changes in a git repository.}
\usage{
  git_commit(message, path = ".")

  git_commit_all(message, path = ".")
}
\arguments{
  \item{message}{The commit message.}

  \item{path}{The path to commit.}
}
\description{
  Commits changes to a folder except new files.
}
\seealso{
  Other git: \code{\link{git_add}},
  \code{\link{git_add_new}}, \code{\link{git_status}},
  \code{\link{git_tag}}, \code{\link{has_git}},
  \code{\link{win_has_git}}
}

