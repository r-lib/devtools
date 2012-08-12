#' Given an environment or object, return an \code{envlist} of its
#' parent environments.
#'
#' If \code{e} is not specified, it will start with environment from which
#' the function was called.
#'
#' @param e An environment or other object.
#' @examples
#' # Print the current environment and its parents
#' parent_envs()
#'
#' # Print the parent environments of the load_all function
#' e <- parent_envs(load_all)
#' e
#'
#' # Print e without paths
#' print(e, path = FALSE)
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
parent_envs <- function(e = parent.frame()) {
  if (!is.environment(e))  e <- environment(e)
  if (is.null(e))  return(NULL)

  envs <- list(e)
  while (!identical(e, emptyenv())) {
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
#' @param name If \code{TRUE} (the default), print the \code{name}
#'   attribute of each environment.
#' @param path If \code{TRUE} (the default), print the \code{path}
#'   attribute of each environment.
print.envlist <- function(x, name = TRUE, path = TRUE, ...) {
  # Given a vector of strings, pad them with spaces to be the same length
  samelength <- function(s, right = FALSE) {
    juststr <- ifelse(right, "", "-")
    formatstr <- paste("%", juststr, max(nchar(s)), "s", sep = "")
    sprintf(formatstr, s)
  }

  output <- samelength(c("", seq_len(length(x))), right = TRUE)

  labels <- vapply(x, FUN.VALUE = character(1), format)
  labels <- c("label", labels)
  output <- paste(output, samelength(labels))

  if (name) {
    names <- vapply(x, FUN.VALUE = character(1),
      function(e) paste('"', attr(e, "name"), '"', sep = ""))
    names <- c("name", names)
    output <- paste(output, samelength(names))
  }

  if (path) {
    paths <- vapply(x, FUN.VALUE = character(1),
      function(e) paste('"', attr(e, "path"), '"', sep = ""))
    paths <- c("path", paths)
    output <- paste(output, paths)
  }

  for (line in output) {
    cat(line, "\n")
  }

  invisible(x)
}
