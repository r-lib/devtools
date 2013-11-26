\name{clean_vignettes}
\alias{clean_vignettes}
\title{Clean built vignettes.}
\usage{
clean_vignettes(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
This uses a fairly rudimentary algorithm where any files in
\file{inst/doc} with a name that exists in \file{vignettes}
are removed.
}

