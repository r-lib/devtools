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

#' Load all of the imports for a package
#'
#' The imported objects are copied to the imports environment, and are not
#' visible from R_GlobalEnv. This will automatically load (but not attach)
#' the dependency packages.
#'
#' @keywords internal
load_imports <- function(pkg = NULL, deps = c("suggests", "depends", "imports")) {
  pkg <- as.package(pkg)
  deps <- unlist(lapply(pkg[deps], parse_deps))

  if (length(deps) == 0) return(invisible())

  lapply(deps, import_dep, pkg = pkg)

  invisible(deps)
}

#' Load a dependency package.
#'
#' All of the exported objects from the dependency are copied to the
#' imports environment for the package. This will automatically load
#' (but not attach) the dependency package.
#'
#' @param pkg The package that is doing the importing
#' @param dep The name of the package with objects to import
#' @keywords internal
import_dep <- function(pkg, dep) {
  pkg <- as.package(pkg)
  imp_env <- pkg_imports_env(pkg)

  if (!requireNamespace(dep)) {
    return(FALSE)
  }

  # Copy all exported objects from dep to the imports environment.
  # Running getNamespaceExports will automatically load (but not attach)
  # the dependency.
  for (objname in getNamespaceExports(dep)) {
    # I think this should use inherits = FALSE but that seems to cause
    # problems with some packages (hexbin, for example)
    obj <- get(objname, envir = asNamespace(dep))
    assign(objname, obj, envir = imp_env, inherits = FALSE)
  }

  return(TRUE)
}
