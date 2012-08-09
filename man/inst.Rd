\name{inst}
\alias{inst}
\title{Get the installation path of a package}
\usage{
  inst(name)
}
\arguments{
  \item{name}{the name of a package or the installation dir
  of a package. If it's a directory, a relative path may be
  used.}
}
\description{
  Given the name of a package, this returns a path to the
  package, which can be passed to other devtools functions.
}
\details{
  This will first check if there's a loaded package
  matching the name. If so, it will return the \code{path}
  attribute of the package environment.

  Next it will look for a directory with the name. Finally,
  it will search in the lib paths for a directory with that
  name. If multiple dirs are found, it will return the
  first one.
}
\examples{
inst(".")
inst("devtools")
inst("grid")
\dontrun{
# Can be passed to other devtools functions
unload(inst("ggplot2"))
}
}

