#' Load R code.
#'
#' Load all R code in the \code{R} directory. The first time the code is 
#' loaded, \code{.onLoad} will be run if it exists.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param env environment in which to load code.  Defaults to \code{devel:pkg}
#'   which is attached just after the global environment.  See
#'  \code{\link{pkg_ns_env}} for more information
#' @keywords programming
#' @export
load_code <- function(pkg = NULL, env = pkg_ns_env(pkg)) {
  pkg <- as.package(pkg)

  r_files <- find_code(pkg)
  paths <- changed_files(r_files)

  tryCatch(
    lapply(paths, sys.source, envir = env, chdir = TRUE, 
      keep.source = TRUE), 
    error = function(e) {
      clear_cache()
      stop(e)
    }
  )
  
  # Load .onLoad if it's defined
  if (exists(".onLoad", env, inherits = FALSE) && 
     !exists("__loaded", env, inherits = FALSE)) {
    env$.onLoad()
    env$`__loaded` <- TRUE
  }
  
  invisible(r_files)
}


#' Parse collate string into vector of function names.
#' @keywords internal
parse_collate <- function(string) {
  con <- textConnection(string)
  on.exit(close(con))
  scan(con, "character", sep = " ", quiet = TRUE)
}

#' Find all R files in given directory.
#' @keywords internal
find_code <- function(pkg) {
  path_r <- file.path(pkg$path, "R")
  
  code_paths <- dir(path_r, "\\.[Rrq]$", full.names = TRUE)  
  r_files <- with_collate("C", sort(code_paths))
  
  if (!is.null(pkg$collate)) {
    collate <- file.path(path_r, parse_collate(pkg$collate))
    
    missing <- setdiff(collate, r_files)
    files <- function(x) paste(basename(x), collapse = ", ")
    if (length(missing) > 0) {
      message("Skipping missing files: ", files(missing))
    }
    collate <- setdiff(collate, missing)

    extra <- setdiff(r_files, collate)
    if (length(extra) > 0) {
      message("Adding files missing in collate: ", files(extra))
    }
    
    r_files <- union(collate, r_files)
  }
  r_files
}
