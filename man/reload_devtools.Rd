\name{reload_devtools}
\alias{reload_devtools}
\title{Reload the devtools package}
\usage{
  reload_devtools(pkg = NULL, reset = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{reset}{clear package environment and reset file
  cache before loading any pieces of the package.}
}
\description{
  Special care must be take to reload the devtools package,
  for a number of reasons. First, if devtools was loaded
  with \code{library()}, its namespace environment will be
  locked. Second, even if it is not locked, if you use
  \code{load_all} with \code{reset=TRUE}, then the utility
  functions that are used to load the package will be
  deleted before it is actually reloaded.
}
\details{
  This function avoids these problems by creating a
  duplicate of the devtools namespace environment, and then
  calls \code{load_all} from the duplicate environment.
}

