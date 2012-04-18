\name{load_deps}
\alias{load_deps}
\title{Load dependencies.}
\usage{
  load_deps(pkg = NULL,
    deps = c("suggests", "depends", "imports"))
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{deps}{dependencies to be loaded (e.g. "depends",
  "imports", "suggests", "enhances")}
}
\description{
  Load all package dependencies as described in
  \code{DESCRIPTION}.
}
\keyword{programming}

