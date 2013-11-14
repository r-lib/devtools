\name{devtest}
\alias{devtest}
\title{Return the path to one of the packages in the devtools test dir}
\usage{
devtest(package)
}
\arguments{
  \item{package}{Name of the test package.}
}
\description{
  Devtools comes with some simple packages for testing.
  This function returns the path to them.
}
\examples{
if (has_tests()) {
devtest("testData")
}
}
\keyword{internal}

