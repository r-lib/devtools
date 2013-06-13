\name{check_doc}
\alias{check_doc}
\title{Check documentation, as \code{R CMD check} does.}
\usage{
  check_doc(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\value{
  Nothing. This function is called purely for it's side
  effects: if
}
\description{
  Currently runs these checks: package parseRd, Rd
  metadata, Rd xrefs, and Rd contents.
}
\examples{
\dontrun{
document("mypkg")
check_doc("mypkg")
}
}

