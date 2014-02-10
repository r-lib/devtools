\name{make_test_skeleton}
\alias{make_test_skeleton}
\title{Add test skeleton.}
\usage{
make_test_skeleton(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name. See \code{\link{as.package}} for more information.}
}
\description{
Add testing infrastructure to a package that does not
already have it. This will create \file{tests/testthat.R},
\file{tests/testthat/} and add \pkg{testthat} to the
suggested packages. This is called automatically from
\code{\link{test}} if needed.
}

