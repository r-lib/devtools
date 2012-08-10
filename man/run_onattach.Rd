\name{run_onattach}
\alias{run_onattach}
\title{Run .onAttach if needed}
\usage{
  run_onattach(pkg = NULL)
}
\description{
  This is run after copying objects from the namespace to
  the package environment. In a normal install + load, the
  namespace would be locked between these stages, but we
  don't do that with load_all.
}
\details{
  devtools creates a variable called .__attached in the
  namespace to indicate that it's attached.
}

