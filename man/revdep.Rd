\name{revdep}
\alias{revdep}
\alias{revdep_check}
\alias{revdep_maintainers}
\title{Reverese dependency tools.}
\usage{
  revdep(pkg, dependencies = c("Depends", "Imports"))

  revdep_maintainers(pkg)

  revdep_check(pkg)
}
\arguments{
  \item{pkg}{package name}

  \item{dependencies}{a character vector listing the types
  of dependencies, a subset of \code{c("Depends",
  "Imports", "LinkingTo", "Suggests", "Enhances")}.
  Character string \code{"all"} is shorthand for that
  vector.}
}
\description{
  Tools to check and notify maintainers of all all CRAN and
  bioconductor packages that depend on the specified
  package.
}
\examples{
revdep("ggplot2")
}

