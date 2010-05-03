\name{trace_all}
\alias{trace_all}
\title{Trace multiple functions with same tracer.}
\usage{trace_all(fs, tracer)}

\description{
  Trace multiple functions with same tracer.
}
\keyword{programming}
\examples{trace_all(
functions_with_arg("na.rm", "package:base"), 
quote(if (!na.rm) warning("na.rm = FALSE"))
)
trace_all(
functions_with_arg("drop", "package:base"), 
quote(if (drop) warning("drop = TRUE"))
)}
