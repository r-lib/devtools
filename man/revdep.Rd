\name{revdep}
\alias{revdep}
\alias{revdep_check}
\alias{revdep_maintainers}
\title{Reverse dependency tools.}
\usage{
revdep(pkg = NULL, dependencies = c("Depends", "Imports", "Suggests",
  "LinkingTo"), recursive = FALSE, ignore = NULL)

revdep_maintainers(pkg = ".")

revdep_check(pkg = NULL, recursive = FALSE, ignore = NULL, ...)
}
\arguments{
  \item{pkg}{package name}

  \item{ignore}{A character vector of package names to
  ignore. These packages will not appear in returned
  vector.}

  \item{...}{Other parameters passed on to
  \code{\link{check_cran}}}

  \item{dependencies}{a character vector listing the types
  of dependencies, a subset of \code{c("Depends",
  "Imports", "LinkingTo", "Suggests", "Enhances")}.
  Character string \code{"all"} is shorthand for that
  vector.}

  \item{recursive}{logical: should reverse dependencies of
  reverse dependencies (and so on) be included?}
}
\description{
  Tools to check and notify maintainers of all all CRAN and
  bioconductor packages that depend on the specified
  package.
}
\examples{
\dontrun{
revdep("ggplot2")

revdep("ggplot2", ignore = c("xkcd", "zoo"))
}
}

