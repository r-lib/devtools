#' Coerce input to a package.
#'
#' Possible specifications of package:
#' \itemize{
#'   \item path
#'   \item package object
#' }
#' @param x object to coerce to a package
#' @export
as.package <- function(x = NULL) {
  if (is.package(x)) return(x)

  if (is.null(x)) {
    stop("pkg must not be NULL", call. = FALSE)
  }

  path <- find_package(x)

  pkg <- load_pkg_description(path)
}


find_package <- function(x, check_desc = TRUE) {
  if (is.null(x)) return(FALSE)

  # Strip trailing slashes (needed only for windows)
  x <- normalizePath(x, mustWork = FALSE)
  x <- gsub("\\\\$", "", x)

  if (!file.exists(x)) {
    stop("Can't find directory ", x, call. = FALSE)
  }
  if (!file.info(x)$isdir) {
    stop(x, " is not a directory", call. = FALSE)
  }

  desc_path <- file.path(x, "DESCRIPTION")
  if (check_desc && !file.exists(desc_path)) {
    stop("No DESCRIPTION file found in ", x, call. = FALSE)
  }

  x
}

#' Load package DESCRIPTION into convenient form.
#' @keywords internal
load_pkg_description <- function(path) {
  path <- normalizePath(path)
  path_desc <- file.path(path, "DESCRIPTION")

  if (!file.exists(path_desc)) {
    stop("No description at ", path_desc, call. = FALSE)
  }

  desc <- as.list(read.dcf(path_desc)[1, ])
  names(desc) <- tolower(names(desc))
  desc$path <- path

  structure(desc, class = "package")
}


#' Is the object a package?
#' @keywords internal
#' @export
is.package <- function(x) inherits(x, "package")


