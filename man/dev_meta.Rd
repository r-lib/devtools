\name{dev_meta}
\alias{dev_meta}
\title{Return devtools metadata environment}
\usage{
  dev_meta(name, create = FALSE)
}
\arguments{
  \item{name}{The name of a loaded package}

  \item{create}{If the metadata environment does not exist,
  create it?  For internal use only.}
}
\description{
  Return devtools metadata environment
}
\examples{
# Load the test package in directory "load-hooks"
load_all(devtest("load-hooks"))

# Get metdata for the package
# (The name of the package in DESCRIPTION is "loadhooks")
x <- dev_meta("loadhooks")
as.list(x)

# Clean up.
unload(devtest("load-hooks"))
}

