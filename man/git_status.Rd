\name{git_status}
\alias{git_status}
\title{Check the status of a git repository.}
\usage{
  git_status(path = ".",
    show.untracked = c("all", "normal", "no"),
    show.ignored = FALSE)
}
\arguments{
  \item{path}{the path to consider.}

  \item{show.untracked}{Should untracked files be shown?}

  \item{show.ignored}{Should ignored files be shown?}
}
\value{
  A data.frame with status and file for the changed files.
}
\description{
  If the specified directory is a git repository, then
  check the status.
}
\seealso{
  Other git: \code{\link{git_add}},
  \code{\link{git_add_new}}, \code{\link{git_commit}},
  \code{\link{git_commit_all}}, \code{\link{git_tag}},
  \code{\link{has_git}}, \code{\link{win_has_git}}
}

