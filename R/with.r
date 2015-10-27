#' @rdname devtools-deprecated
#' @section \code{in_dir}:
#' working directory
#' @export
in_dir <- function(new, code) {
  .Deprecated(new = "withr::with_dir", package = "devtools")
  withr::with_dir(new = new, code = code)
}

#' @rdname devtools-deprecated
#' @section \code{with_collate}:
#' collation order
#' @export
with_collate <- function(new, code) {
  .Deprecated(new = "withr::with_collate", package = "devtools")
  withr::with_collate(new = new, code = code)
}

#' @rdname devtools-deprecated
#' @section \code{with_envvar}:
#' environmental variables
#' @export
with_envvar <- function(new, code, action = "replace") {
  .Deprecated(new = "withr::with_envvar", package = "devtools")
  withr::with_envvar(new = new, code = code, action = action)
}

#' @rdname devtools-deprecated
#' @section \code{with_lib}:
#' library paths, prepending to current libpaths
#' @export
with_lib <- function(new, code) {
  .Deprecated(new = "withr::with_libpaths", package = "devtools")
  withr::with_libpaths(new = new, code = code, action = "prefix")
}

#' @rdname devtools-deprecated
#' @section \code{with_libpaths}:
#' library paths, replacing current libpaths
#' @export
with_libpaths <- function(new, code) {
  .Deprecated(new = "withr::with_libpaths", package = "devtools")
  withr::with_libpaths(new = new, code = code, action = "replace")
}

#' @rdname devtools-deprecated
#' @section \code{with_locale}:
#' any locale setting
#' @export
with_locale <- function(new, code) {
  .Deprecated(new = "withr::with_locale", package = "devtools")
  withr::with_locale(new = new, code = code)
}

#' @rdname devtools-deprecated
#' @section \code{with_makevars}:
#' Temporarily change contents of an existing Makevars file.
#' @export
with_makevars <- function(new, code, path = file.path("~", ".R", "Makevars")) {
  .Deprecated(new = "withr::with_makevars", package = "devtools")
  withr::with_makevars(new = new, code = code, path = path)
}

#' @rdname devtools-deprecated
#' @section \code{with_options}:
#' options
#' @export
with_options <- function(new, code) {
  .Deprecated(new = "withr::with_options", package = "devtools")
  withr::with_options(new = new, code = code)
}

#' @rdname devtools-deprecated
#' @section \code{with_par}:
#' graphics parameters
#' @export
with_par <- function(new, code) {
  .Deprecated(new = "withr::with_par", package = "devtools")
  withr::with_par(new = new, code = code)
}

#' @rdname devtools-deprecated
#' @section \code{with_path}:
#' PATH environment variable
#' @export
with_path <- function(new, code, add = TRUE) {
  .Deprecated(new = "withr::with_path", package = "devtools")
  action <- if (isTRUE(add)) {
    "suffix"
  } else {
    "replace"
  }
  withr::with_path(new = new, code = code, action = action)
}
