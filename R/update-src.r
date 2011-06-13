#' Update the source code of a package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
update_src <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " source")
  
  if (is.svn(pkg)) {
    cmd <- "svn up"
  } else if (is.git(pkg)) {
    cmd <- "git pull"
  } else {
    stop("Unknown rcs software", call. = FALSE)
  }
  
  in_dir(pkg$path, system_check(cmd))
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