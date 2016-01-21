#' Coerce input to a package.
#'
#' Possible specifications of package:
#' \itemize{
#'   \item path
#'   \item package object
#' }
#' @param x object to coerce to a package
#' @param create only relevant if a package structure does not exist yet: if
#'   \code{TRUE}, create a package structure; if \code{NA}, ask the user
#'   (in interactive mode only)
#' @export
#' @keywords internal
as.package <- function(x = NULL, create = NA) {
  if (is.package(x)) return(x)

  x <- package_file(path = x)
  load_pkg_description(x, create = create)
}

#' Find file in a package.
#'
#' It always starts by finding by walking up the path until it finds the
#' root directory, i.e. a directory containing \code{DESCRIPTION}. If it
#' cannot find the root directory, or it can't find the specified path, it
#' will throw an error.
#'
#' @param ... Components of the path.
#' @param path Place to start search for package directory.
#' @export
#' @examples
#' \dontrun{
#' package_file("figures", "figure_1")
#' }
package_file <- function(..., path = ".") {
  if (!is.character(path) || length(path) != 1) {
    stop("`path` must be a string.", call. = FALSE)
  }
  path <- strip_slashes(normalizePath(path, mustWork = FALSE))

  if (!file.exists(path)) {
    stop("Can't find '", path, "'.", call. = FALSE)
  }
  if (!file.info(path)$isdir) {
    stop("'", path, "' is not a directory.", call. = FALSE)
  }

  # Walk up to root directory
  while (!has_description(path)) {
    path <- dirname(path)

    if (is_root(path)) {
      stop("Could not find package root.", call. = FALSE)
    }
  }

  file.path(path, ...)
}

has_description <- function(path) {
  file.exists(file.path(path, 'DESCRIPTION'))
}

is_root <- function(path) {
  identical(path, dirname(path))
}

strip_slashes <- function(x) {
  x <- sub("/*$", "", x)
  x
}

# Load package DESCRIPTION into convenient form.
load_pkg_description <- function(path, create) {
  path_desc <- file.path(path, "DESCRIPTION")

  if (!file.exists(path_desc)) {
    if (is.na(create)) {
      if (interactive()) {
        message("No package infrastructure found in ", path, ". Create it?")
        create <- (menu(c("Yes", "No")) == 1)
      } else {
        create <- FALSE
      }
    }

    if (create) {
      setup(path = path)
    } else {
      stop("No description at ", path_desc, call. = FALSE)
    }
  }

  desc <- as.list(read.dcf(path_desc)[1, ])
  names(desc) <- tolower(names(desc))
  desc$path <- path

  structure(desc, class = "package")
}


#' Is the object a package?
#'
#' @keywords internal
#' @export
is.package <- function(x) inherits(x, "package")

# Mockable variant of interactive
interactive <- function() .Primitive("interactive")()
