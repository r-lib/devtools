\name{install_version}
\alias{install_version}
\title{Install specified version of a CRAN package.}
\usage{
  install_version(package, version = NULL,
    repos = getOption("repos"),
    type = getOption("pkgType"), ...)
}
\arguments{
  \item{package}{package name}

  \item{version}{If the specified version is NULL or the
  same as the most recent version of the package, this
  function simply calls \code{\link{install}}. Otherwise,
  it looks at the list of archived source tarballs and
  tries to install an older version instead.}

  \item{...}{Other arguments passed on to
  \code{\link{install}}.}

  \item{repos}{ character vector, the base URL(s) of the
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
  on the CRAN binary OS X distribution, otherwise
  \code{"source"}.  For the platforms where binary packages
  are the default, an alternative is \code{"both"} which
  means \sQuote{try binary if available, otherwise try
  source}.  (This will only choose the binary package if
  its version number is no older than the source version.
  In interactive use it will ask before attempting to
  install source packages.)  }
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
  \code{\link{install_git}}, \code{\link{install_github}},
  \code{\link{install_gitorious}},
  \code{\link{install_url}}
}

