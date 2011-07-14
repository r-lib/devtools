#' Coerce input to a package.
#' 
#' Possibile specifications of package:
#' \itemize{
#'   \item path
#'   \item name (lookup in .Rpackages)
#'   \item package object
#' }
#' @param x object to coerce to a package
#' @export
as.package <- function(x = NULL) {
  if (is.null(x)) {
    x <- get_last_package()
  }
  if (is.null(x)) {
    stop("No package specified", call. = FALSE)
  }
  
  if (is.package(x)) 
    return(x)
  
  path <- find_package(x)
  if (is.null(path)) {
    stop("Can't find package ", x, call. = FALSE)
  }
  
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
  is_package_path <- function(x) {
    if (is.null(x)) return(FALSE)
    
    desc_path <- file.path(x, "DESCRIPTION")
    file.exists(x) && file.exists(desc_path)
  }
  if (is_package_path(x)) {
    return(x)
  }

  # Look for config file, and give up if it doesn't exist
  config_path <- path.expand("~/.Rpackages")
  if (!file.exists(config_path)) {
    return(NULL)
  }
  lookup <- source(config_path)$value
  
  # Try special case
  if (is_package_path(lookup[[x]])) {
    return(lookup[[x]])
  }

  # Otherwise try default function, if it exists
  if (!is.null(lookup$default)) {
    default_loc <- lookup$default(x)
    if (is_package_path(default_loc)) {
      return(default_loc)
    }
  }

  NULL
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


