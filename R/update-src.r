#' Update the source code of a package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
update_src <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " source")
  
  cmd <- paste("cd ", pkg$path, " && ", sep = "")
  
  if (is.svn(pkg)) {
    cmd <- paste(cmd, "svn up", sep = "")
  } else if (is.git(pkg)) {
    cmd <- paste(cmd, "git pull", sep = "")
  } else {
    stop("Unknown rcs software")
  }
  
  system(cmd)
}


#' Does this package use svn?
#' @keywords internal
is.svn <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  file.exists(file.path(pkg$path, ".svn"))
}

#' Does this package use git?
#' @keywords internal
is.git <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  file.exists(file.path(pkg$path, ".git"))
}