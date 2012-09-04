\name{create}
\alias{create}
\title{Creates a new package, following all devtools package conventions.}
\usage{
  create(path, description = list())
}
\arguments{
  \item{path}{location to create new package.  The last
  component of the path will be used as the package name.}

  \item{description}{list of description values to override
  default values or add additional values.}
}
\description{
  Similar to \code{\link{package.skeleton}}, except that it
  only creates the standard devtools directory structures,
  it doesn't try and create source code and data files by
  inspecting the global environment.
}
\examples{
\donttest{
# Create a package using all defaults:
path <- file.path(tempdir(), "myDefaultPackage")
create(path)

# Override a description attribute.
path <- file.path(tempdir(), "myCustomPackage")
my_description <- list("Maintainer" =
  "'Yoni Ben-Meshulam' <yoni@opower.com>")
create(path, my_description)
}
}
\seealso{
  Text with \code{\link{package.skeleton}}
}

