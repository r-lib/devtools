\name{install}
\alias{install}
\title{Install a local development package.}
\usage{
  install(pkg = ".", reload = TRUE, quick = FALSE,
    local = TRUE,
    args = getOption("devtools.install.args"),
    quiet = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{reload}{if \code{TRUE} (the default), will
  automatically reload the package after installing.}

  \item{quick}{if \code{TRUE} skips docs,
  multiple-architectures, demos, and vignettes, to make
  installation as fast as possible.}

  \item{local}{if \code{TRUE} does not build the package
  first, instead installing from the local package
  directory. This may result in build artefacts in your
  package directory, but is considerably faster, and does
  not require a recompile every time you run it.}

  \item{args}{An optional character vector of additional
  command line arguments to bew passed to \code{R CMD
  install}. This defaults to the value of the option
  \code{"devtools.install.args"}.}

  \item{quiet}{if \code{TRUE} suppresses output from this
  function.}
}
\description{
  Uses \code{R CMD INSTALL} to install the package. Will
  also try to install dependencies of the package from
  CRAN, if they're not already installed.
}
\details{
  Installation takes place on a copy of the package
  produced by \code{R CMD build} to avoid modifying the
  local directory in any way.
}
\seealso{
  \code{\link{with_debug}} to install packages with
  debugging flags set.

  Other package installation:
  \code{\link{install_bitbucket}},
  \code{\link{install_git}}, \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}, \code{\link{install_version}}
}

