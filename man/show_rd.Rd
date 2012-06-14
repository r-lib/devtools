\name{show_rd}
\alias{show_rd}
\title{Show an Rd file in a package.}
\usage{
  show_rd(pkg = NULL, file, ...)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{file}{name of Rd file to open.  Can optionally omit
  Rd extension.}

  \item{...}{additional arguments passed onto
  \code{\link[tools]{Rd2txt}}.  This is particular useful
  if you're checking macros and want to simulate what
  happens when the package is built (\code{stage =
  "build"})}
}
\description{
  Show an Rd file in a package.
}

