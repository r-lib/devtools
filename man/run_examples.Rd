\name{run_examples}
\alias{run_examples}
\title{Run all examples in a package.}
\usage{
  run_examples(pkg = NULL, start = NULL, strict = TRUE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{start}{name of \code{Rd} file to start with - if
  omitted, will start with the (lexicographically) first
  file.  This is useful if you have a lot of examples and
  don't want to rerun them every time when you fix a
  problem.}

  \item{strict}{if \code{TRUE}, each example is run in a
  clean R environment mimicing what \code{R CMD check}
  does.  This is useful for discovering namespace problems
  in your examples.}
}
\description{
  One of the most frustrating parts of `R CMD check` is
  getting all of your examples to pass - whenever one fails
  you need to fix the problem and then restart the whole
  process.  This function makes it a little easier by
  making it possible to run all examples from an R
  function.
}
\keyword{programming}

