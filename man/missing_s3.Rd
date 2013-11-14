\name{missing_s3}
\alias{missing_s3}
\title{Find missing s3 exports.}
\usage{
missing_s3(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  The method is heuristic - looking for objs with a period
  in their name.
}

