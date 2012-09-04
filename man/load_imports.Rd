\name{load_imports}
\alias{load_imports}
\title{Load all of the imports for a package}
\usage{
  load_imports(pkg = ".", deps = c("depends", "imports"))
}
\description{
  The imported objects are copied to the imports
  environment, and are not visible from R_GlobalEnv. This
  will automatically load (but not attach) the dependency
  packages.
}
\keyword{internal}

