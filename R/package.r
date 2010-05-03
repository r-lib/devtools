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

is.package <- function(x) inherits(x, "package")
as.package <- function(x) {
  if (is.package(x)) 
    return(x)
  if (file.exists(x)) 
    return(load_pkg_description(x))
  
  home <- file.path("~/documents", x, x)
  if (file.exists(home)) 
    return(load_pkg_description(home))
  
  lookup <- source("~/.Rpackages")$value
  
  if (!is.null(lookup[[x]]))
    return(load_pkg_description(lookup[[x]]))
    
  stop("Can't find package ", x, call. = FALSE)
}