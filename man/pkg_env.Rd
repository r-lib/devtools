\name{pkg_env}
\alias{pkg_env}
\title{Generate a package environment}
\usage{
  pkg_env(pkg = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  This is an environment like \code{<package:pkg>}. It is
  attached, so it is an ancestor of \code{R_GlobalEnv}.
}
\details{
  When a package is loaded the normal way, using
  \code{\link{library}}, this environment contains only the
  exported objects from the namespace. However, when loaded
  with \code{\link{load_all}}, this environment will
  contain all the objects from the namespace.
}

