\name{install_github}
\alias{install_github}
\title{Attempts to install a package directly from github.}
\usage{
install_github(repo, username = getOption("github.user"), ref = "master",
  pull = NULL, subdir = NULL, branch = NULL, auth_user = NULL,
  password = NULL, ...)
}
\arguments{
  \item{repo}{Repository address in the format
  \code{[username/]repo[/subdir][@ref|#pull]}.
  Alternatively, you can specify \code{username},
  \code{subdir}, \code{ref} or \code{pull} using the
  respective parameters (see below); if both is specified,
  the values in \code{repo} take precedence.}

  \item{username}{User name}

  \item{ref}{Desired git reference. Could be a commit, tag,
  or branch name. Defaults to \code{"master"}.}

  \item{pull}{Desired pull request. A pull request refers
  to a branch, so you can't specify both \code{branch} and
  \code{pull}; one of them must be \code{NULL}.}

  \item{subdir}{subdirectory within repo that contains the
  R package.}

  \item{branch}{Deprecated. Use \code{ref} instead.}

  \item{auth_user}{your account username if you're
  attempting to install a package hosted in a private
  repository (and your username is different to
  \code{username})}

  \item{password}{your password}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}
}
\description{
This function is vectorised on \code{repo} so you can
install multiple packages in a single command.
}
\examples{
\dontrun{
install_github("roxygen")
install_github("wch/ggplot2")
install_github(c("rstudio/httpuv", "rstudio/shiny"))
install_github(c("devtools@devtools-1.4", "klutometis/roxygen#142", "mfrasca/r-logging/pkg))

# Update devtools to the latest version, on Linux and Mac
# On Windows, this won't work - see ?build_github_devtools
install_github("hadley/devtools")

}
}
\seealso{
Other package installation: \code{\link{install}},
\code{\link{install_bitbucket}}, \code{\link{install_git}},
\code{\link{install_gitorious}}, \code{\link{install_url}},
\code{\link{install_version}}
}

