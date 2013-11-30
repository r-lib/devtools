#' Appends new fields to DESCRIPTION file
#' 
#' This is used by the suite of \code{install_*} functions mainly to reduce 
#' code duplication.
#' 
#' @param bundle the package bundle (zip) location
#' @param pkg_path the package (unzipped bundle) location
#' @param prefix The repository name (e.g. Github, Bitbucket). A character 
#' object
#' @param ... the fields to append to the \code{DESCRIPTION} file
#' @return Return a function which will append information related to the source
#' repository (e.g. GitHub, Bitbucket) to the package \code{DESCRIPTION} file.

update_description <- function (bundle, pkg_path, prefix, ...) {  
  
  # Ensure the DESCRIPTION ends with a newline
  desc <- file.path(pkg_path, "DESCRIPTION")
  if (!ends_with_newline(desc))
    cat("\n", sep="", file = desc, append = TRUE)
  
  # Function to append a field to the DESCRIPTION if it's not null
  append_field <- function (name, value) {
    if (!is.null(value)) {
      cat(prefix, name, ":", value, "\n", sep = "", file = desc, 
          append = TRUE)
    }
  }
  
  fields <- list(...)
  Map(append_field, names(fields), fields)    
  
}