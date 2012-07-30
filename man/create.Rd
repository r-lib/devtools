\name{create}
\alias{create}
\title{Creates a new package, following all devtools package conventions.}
\usage{
  create(name, path, environment = new.env(),
    description = list(), ...)
}
\arguments{
  \item{name}{character string: the package name and
  directory name for your package.}

  \item{path}{to put the package directory in}

  \item{environment}{to be included in the package.
  Defaults to empty environment.}

  \item{description}{list of description values to override
  default values or add additional values.}

  \item{...}{other options passed to
  \code{package.skeleton}}
}
\description{
  Similar to package.skeleton, except that it omits the
  default of adding current environment variables, instead
  defaulting to adding no objects. Also adds the standard
  devtools conventions.
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

