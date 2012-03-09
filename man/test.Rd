\name{test}
\alias{test}
\title{Execute all \pkg{test_that} tests in a package.}
\usage{
  test(pkg = NULL, filter = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{filter}{If not \code{NULL}, only tests with file
  names matching this regular expression will be executed.
  Matching will take on the file name after it has been
  stripped of \code{"test-"} and \code{".r"}.}
}
\description{
  Tests are assumed to be located in a \code{inst/tests/}
  directory. See \code{\link[testthat]{test_dir}} for the
  naming convention of test scripts within that directory.
}

