\name{test}
\alias{test}
\title{Execute all \pkg{test_that} tests in a package.}
\usage{
test(pkg = ".", filter = NULL, fresh = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{filter}{If not \code{NULL}, only tests with file
  names matching this regular expression will be executed.
  Matching will take on the file name after it has been
  stripped of \code{"test-"} and \code{".r"}.}

  \item{fresh}{if \code{TRUE}, will be run in a fresh R
  session. This has the advantage that there's no way the
  examples can depend on anything in the current session,
  but interactive code (like \code{\link{browser}}) won't
  work.}
}
\description{
  Tests are assumed to be located in a \code{inst/tests/}
  directory. See \code{\link[testthat]{test_dir}} for the
  naming convention of test scripts within that directory.
}

