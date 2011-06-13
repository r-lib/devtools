\name{run_examples}
\alias{run_examples}
\title{Run all examples in a package.}
\usage{run_examples(pkg, start)}

\description{
  Run all examples in a package.
}

\details{
  One of the most frustrating parts of `R CMD check` is
  getting all of your examples to pass - whenever one fails
  you need to fix the problem and then restart the whole
  process.  This function makes it a little easier by
  making it possible to run all examples from an R
  function.
}
\keyword{programming}
\arguments{
  \item{pkg}{package description, can be path or package name.  See
\code{\link{as.package}} for more information}
  \item{start}{name of \code{Rd} file to start with - if omitted, will start
with the (lexicographically) first file.  This is useful if you have a 
lot of examples and don't want to rerun them every time when you fix a 
problem.}
}
