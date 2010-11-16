#' Coerce input to a package.
#' 
#' Possibile specifications of package:
#'
#' \itemize{
#'   \item path
#'   \item name (lookup in .Rpackages)
#'   \item package object
#' }
#' @param x object to coerce to a package
#' @export
as.package <- function(x) {
  if (is.package(x)) 
    return(x)
  
  path <- find_package(x)
  if (is.null(path)) {
    stop("Can't find package ", x, call. = FALSE)
  }
    
  load_pkg_description(path)
}

find_package <- function(x) {
  if (file.exists(x)) 
    return(x)

  # If .Rpackages exists, use that to find the package locations
  config_path <- path.expand("~/.Rpackages")
  if (file.exists(config_path)) {
    lookup <- source(config_path)$value
    
    # Try default function, if it exists
    if (!is.null(lookup$default)) {
      default_loc <- lookup$default(x)
      if (file.exists(default_loc)) 
        return(default_loc)
    }
    
    # Otherwise try special cases
    if (!is.null(lookup[[x]]))
      return(lookup[[x]])
  }
  NULL
}

#' Load package DESCRIPTION into convenient form.
#' @keywords internal
load_pkg_description <- function(path) {
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


