\name{create}
\alias{create}
\title{Creates a new package, following all devtools package conventions.
Similar to package.skeleton, except that it omits the default of adding
current environment variables, instead defaulting to adding no objects.
Also adds the standard devtools conventions.}
\usage{
  create(name, path, environment = new.env(),
    description = c(Package = name, Maintainer = "Who to complain to <yourfault@somewhere.net>", Author = Sys.getenv("USER"), Version = "1.0", License = "GPL-3", Title = "", Description = "", Suggests = "\ntestthat,\nroxygen2"),
    ...)
}
\arguments{
  \item{name}{character string: the package name and
  directory name for your package.}

  \item{path}{to put the package directory in}

  \item{environment}{to be included in the package.
  Defaults to empty environment.}

  \item{description}{names vector of description values to
  add. Note that default values exist, as well.}

  \item{...}{other options passed to
  \code{package.skeleton}}
}
\description{
  Creates a new package, following all devtools package
  conventions. Similar to package.skeleton, except that it
  omits the default of adding current environment
  variables, instead defaulting to adding no objects. Also
  adds the standard devtools conventions.
}
\examples{
# Create a package using all defaults:
path_to_package <- tempdir()
create(name='myDefaultPackage', path=path_to_package)

# Override a description attribute.
# Note that overriding one atribute implies that you must override
# all default attributes, as well.
my_description <- as.list(formals(create)$description)
my_description$Package <- "myCustomPackage"
my_description$Maintainer <- "'Yoni Ben-Meshulam' <yoni@opower.com>"

create(name='myCustomPackage', path=path_to_package, description=my_description)
}

