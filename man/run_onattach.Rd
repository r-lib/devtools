\name{run_onattach}
\alias{run_onattach}
\title{Run .onAttach if needed}
\usage{
  run_onattach(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  This is run after copying objects from the namespace to
  the package environment. In a normal install + load, the
  namespace would be locked between these stages, but we
  don't do that with load_all.
}
\details{
  A variable called \code{onAttach} is created in the
  package's devtools metdata to indicate that it's
  attached.
}

