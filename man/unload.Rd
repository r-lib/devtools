\name{unload}
\alias{unload}
\title{Unload a package}
\usage{
unload(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
This function attempts to cleanly unload a package,
including unloading it's namespace, deleting S4 class
definitions and unloading any loaded DLLs. Unfortunately S4
classes are not really designed to be cleanly unloaded, and
so we have to manually modify the class dependency graph in
order for it to work - this works on the cases for which we
have tested but there may be others.  Similarly, automated
DLL unloading is best tested for simple scenarios
(particularly with \code{useDynLib(pkgname)} and may fail
in other cases. If you do encounter a failure, please file
a bug report at
\url{http://github.com/hadley/devtools/issues}.
}
\examples{
\dontrun{
# Unload package that is in current directory
unload(".")

# Unload package that is in ./ggplot2/
unload("ggplot2/")

# Can use inst() to find the path of an installed package
# This will load and unload the installed ggplot2 package
library(ggplot2)
unload(inst("ggplot2"))
}
}

