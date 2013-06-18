\name{find_rtools}
\alias{find_rtools}
\title{Find rtools.}
\usage{
  find_rtools(debug = FALSE)
}
\arguments{
  \item{debug}{if \code{TRUE} prints a lot of additional
  information to help in debugging.}
}
\value{
  Either a visible \code{TRUE} if rtools is found, or an
  invisible \code{FALSE} with a diagnostic
  \code{\link{message}}.  As a side-effect the internal
  package variable \code{rtools_path} is updated to the
  paths to rtools binaries.
}
\description{
  To build binary packages on windows, Rtools (found at
  \url{http://cran.r-project.org/bin/windows/Rtools/})
  needs to be on the path. The default installation process
  does not add it, so this script finds it (looking first
  on the path, then in the registry). It also checks that
  the version of rtools matches the version of R.
}
\section{Acknowledgements}{
  This code borrows heavily from RStudio's code for finding
  rtools.  Thanks JJ!
}
\keyword{internal}

