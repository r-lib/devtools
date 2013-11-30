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

if (has_tests()) {
# Load the test package in directory "testLoadHooks"
load_all(devtest("testLoadHooks"))

# Get metdata for the package
x <- dev_meta("testLoadHooks")
as.list(x)

# Clean up.
unload(devtest("testLoadHooks"))
}
}
\keyword{internal}

