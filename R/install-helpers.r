#' Appends new fields to DESCRIPTION file
#' 
#' This is used by the suite of \code{install_*} functions. 
#' 
#' @param prefix The repository name (e.g. Github, Bitbucket)
#' @param ... the fields to append to the \code{DESCRIPTION} file
#' @return Return a function which will append information related to the source
#' repository (e.g. GitHub, Bitbucket) to the package \code{DESCRIPTION} file.

update_description <- function (prefix, ...) {  
  
  function (bundle, pkg_path) {
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
  
}
