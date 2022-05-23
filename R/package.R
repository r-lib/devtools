#' Coerce input to a package.
#'
#' Possible specifications of package:
#' \itemize{
#'   \item path
#'   \item package object
#' }
#' @param x object to coerce to a package
#' @param create `r lifecycle::badge("deprecated")` Hasn't worked for some time.
#' @export
#' @keywords internal
as.package <- function(x = NULL, create = deprecated()) {
  if (is.package(x)) return(x)
  if (lifecycle::is_present(create)) {
    lifecycle::deprecate_warn("2.5.0", "as.package(create = )")
  }

  x <- package_file(path = x)
  load_pkg_description(x)
}

#' Find file in a package.
#'
#' It always starts by walking up the path until it finds the root directory,
#' i.e. a directory containing `DESCRIPTION`. If it cannot find the root
#' directory, or it can't find the specified path, it will throw an error.
#'
#' @param ... Components of the path.
#' @param path Place to start search for package directory.
#' @keywords internal
#' @export
#' @examples
#' \dontrun{
#' package_file("figures", "figure_1")
#' }
package_file <- function(..., path = ".") {
  if (!is.character(path) || length(path) != 1) {
    cli::cli_abort("{.arg path} must be a string.")
  }
  if (!dir_exists(path)) {
    cli::cli_abort("{.path {path}} is not a directory.")
  }

  base_path <- path
  path <- strip_slashes(path_real(path))

  # Walk up to root directory
  while (!has_description(path)) {
    path <- path_dir(path)

    if (is_root(path)) {
      cli::cli_abort(c(
        "Could not find package root.",
        i = "Is {.path {base_path}} inside a package?"
      ))
    }
  }

  path(path, ...)
}

has_description <- function(path) {
  file_exists(path(path, "DESCRIPTION"))
}

is_root <- function(path) {
  identical(path, path_dir(path))
}

strip_slashes <- function(x) {
  x <- sub("/*$", "", x)
  x
}

# Load package DESCRIPTION into convenient form.
load_pkg_description <- function(path) {
  path_desc <- path(path, "DESCRIPTION")

  info <- read.dcf(path_desc)[1, ]
  Encoding(info) <- 'UTF-8'
  desc <- as.list(info)
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
