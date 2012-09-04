\name{build_vignettes}
\alias{build_vignettes}
\title{Build package vignettes.}
\usage{
  build_vignettes(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  Sweave and latex package vignettes.  Sweaving and
  latexing is carried out in a temporary directory so that
  compilation artefacts don't pollute the source package -
  only the final pdf is copied to \file{inst/doc}.
}
\seealso{
  \code{\link{clean_vignettes}} to remove the pdfs in
  \file{inst/doc} created from vignettes
}
\keyword{programming}

