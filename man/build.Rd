\name{build}
\alias{build}
\title{Build package.}
\usage{
build(pkg = ".", path = NULL, binary = FALSE, vignettes = TRUE,
  args = NULL, quiet = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{path}{path in which to produce package.  If
  \code{NULL}, defaults to the parent directory of the
  package.}

  \item{binary}{Produce a binary (\code{--binary}) or
  source ( \code{--no-manual --no-resave-data}) version of
  the package.}

  \item{vignettes}{For source packages: if \code{FALSE},
  don't build PDF vignettes (\code{--no-vignettes}).}

  \item{args}{An optional character vector of additional
  command line arguments to be passed to \code{R CMD build}
  if \code{binary = FALSE}, or \code{R CMD install} if
  \code{binary = TRUE}.}

  \item{quiet}{if \code{TRUE} suppresses output from this
  function.}
}
\value{
a string giving the location (including file name) of the
built package
}
\description{
Building converts a package source directory into a single
bundled file. If \code{binary = FALSE} this creates a
\code{tar.gz} package that can be installed on any
platform, provided they have a full development environment
(although packages without source code can typically be
install out of the box). If \code{binary = TRUE}, the
package will have a platform specific extension (e.g.
\code{.zip} for windows), and will only be installable on
the current platform, but no development environment is
needed.
}
\seealso{
Other build functions: \code{\link{build_win}}
}

