\name{load_all}
\alias{load_all}
\title{Load complete package.}
\usage{
  load_all(pkg = ".", reset = FALSE, recompile = FALSE,
    export_all = TRUE, quiet = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information.
  If the \code{DESCRIPTION} file does not exist, it is
  created using \code{\link{create_description}}.}

  \item{reset}{clear package environment and reset file
  cache before loading any pieces of the package.}

  \item{recompile}{force a recompile of DLL from source
  code, if present.}

  \item{export_all}{If \code{TRUE} (the default), export
  all objects.  If \code{FALSE}, export only the objects
  that are listed as exports in the NAMESPACE file.}

  \item{quiet}{if \code{TRUE} suppresses output from this
  function.}
}
\description{
  \code{load_all} loads a package. It roughly simulates
  what happens when a package is installed and loaded with
  \code{\link{library}}.
}
\details{
  To unload and reload a package, use \code{reset=TRUE}.
  When reloading a package, A, that another package, B,
  depends on, \code{load_all} might not be able to cleanly
  unload and reload A. If this causes problems, try using
  unloading package B with \code{\link{unload}} before
  using \code{load_all} on A.

  Support for packages with compiled C/C++/Fortran code in
  the \code{/src/} directory is experimental. See
  \code{\link{compile_dll}} for more information about
  compiling code.

  The namespace environment \code{<namespace:pkgname>}, is
  a child of the imports environment, which has the name
  attribute \code{imports:pkgname}. It is in turn is a
  child of \code{<namespace:base>}, which is a child of the
  global environment. (There is also a copy of the base
  namespace that is a child of the empty environment.)

  The package environment \code{<package:pkgname>} is an
  ancestor of the global environment. Normally when loading
  a package, the objects listed as exports in the NAMESPACE
  file are copied from the namespace to the package
  environment. However, \code{load_all} by default will
  copy all objects (not just the ones listed as exports) to
  the package environment. This is useful during
  development because it makes all objects easy to access.

  To export only the objects listed as exports, use
  \code{export_all=FALSE}. This more closely simulates
  behavior when loading an installed package with
  \code{\link{library}}, and can be useful for checking for
  missing exports.

  \code{load_all} also inserts shim functions into the
  imports environment of the laded package. It presently
  adds a replacement version of \code{system.file} which
  returns different paths from \code{base::system.file}.
  This is needed because installed and uninstalled package
  sources have different directory structures. Note that
  this is not a perfect replacement for
  \code{base::system.file}.
}
\examples{
\dontrun{
# Load the package in the current directory
load_all("./")

# Running again loads changed files
load_all("./")

# With reset=TRUE, unload and reload the package for a clean start
load_all("./", TRUE)

# With export_all=FALSE, only objects listed as exports in NAMESPACE
# are exported
load_all("./", export_all = FALSE)
}
}
\seealso{
  \code{\link{unload}}

  \code{\link{compile_dll}}

  \code{\link{clean_dll}}
}
\keyword{programming}

