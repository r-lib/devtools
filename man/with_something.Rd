\name{with_something}
\alias{in_dir}
\alias{with_collate}
\alias{with_env}
\alias{with_libpaths}
\alias{with_locale}
\alias{with_options}
\alias{with_par}
\alias{with_path}
\alias{with_something}
\title{Execute code in temporarily altered environment.}
\usage{
  with_env(new, code)

  with_locale(new, code)

  with_collate(new, code)

  in_dir(new, code)

  with_libpaths(new, code)

  with_options(new, code)

  with_par(new, code)

  with_path(new, code, add = TRUE)
}
\arguments{
  \item{new}{values for setting}

  \item{code}{code to execute in that environment}

  \item{add}{Combine with existing values? Currently for
  \code{\link{with_path}} only. If \code{FALSE} all
  existing paths are ovewritten, which don't you usually
  want.}
}
\description{
  \itemize{ \item \code{in_dir}: working directory \item
  \code{with_collate}: collation order \item
  \code{with_env}: environmental variables \item
  \code{with_libpaths}: library paths \item
  \code{with_locale}: any locale setting \item
  \code{with_options}: options \item \code{with_path}: PATH
  environment variable \item \code{with_par}: graphics
  parameters }
}
\examples{
getwd()
in_dir(tempdir(), getwd())
getwd()

Sys.getenv("HADLEY")
with_env(c("HADLEY" = 2), Sys.getenv("HADLEY"))
Sys.getenv("HADLEY")
}

