\name{dev_example}
\alias{dev_example}
\title{Run a examples for an in-development function.}
\usage{
  dev_example(topic, strict = FALSE)
}
\arguments{
  \item{topic}{Name or topic (or name of Rd) file to run
  examples for}

  \item{strict}{if \code{TRUE}, the package is first
  installed, and then each example is run in a clean R
  environment somewhat mimicking what \code{R CMD check}
  does.  Since this involves installing the package you
  should probably be in \code{\link{dev_mode}}}
}
\description{
  Run a examples for an in-development function.
}
\examples{
\dontrun{
# Runs installed example:
library("ggplot2")
example("ggplot")

# Runs develoment example:
load_all("ggplot2")
dev_example("ggplot")
}
}
\seealso{
  Other example functions: \code{\link{run_examples}}
}

