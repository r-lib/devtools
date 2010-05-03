#' Load dependencies.
#'
#' Load all package dependencies as described in \code{DESCRIPTION}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
load_deps <- function(pkg) {
  pkg <- as.package(pkg)
  
  if (is.null(pkg$depends)) return(invisible())
  
  deps <- parse_deps(pkg$depends)
  plyr::l_ply(deps, require, character.only = TRUE, quietly = TRUE, 
    warn.conflicts = FALSE)
  
  invisible(deps)
}

#' Parse dependencies.
#' @return character vector of package names
#' @keywords internal
parse_deps <- function(string) {
  library(stringr)
  
  # Remove version specifications
  string <- str_replace(string, "\\s*\\(.*?\\)", "")
  
  # Split into pieces and remove R dependency
  pieces <- str_split(string, ", ")[[1]]
  pieces[pieces != "R"]
}
