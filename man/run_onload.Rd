\name{run_onload}
\alias{run_onload}
\title{Run .onLoad if needed}
\usage{
  run_onload(pkg = NULL)
}
\description{
  This is run before copying objects from the namespace to
  the package environment. In a normal install + load, the
  namespace would be locked between these stages, but we
  don't do that with load_all.
}
\details{
  devtools creates a variable called .__loaded in the
  namespace to indicate that it's attached.
}

