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
    last <- get_last_package()
    if (!is.null(last)) return(last)
    
    message("No package specified, using working directory.")
    x <- "."
  }
  
  path <- find_package(x)
  
  pkg <- load_pkg_description(path)
  set_last_package(pkg)
}

get_last_package <- NULL
set_last_package <- NULL
local({
  package <- NULL
  
  get_last_package <<- function() {
    package
  }
  set_last_package <<- function(x) {
    package <<- x
    x
  }

})

find_package <- function(x) {
  if (is.null(x)) return(FALSE)

  # Strip trailing slashes (needed only for windows)
  x <- normalizePath(x, mustWork = FALSE)
  x <- gsub("\\\\$", "", x)

  desc_path <- file.path(x, "DESCRIPTION")

  if ( file.exists(x) && file.exists(desc_path)) {
    return(x)
  } else {
    stop("Can't find package at '", file.path(normalizePath("."), x)
      , "'", call. = FALSE)
  }
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


