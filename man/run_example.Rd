\name{run_example}
\alias{run_example}
\title{Run a single example.}
\usage{
  run_example(pkg, topic, strict = FALSE)
}
\arguments{
  \item{topic}{Name or topic (or name of Rd) file to run
  examples for}

  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{strict}{if \code{TRUE}, the package is first
  installed, and then each example is run in a clean R
  environment somewhat mimicking what \code{R CMD check}
  does.  Since this involves installing the package you
  should probably be in \code{\link{dev_mode}}}
}
\description{
  Run a single example.
}
\seealso{
  Other examples: \code{\link{run_examples}}
}

