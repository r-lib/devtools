#' Given an environment or object, return an \code{envlist} of its
#' parent environments.
#'
#' If \code{e} is not specified, it will start with environment from which
#' the function was called.
#'
#' @param e An environment or other object.
#' @param all If \code{FALSE} (the default), stop at the global
#'   environment or the empty environment. If \code{TRUE}, print all
#'   parents, stopping only at the empty environment (which is the
#'   top-level environment).
#' @examples
#' # Print the current environment and its parents
#' parenvs()
#'
#' # Print the parent environments of the load_all function
#' e <- parenvs(load_all)
#' e
#'
#' # Get all parent environments, going all the way to empty env
#' e <- parenvs(load_all, TRUE)
#' e
#'
#' # Print e with paths
#' print(e, path = TRUE)
#'
#' # Print the first 6 environments in the envlist
#' e[1:6]
#'
#' # Print just the parent environment of load_all.
#' # This is an envlist with one element.
#' e[1]
#'
#' # Pull that environment out of the envlist and see what's in it.
#' e[[1]]
#' ls(e[[1]], all.names = TRUE)
#' @export
parenvs <- function(e = parent.frame(), all = FALSE) {
  if (!is.environment(e))  e <- environment(e)
  if (is.null(e))  return(NULL)

  envs <- list(e)
  while (TRUE) {
    if (identical(e, emptyenv())) break
    if (!all && identical(e, globalenv()))  break

    e <- parent.env(e)
    envs <- c(envs, e)
  }
  as.envlist(envs)
}

#' Convert a list of environments to an \code{envlist} object.
#'
#' @param x A list of environments.
#' @export
as.envlist <- function(x) {
  if (!is.list(x) || !all(vapply(x, is.environment, logical(1)))) {
    stop("Cannot convert to envlist: input is not a list of environments.")
  }
  structure(x, class = "envlist")
}

#' @S3method [ envlist
`[.envlist` <- function(x, i) {
  x <- unclass(x)
  as.envlist(x[i])
}

#' Print an \code{envlist}
#'
#' @param x An \code{envlist} object to print.
#' @param name If \code{TRUE} (the default), print the \code{name}
#'   attribute of each environment.
#' @param path If \code{TRUE}, print the \code{path} attribute of
#'   each environment.
#' @param ... Other arguments to be passed to \code{print}.
#' @export
#' @method print envlist
print.envlist <- function(x, name = TRUE, path = FALSE, ...) {

  labels <- vapply(x, format, FUN.VALUE = character(1))
  dat <- data.frame(label = labels, stringsAsFactors = FALSE)

  if (name) {
    names <- vapply(x, FUN.VALUE = character(1),
      function(e) paste('"', attr(e, "name"), '"', sep = ""))
    dat <- cbind(dat, name = names, stringsAsFactors = FALSE)
  }

  if (path) {
    paths <- vapply(x, FUN.VALUE = character(1),
      function(e) paste('"', attr(e, "path"), '"', sep = ""))
    dat <- cbind(dat, path = paths, stringsAsFactors = FALSE)
  }

  print(dat, ..., right = FALSE)

  invisible(x)
}
