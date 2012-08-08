\name{import_dep}
\alias{import_dep}
\title{Load a dependency package.}
\usage{
  import_dep(pkg, dep_name, dep_ver = NA)
}
\arguments{
  \item{pkg}{The package that is doing the importing}

  \item{dep}{The name of the package with objects to
  import}
}
\description{
  All of the exported objects from the dependency are
  copied to the imports environment for the package. This
  will automatically load (but not attach) the dependency
  package.
}
\keyword{internal}

