\name{create}
\alias{create}
\title{Creates a new package, following all devtools package conventions.}
\usage{
  create(name, path, description = list())
}
\arguments{
  \item{name}{character string: the package name and
  directory name for your package.}

  \item{path}{to put the package directory in}

  \item{description}{list of description values to override
  default values or add additional values.}
}
\description{
  Creates a new package, following all devtools package
  conventions.
}
\examples{
# Create a package using all defaults:
path_to_package <- tempdir()
create(name='myDefaultPackage', path=path_to_package)

# Override a description attribute.
# Note that overriding one atribute implies that you must override
# all default attributes, as well.
my_description <- list("Maintainer"="'Yoni Ben-Meshulam' <yoni@opower.com>")
create(name='myCustomPackage', path=path_to_package, description=my_description)
}
\seealso{
  Text with \code{\link{package.skeleton}}
}

