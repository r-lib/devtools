\name{update_description}
\alias{update_description}
\title{Appends new fields to DESCRIPTION file}
\usage{
update_description(bundle, pkg_path, prefix, ...)
}
\arguments{
  \item{bundle}{the package bundle (zip) location}

  \item{pkg_path}{the package (unzipped bundle) location}

  \item{prefix}{The repository name (e.g. Github,
  Bitbucket). A character object}

  \item{...}{the fields to append to the \code{DESCRIPTION}
  file}
}
\value{
Return a function which will append information related to
the source repository (e.g. GitHub, Bitbucket) to the
package \code{DESCRIPTION} file.
}
\description{
This is used by the suite of \code{install_*} functions
mainly to reduce code duplication.
}

