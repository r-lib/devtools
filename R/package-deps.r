#' Load dependencies.
#'
#' Load all package dependencies as described in \code{DESCRIPTION}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param deps dependencies to be loaded (e.g. "depends", "imports", "suggests", "enhances")
#' @keywords programming
#' @export
load_deps <- function(pkg = NULL, deps = c("suggests", "depends", "imports")) {
  pkg <- as.package(pkg)
  deps <- unlist(lapply(pkg[deps], parse_deps))
  
  if (length(deps) == 0) return(invisible())
  
  lapply(deps, require, character.only = TRUE, quietly = TRUE, 
    warn.conflicts = FALSE)
  
  invisible(deps)
}

#' Parse dependencies.
#' @return character vector of package names
#' @keywords internal
parse_deps <- function(string) {
  if (is.null(string)) return()
  
  # Remove version specifications
  string <- gsub("\\s*\\(.*?\\)", "", string)
  
  # Split into pieces and remove R dependency
  pieces <- strsplit(string, ",")[[1]]
  pieces <- gsub("^\\s+|\\s+$", "", pieces)
  pieces[pieces != "R"]
}
