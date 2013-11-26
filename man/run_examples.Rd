\name{run_examples}
\alias{run_examples}
\title{Run all examples in a package.}
\usage{
run_examples(pkg = ".", start = NULL, show = TRUE, test = FALSE,
  run = TRUE, fresh = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{start}{Where to start running the examples: this
  can either be the name of \code{Rd} file to start with
  (with or without extensions), or a topic name. If
  omitted, will start with the (lexicographically) first
  file. This is useful if you have a lot of examples and
  don't want to rerun them every time when you fix a
  problem.}

  \item{show}{if \code{TRUE}, code in \code{\\dontshow{}}
  will be commented out}

  \item{test}{if \code{TRUE}, code in \code{\\donttest{}}
  will be commented out. If \code{FALSE}, code in
  \code{\\testonly{}} will be commented out.}

  \item{run}{if \code{TRUE}, code in \code{\\dontrun{}}
  will be commented out.}

  \item{fresh}{if \code{TRUE}, will be run in a fresh R
  session. This has the advantage that there's no way the
  examples can depend on anything in the current session,
  but interactive code (like \code{\link{browser}}) won't
  work.}
}
\description{
One of the most frustrating parts of `R CMD check` is
getting all of your examples to pass - whenever one fails
you need to fix the problem and then restart the whole
process.  This function makes it a little easier by making
it possible to run all examples from an R function.
}
\seealso{
Other example functions: \code{\link{dev_example}}
}
\keyword{programming}

