\name{import_dep}
\alias{import_dep}
\title{Load a package in an "imports" environment.}
\usage{
  import_dep(pkg, dep_name, dep_ver = NA, dep_compare = NA)
}
\arguments{
  \item{pkg}{The package that is doing the importing}

  \item{dep_name}{The name of the package with objects to
  import}

  \item{dep_ver}{The version of the package}

  \item{dep_compare}{The comparison operator to use to
  check the version}
}
\description{
  All of the exported objects from the imported package are
  copied to the imports environment for the development
  package. This will automatically load (but not attach)
  the imported package.
}
\keyword{internal}

