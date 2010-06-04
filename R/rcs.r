#' Update the source code of a package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
update_src <- function(pkg) {
  pkg <- as.package(pkg)
  
  cmd <- str_c("cd ", pkg$path, " && ")
  
  if (is.svn(pkg)) {
    cmd <- str_c(cmd, "svn up")
  } else if (is.git(pkg)) {
    cmd <- str_c(cmd, "git pull")    
  } else {
    stop("Unknown rcs software")
  }
  
  system(cmd)
}


#' Does this package use svn?
#' @keywords internal
is.svn <- function(pkg) {
  pkg <- as.package(pkg)
  file.exists(file.path(pkg$path, ".svn"))
}

#' Does this package use git?
#' @keywords internal
is.git <- function(pkg) {
  pkg <- as.package(pkg)
  file.exists(file.path(pkg$path, ".git"))
}