\name{parent_envs}
\alias{parent_envs}
\title{Given an environment or object, return an \code{envlist} of its
parent environments.}
\usage{
  parent_envs(e = parent.frame())
}
\arguments{
  \item{e}{An environment or other object.}
}
\description{
  If \code{e} is not specified, it will start with
  environment from which the function was called.
}
\examples{
# Print the current environment and its parents
parent_envs()

# Print the parent environments of the load_all function
e <- parent_envs(load_all)
e

# Print e without paths
print(e, path = FALSE)

# Print the first 6 environments in the envlist
e[1:6]

# Print just the parent environment of load_all.
# This is an envlist with one element.
e[1]

# Pull that environment out of the envlist and see what's in it.
e[[1]]
ls(e[[1]], all.names = TRUE)
}

