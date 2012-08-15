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

  # Get the versions and comparison operators
  versions_str <- pieces
  have_version <- grepl("\\(.*\\)", versions_str)
  versions_str[!have_version] <- NA

  compare  <- sub(".*\\((\\S+)\\s+.*\\)", "\\1", versions_str)
  versions <- sub(".*\\(\\S+\\s+(.*)\\)", "\\1", versions_str)

  # Check that non-NA comparison operators are valid
  compare_nna   <- compare[!is.na(compare)]
  compare_valid <- compare_nna %in% c(">", ">=", "==", "<=", "<")
  if(!all(compare_valid)) {
    stop("Invalid comparison operator in dependency: ",
      paste(compare_nna[!compare_valid], collapse = ", "))
  }

  deps <- data.frame(name = names, compare = compare,
    version = versions, stringsAsFactors = FALSE)

  # Remove R dependency
  deps[names != "R", ]
}

#' Load all of the imports for a package
#'
#' The imported objects are copied to the imports environment, and are not
#' visible from R_GlobalEnv. This will automatically load (but not attach)
#' the dependency packages.
#'
#' @keywords internal
load_imports <- function(pkg = NULL, deps = c("depends", "imports")) {
  pkg <- as.package(pkg)

  # Get data frame of dependency names and versions
  deps <- lapply(pkg[deps], parse_deps)
  deps <- Reduce(rbind, deps)

  if (is.null(deps) || nrow(deps) == 0) return(invisible())

  # If we've already loaded imports, don't load again (until load_all
  # is run with reset=TRUE). This is to avoid warnings when running
  # process_imports()
  if (length(ls(imports_env(pkg))) > 0) return(invisible(deps))

  mapply(check_dep_version, deps$name, deps$version, deps$compare)

  process_imports(pkg)

  invisible(deps)
}

#' Check that the version of an imported package satisfies the requirements
#'
#' @param dep_name The name of the package with objects to import
#' @param dep_ver The version of the package
#' @param dep_compare The comparison operator to use to check the version
#' @keywords internal
check_dep_version <- function(dep_name, dep_ver = NA, dep_compare = NA) {
  if (!requireNamespace(dep_name, quietly = TRUE)) {
    stop("Dependency package ", dep_name, " not available.")
  }

  if (xor(is.na(dep_ver), is.na(dep_compare))) {
    stop("dep_ver and dep_compare must be both NA or both non-NA")

  } else if(!is.na(dep_ver) && !is.na(dep_compare)) {

    compare <- match.fun(dep_compare)
    if (!compare(
      as.numeric_version(getNamespaceVersion(dep_name)),
      as.numeric_version(dep_ver))) {

      warning("Need ", dep_name, " ", dep_compare,
        " ", dep_ver,
        " but loaded version is ", getNamespaceVersion(dep_name))
    }
  }
  return(TRUE)
}



# Load imported objects
# The code in this function is taken from base::loadNamespace
process_imports <- function(pkg) {
  nsInfo <- parse_ns_file(pkg)
  ns <- ns_env(pkg)
  lib.loc <- NULL

  ## process imports
  for (i in nsInfo$imports) {
    if (is.character(i))
      namespaceImport(ns, loadNamespace(i))
    else
      namespaceImportFrom(ns, loadNamespace(i[[1L]]), i[[2L]])
  }
  for(imp in nsInfo$importClasses)
    namespaceImportClasses(ns, loadNamespace(imp[[1L]]), imp[[2L]])
  for(imp in nsInfo$importMethods)
    namespaceImportMethods(ns, loadNamespace(imp[[1L]]), imp[[2L]])
}
