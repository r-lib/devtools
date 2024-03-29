% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/release.R
\name{submit_cran}
\alias{submit_cran}
\title{Submit a package to CRAN}
\usage{
submit_cran(pkg = ".", args = NULL)
}
\arguments{
\item{pkg}{The package to use, can be a file path to the package or a
package object.  See \code{\link[=as.package]{as.package()}} for more information.}

\item{args}{An optional character vector of additional command
line arguments to be passed to \verb{R CMD build}.}
}
\description{
This submits your package to CRAN using the web-form submission process.
After submission, you will receive an email asking you to confirm submission
\itemize{
\item this is used to check that the package is submitted by the maintainer.
}

You may prefer to use \code{submit_cran()} indirectly, by calling \code{\link[=release]{release()}}
instead. \code{release()} performs many checks verifying that your package is
indeed ready for CRAN, before eventually asking for your confirmation that
you'd like to submit it to CRAN (which it does by calling \code{submit_cran()}).

Whether to use \code{release()} or \code{submit_cran()} depends on the rest of your
development process. If you want to be super cautious, use \code{release()}, even
though it may be redundant with other checks you have performed. On the other
hand, if you have many other checks in place (such as automated checks via
GitHub Actions and the task list generated by
\code{\link[usethis:use_release_issue]{usethis::use_release_issue()}}), it makes sense to use \code{submit_cran()}
directly.
}
\keyword{internal}
