\name{create_description}
\alias{create_description}
\title{Create a default DESCRIPTION file for a package.}
\usage{
  create_description(path,
    extra = getOption("devtools.desc"), quiet = FALSE)
}
\description{
  Create a default DESCRIPTION file for a package.
}
\details{
  To set the default author and licenses, set
  \code{options} \code{devtool.author} and
  \code{devtool.license}.  I use
  \code{options(devtools.author = '"Hadley Wickham
  <h.wickham@gmail.com> [aut,cre]"', devtools.license =
  "GPL-3")}.
}

