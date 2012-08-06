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
#' @return list of two character vectors: \code{name} package names,
#'   and \code{version} package versions. If version is not specified,
#'   it will be stored as NA.
#' @keywords internal
parse_deps <- function(string) {
  if (is.null(string)) return()

  pieces <- strsplit(string, ",")[[1]]

  # Get the names
  names <- gsub("\\s*\\(.*?\\)", "", pieces)
  names <- gsub("^\\s+|\\s+$", "", names)

  # Get the versions
  versions <- pieces
  # Assume that version specification is always '>='
  have_version <- grepl("\\(>=.*\\)", versions)
  versions[!have_version] <- NA
  versions <- sub(".*\\(>= ?(.*?)\\)", "\\1", versions)

  # Remove R dependency
  versions <- versions[names != "R"]
  names <- names[names != "R"]

  data.frame(name = names, version = versions, stringsAsFactors = FALSE)
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

  # Get data frame of dependency names and versions
  deps <- lapply(pkg[deps], parse_deps)
  deps <- Reduce(rbind, deps)

  if (nrow(deps) == 0) return(invisible())

  mapply(import_dep, deps$name, deps$version, MoreArgs = list(pkg = pkg))

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
import_dep <- function(pkg, dep_name, dep_ver = NA) {
  pkg <- as.package(pkg)
  imp_env <- pkg_imports_env(pkg)

  if (!requireNamespace(dep_name)) {
    return(FALSE)
  }

  # Assume that version specification is always '>='
  if (!is.na(dep_ver) &&
    as.numeric_version(getNamespaceVersion(dep_name)) <
    as.numeric_version(dep_ver)) {

    warning(pkg$package, " needs ", dep_name, " >=", dep_ver,
      " but loaded version is ", getNamespaceVersion(dep_name))
  }

  # Copy all exported objects from dep to the imports environment.
  # Running getNamespaceExports will automatically load (but not attach)
  # the dependency.
  for (objname in getNamespaceExports(dep_name)) {
    # I think this should use inherits = FALSE but that seems to cause
    # problems with some packages (hexbin, for example)
    obj <- get(objname, envir = asNamespace(dep_name))
    assign(objname, obj, envir = imp_env, inherits = FALSE)
  }

  return(TRUE)
}
