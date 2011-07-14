\name{build_win}
\alias{build_win}
\title{Build windows binary package.}
\usage{
  build_win(pkg = NULL, version = "R-release")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{version}{directory to upload to on the win-builder,
  controlling which version of R is used to build the
  packge. Possible options are listed on
  \url{http://win-builder.r-project.org/}. Defaults to the
  released version of R.}
}
\description{
  Works by building source package, and then uploading to
  \url{http://win-builder.r-project.org/}.  Once building
  is complete you'll recieve a link to the built package in
  the email address listed in the maintainer field.  It
  usually takes around 30 minutes.
}
\seealso{
  Other build functions: \code{\link{build}}
}

