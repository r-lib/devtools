\name{clean_source}
\alias{clean_source}
\title{Sources an R file in a clean environment.}
\usage{
  clean_source(path, vanilla = FALSE)
}
\arguments{
  \item{path}{path to R script}

  \item{vanilla}{if \code{TRUE} tells R not to use any
  system specific settings.}
}
\description{
  Opens up a fresh R environment and sources file, ensuring
  that it works independently of the current working
  environment.
}

