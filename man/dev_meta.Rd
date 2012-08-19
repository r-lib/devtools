\name{dev_meta}
\alias{dev_meta}
\title{Return devtools metadata environment}
\usage{
  dev_meta(name)
}
\arguments{
  \item{name}{The name of a loaded package}
}
\description{
  If the package was not loaded with devtools, returns
  \code{NULL}.
}
\examples{
dev_meta("stats") # NULL

# Load the test package in directory "load-hooks"
load_all(devtest("load-hooks"))

# Get metdata for the package
# (The name of the package in DESCRIPTION is "loadhooks")
x <- dev_meta("loadhooks")
as.list(x)

# Clean up.
unload(devtest("load-hooks"))
}

