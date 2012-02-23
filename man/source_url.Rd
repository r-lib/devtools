\name{source_url}
\alias{source_url}
\title{Run a script through some protocols such as http, https, ftp, etc.}
\usage{
  source_url(url, ...)
}
\arguments{
  \item{url}{url}

  \item{...}{other options passed to \code{\link{source}}}
}
\description{
  Internally, \code{source_url} calls \code{\link{getURL}}
  in \code{RCurl} package and then read the contents by
  \code{\link{textConnection}}, which is then
  \code{\link{source}}ed. See \code{?getURL} for the
  available protocol.
}
\examples{
\dontrun{
source_url("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")
}
}

