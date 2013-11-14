\name{parse_ns_file}
\alias{parse_ns_file}
\title{Parses the NAMESPACE file for a package}
\usage{
parse_ns_file(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  Parses the NAMESPACE file for a package
}
\examples{
if (has_tests()) {
parse_ns_file(devtest("testLoadHooks"))
}
}
\keyword{internal}

