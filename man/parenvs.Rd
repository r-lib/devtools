\name{parenvs}
\alias{parenvs}
\title{Given an environment or object, return an \code{envlist} of its
parent environments.}
\usage{
  parenvs(e = parent.frame(), all = FALSE)
}
\arguments{
  \item{e}{An environment or other object.}

  \item{all}{If \code{FALSE} (the default), stop at the
  global environment or the empty environment. If
  \code{TRUE}, print all parents, stopping only at the
  empty environment (which is the top-level environment).}
}
\description{
  If \code{e} is not specified, it will start with
  environment from which the function was called.
}
\examples{
# Print the current environment and its parents
parenvs()

# Print the parent environments of the load_all function
e <- parenvs(load_all)
e

# Get all parent environments, going all the way to empty env
e <- parenvs(load_all, TRUE)
e

# Print e with paths
print(e, path = TRUE)

# Print the first 6 environments in the envlist
e[1:6]

# Print just the parent environment of load_all.
# This is an envlist with one element.
e[1]

# Pull that environment out of the envlist and see what's in it.
e[[1]]
ls(e[[1]], all.names = TRUE)
}

