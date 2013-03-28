#' Sources an R file in a clean environment.
#'
#' Opens up a fresh R environment and sources file, ensuring that it works
#' independently of the current working environment.
#'
#' @param path path to R script
#' @param quiet If \code{FALSE}, the default, all input and output will be
#'   displayed, as if you'd copied and paste the code.  If \code{TRUE}
#'   only the final result and the any explicitly printed output will be
#'   displayed.
#' @export
clean_source <- function(path, quiet = FALSE) {
  stopifnot(file.exists(path))

  opts <- paste("--quiet --file=", shQuote(path), sep = "")
  if (quiet) opts <- paste(opts, "--slave")
  R(opts, dirname(path))
}

#' Evaluate code in a clean R session.
#'
#' @export
#' @param expr an R expression to evaluate. For \code{eval_clean} this should
#'   already be quoted. For \code{evalq_clean} it will be quoted for you.
#' @param quiet if \code{TRUE}, the default, only the final result and the
#'   any explicitly printed output will be displayed. If \code{FALSE}, all
#'   input and output will be displayed, as if you'd copied and paste the code.
#' @return An invisible \code{TRUE} on success.
#' @examples
#' x <- 1
#' y <- 2
#' ls()
#' evalq_clean(ls())
#' evalq_clean(ls(), FALSE)
#' eval_clean(quote({
#'   z <- 1
#'   ls()
#' }))
eval_clean <- function(expr, quiet = TRUE) {
  stopifnot(is.language(expr))

  tmp <- tempfile()
  on.exit(unlink(tmp))

  text <- deparse(expr)
  writeLines(text, tmp)

  suppressMessages(clean_source(tmp, quiet = quiet))
  invisible(TRUE)
}

#' @export
#' @rdname eval_clean
evalq_clean <- function(expr, quiet = TRUE) {
  eval_clean(substitute(expr), quiet = quiet)
}
