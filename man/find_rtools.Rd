\name{find_rtools}
\alias{find_rtools}
\title{Find rtools.}
\usage{
  find_rtools()
}
\value{
  Invisible \code{TRUE} if rtools is found, \code{FALSE}
  otherwise. If rtools is found, as a side-effect it
  updates the internal package variable \code{rtools_path}.
  If not found, an informative message will also be
  displayed.
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

