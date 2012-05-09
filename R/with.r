#' Execute code in temporarily altered environment.
#'
#' \itemize{
#'   \item \code{in_dir}: working directory
#'   \item \code{with_collate}: collation order
#'   \item \code{with_env}: environmental variables
#'   \item \code{with_libpaths}: library paths
#'   \item \code{with_locale}: any locale setting
#'   \item \code{with_options}: options
#'   \item \code{with_par}: graphics parameters
#' }
#' @param new values for setting
#' @param code code to execute in that environment 
#'
#' @name with_something
#' @examples
#' getwd()
#' in_dir(tempdir(), getwd())
#' getwd()                     
#'
#' Sys.getenv("HADLEY")
#' with_env(c("HADLEY" = 2), Sys.getenv("HADLEY"))
#' Sys.getenv("HADLEY")
NULL

with_something <- function(set) {
  function(new, code) { 
    old <- set(new)
    on.exit(set(old))
    force(code)
  }  
}
is.named <- function(x) {
  !is.null(names(x)) && all(names(x) != "")
}

set_env <- function(...) {
  envs <- c(...)
  stopifnot(is.named(envs))

  old <- Sys.getenv(names(envs), names = TRUE)
  do.call("Sys.setenv", as.list(envs))
  invisible(old)
}
#' @rdname with_something
with_env <- with_something(set_env)

# old <- set_locale(LC_TIME = "de_DE", LC_COLLATE = "de_DE")
# set_locale(old)

set_locale <- function(...) {
  cats <- c(...)
  stopifnot(is.named(cats))
  
  old <- vapply(names(cats), Sys.getlocale, character(1))

  mapply(Sys.setlocale, names(cats), cats)
  invisible(old)
}

#' @rdname with_something
with_locale <- with_something(set_locale)

set_collate <- function(locale) set_locale(LC_COLLATE = locale)
#' @rdname with_something
with_collate <- with_something(set_collate)

#' @rdname with_something
in_dir <- with_something(setwd)

set_libpaths <- function(...) {
  paths <- c(...)
  libpath <- normalizePath(paths, mustWork = TRUE)
  
  old <- .libPaths()
  .libPaths(paths)
  invisible(old)
}

#' @rdname with_something
with_libpaths <- with_something(set_libpaths)

#' @rdname with_something
with_options <- with_something(options)

#' @rdname with_something
with_par <- with_something(par)
