\name{bisect_runtest}
\alias{bisect_runtest}
\title{Run a test function for git bisect testing.}
\usage{
  bisect_runtest(fun, on_error = NA,
    msg = "Running test...")
}
\arguments{
  \item{fun}{The test function}

  \item{on_error}{What to do if loading throws an error
  (default \code{NA}, or mark as skip)}

  \item{msg}{A message to print to the console when running
  the test}
}
\description{
  If the function returns \code{TRUE}, quit and mark this
  commit as good. If the function returns \code{FALSE},
  quit and mark this commit as bad. If the function returns
  \code{NA}, quit and mark this commit as skip. If the
  function returns \code{NULL}, do nothing.
}
\details{
  It is also important to set \code{on_error}. This tells
  it what to do when the test function throws an error. The
  default behavior is to mark this commit as skip
  (\code{NA}). However, in some cases, it makes sense to
  mark this commit as bad (\code{FALSE}) if an error is
  thrown.
}
\seealso{
  \code{\link{bisect_load_all}}

  \code{\link{bisect_install}}

  \code{\link{bisect_return_interactive}}
}

