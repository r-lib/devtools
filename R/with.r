#' Execute code in temporarily altered environment.
#'
#' \itemize{
#'   \item \code{in_dir}: working directory
#'   \item \code{with_collate}: collation order
#'   \item \code{with_env}: environmental variables
#'   \item \code{with_libpaths}: library paths, replacing current libpaths
#'   \item \code{with_lib}: library paths, prepending to current libpaths
#'   \item \code{with_locale}: any locale setting
#'   \item \code{with_options}: options
#'   \item \code{with_path}: PATH environment variable
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

# env ------------------------------------------------------------------------

set_env <- function(envs) {
  stopifnot(is.named(envs))

  old <- Sys.getenv(names(envs), names = TRUE, unset = NA)
  
  set <- !is.na(envs)
  if (any(set)) do.call("Sys.setenv", as.list(envs[set]))
  if (any(!set)) Sys.unsetenv(names(envs)[!set])
  
  invisible(old)
}
#' @rdname with_something
#' @export
with_env <- with_something(set_env)

# locale ---------------------------------------------------------------------

set_locale <- function(cats) {
  stopifnot(is.named(cats), is.character(cats))

  old <- vapply(names(cats), Sys.getlocale, character(1))

  mapply(Sys.setlocale, names(cats), cats)
  invisible(old)
}

#' @rdname with_something
#' @export
with_locale <- with_something(set_locale)

# collate --------------------------------------------------------------------

set_collate <- function(locale) set_locale(c(LC_COLLATE = locale))[[1]]
#' @rdname with_something
#' @export
with_collate <- with_something(set_collate)

# working directory ----------------------------------------------------------

#' @rdname with_something
#' @export
in_dir <- with_something(setwd)

# libpaths -------------------------------------------------------------------

set_libpaths <- function(paths) {
  libpath <- normalizePath(paths, mustWork = TRUE)

  old <- .libPaths()
  .libPaths(paths)
  invisible(old)
}

#' @rdname with_something
#' @export
with_libpaths <- with_something(set_libpaths)

# lib ------------------------------------------------------------------------

set_lib <- function(paths) {
  libpath <- normalizePath(paths, mustWork = TRUE)

  old <- .libPaths()
  .libPaths(c(libpath, .libPaths()))
  invisible(old)
}

#' @rdname with_something
#' @export
with_lib <- with_something(set_lib)

# options --------------------------------------------------------------------

#' @rdname with_something
#' @export
with_options <- with_something(options)

# par ------------------------------------------------------------------------

#' @rdname with_something
#' @export
with_par <- with_something(par)

# path -----------------------------------------------------------------------

#' @rdname with_something
#' @export
#' @param add Combine with existing values? Currently for
#'   \code{\link{with_path}} only. If \code{FALSE} all existing
#'   paths are ovewritten, which don't you usually want.
with_path <- function(new, code, add = TRUE) {
  if (add) new <- c(get_path(), new)
  old <- set_path(new)
  on.exit(set_path(old))
  force(code)
}
