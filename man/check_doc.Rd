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
This function attempts to run the documentation related
checks in the same way that \code{R CMD check} does.
Unfortunately it can't run them all because some tests
require the package to be loaded, and the way they attempt
to load the code conflicts with how devtools does it.
}
\examples{
\dontrun{
document("mypkg")
check_doc("mypkg")
}
}

