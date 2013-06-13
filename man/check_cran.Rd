\name{check_cran}
\alias{check_cran}
\title{Check a package from CRAN.}
\usage{
  check_cran(pkgs, libpath = file.path(tempdir(), "R-lib"),
    srcpath = libpath, bioconductor = FALSE,
    type = getOption("pkgType"), threads = 1, ...)
}
\arguments{
  \item{pkgs}{Vector of package names - note that unlike
  other \pkg{devtools} functions this is the name of a CRAN
  package, not a path.}

  \item{libpath}{path to library to store dependencies
  packages - if you you're doing this a lot it's a good
  idea to pick a directory and stick with it so you don't
  have to download all the packages every time.}

  \item{srcpath}{path to directory to store source versions
  of dependent packages - again, this saves a lot of time
  because you don't need to redownload the packages every
  time you run the package.}

  \item{bioconductor}{include bioconductor packages in
  checking?}

  \item{type}{binary package type of test}

  \item{threads}{number of concurrent threads to use for
  checking.}

  \item{...}{other parameters passed onto
  \code{\link{download.packages}}}
}
\value{
  invisible \code{TRUE} if successful and no ERRORs or
  WARNINGS,
}
\description{
  This is useful for automatically checking that
  dependencies of your packages work.
}
\details{
  This function does not clean up after itself, but does
  work in a session-specific temporary directory, so all
  files will be removed when your current R session ends.
}
\examples{
\dontrun{
dep <- revdep("ggplot2")
check_cran(dep, "~/documents/ggplot/ggplot-check")
# Or, equivalently:
revdep_check("ggplot2")
}
}

