\name{install_version}
\alias{install_version}
\title{Install specified version of a CRAN package.}
\usage{
  install_version(package, version = NULL,
    repos = getOption("repos"),
    type = getOption("pkgType"), archive_structure = TRUE,
    ...)
}
\arguments{
  \item{package}{package name}

  \item{version}{If the specified version is NULL or the
  same as the most recent version of the package, this
  function simply calls \code{\link{install}}. Otherwise,
  it looks at the list of archived source tarballs and
  tries to install an older version instead.}

  \item{archive_structure}{Does the repository have a
  defined archive structure?  When TRUE, the function looks
  for older versions of packages in the
  src/contrib/Archive/packageName directory of the
  repository, like on CRAN. Setting this to FALSE indicates
  that all versions of all packages are located in the
  src/contrib directory of the repository, which is usually
  the case of custom repositories.}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}

  \item{repos}{ character vector, the base URLs of the
  repositories to use, e.g., the URL of a CRAN mirror such
  as \code{"http://cran.us.r-project.org"}.

  Can be \code{NULL} to install from local files (with
  extension \file{.tar.gz} for source packages).  }

  \item{type}{character, indicating the type of package to
  download and install.

  Possible values are \code{"source"},
  \code{"mac.binary.leopard"} and \code{"win.binary"}: the
  binary types can be listed and downloaded but not
  installed on other platforms.

  The default is the appropriate binary type on Windows and
  on the CRAN binary Mac OS X distribution, otherwise
  \code{"source"}.  For the platforms where binary packages
  are the default, an alternative is \code{"both"} which
  means \sQuote{try binary if available, otherwise try
  source}.  (This will only choose the binary package if
  its version number is no older than the source version.)
  }
}
\description{
  If you are installing an package that contains compiled
  code, you will need to have an R development environment
  installed.  You can check if you do by running
  \code{\link{has_devel}}.
}
\author{
  Jeremy Stephens
}
\seealso{
  Other package installation: \code{\link{install}},
  \code{\link{install_bitbucket}},
  \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}
}

