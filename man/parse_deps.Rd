\name{parse_deps}
\alias{parse_deps}
\title{Parse package dependency strings.}
\usage{
parse_deps(string)
}
\arguments{
  \item{string}{to parse. Should look like \code{"R (>=
  3.0), ggplot2"} etc.}
}
\value{
list of two character vectors: \code{name} package names,
and \code{version} package versions. If version is not
specified, it will be stored as NA.
}
\description{
Parse package dependency strings.
}
\examples{
parse_deps("httr (< 2.1),\\nRCurl (>= 3)")
# only package dependencies are returned
parse_deps("utils (== 2.12.1),\\ntools,\\nR (>= 2.10),\\nmemoise")
}
\keyword{internal}

