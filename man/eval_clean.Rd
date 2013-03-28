\name{eval_clean}
\alias{eval_clean}
\alias{evalq_clean}
\title{Evaluate code in a clean R session.}
\usage{
  eval_clean(expr, quiet = TRUE)

  evalq_clean(expr, quiet = TRUE)
}
\arguments{
  \item{expr}{an R expression to evaluate. For
  \code{eval_clean} this should already be quoted. For
  \code{evalq_clean} it will be quoted for you.}

  \item{quiet}{if \code{TRUE}, the default, only the final
  result and the any explicitly printed output will be
  displayed. If \code{FALSE}, all input and output will be
  displayed, as if you'd copied and paste the code.}
}
\value{
  An invisible \code{TRUE} on success.
}
\description{
  Evaluate code in a clean R session.
}
\examples{
x <- 1
y <- 2
ls()
evalq_clean(ls())
evalq_clean(ls(), FALSE)
eval_clean(quote({
  z <- 1
  ls()
}))
}

