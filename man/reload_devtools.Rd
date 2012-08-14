\name{reload_devtools}
\alias{reload_devtools}
\title{Reload the devtools package}
\usage{
  reload_devtools(pkg = NULL, reset = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  This must be the devtools package.}

  \item{reset}{clear package environment and reset file
  cache before loading any pieces of the package.}
}
\description{
  Special care must be take to reload the devtools package.
  Attempts to detach and unregister the devtools namespace
  from within a function in the devtools namespace don't
  seem to work; the namespace seems to re-register itself.
}
\details{
  This function dodges the problem by creating a copy of
  the devtools namespace environment, and then calls
  \code{load_all} from the duplicate environment.
}

