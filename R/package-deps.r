#' Parse package dependency strings.
#'
#' @param string to parse. Should look like \code{"R (>= 3.0), ggplot2"} etc.
#' @param remove_r If \code{TRUE} R itself will be removed from the parsed
#'   dependency string.
#' @return list of two character vectors: \code{name} package names,
#'   and \code{version} package versions. If version is not specified,
#'   it will be stored as NA.
#' @keywords internal
#' @export
#' @examples
#' parse_deps("httr (< 2.1),\nRCurl (>= 3)")
#' # only package dependencies are returned
#' parse_deps("utils (== 2.12.1),\ntools,\nR (>= 2.10),\nmemoise")
#' # package dependencies and R version is returned
#' parse_deps("utils (== 2.12.1),\ntools,\nR (>= 2.10),\nmemoise", remove_r = FALSE)
parse_deps <- function(string, remove_r = TRUE) {
  if (is.null(string)) return()
  stopifnot(is.character(string), length(string) == 1)
  if (grepl("^\\s*$", string)) return()

  pieces <- strsplit(string, "[[:space:]]*,[[:space:]]*")[[1]]

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

  if(remove_r) {
    # Remove R dependency
    return(deps[names != "R", ])
  } else {
    return(deps)
  }
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

# devtools:::unparse_deps(parse_deps("utils (== 2.12.1),\ntools,\nR (>= 2.10),\nmemoise"))
unparse_deps <- function(deps) {
  paste(apply(deps, 1, function(x){
    if(!is.na(x["compare"]) && !is.na(x["version"])){
      return(paste0("\n    ", x["name"], " (", x["compare"], " ", x["version"], ")"))
    } else {
      return(paste0("\n    ", x["name"]))
    }
  }), collapse = ",")
}
