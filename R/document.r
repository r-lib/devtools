#' Use roxygen to make documentation.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param clean if \code{TRUE} will automatically clear all roxygen caches
#'   and delete currently man contents to ensure that you have the freshest
#'   version of the documentation.
#'   check documentation after running roxygen.
#' @keywords programming
#' @export
document <- function(pkg = NULL, clean = FALSE) {
  require("roxygen2")
  
  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")
  
  if (clean) {
    clear_caches()
    file.remove(dir(file.path(pkg$path, "man"), full = TRUE))
  }
  
  # Ensure dependent pacakges are available.
  load_deps(pkg)
  in_dir(pkg$path, roxygenise("."))
    
  # if (check) check_doc(pkg)
  invisible()
}

#' Check documentation, as \code{R CMD check} does.
#'
#' Currently runs these checks: package parseRd, Rd metadata, Rd xrefs, and
#' Rd contents. 
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
check_doc <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  old <- options(warn = -1)
  on.exit(options(old))
  
  print(tools:::.check_package_parseRd(dir = pkg$path))
  print(tools:::.check_Rd_metadata(dir = pkg$path))
  print(tools:::.check_Rd_xrefs(dir = pkg$path))
  print(tools:::.check_Rd_contents(dir = pkg$path))
  
  print(tools::checkDocFiles(dir = pkg$path))
  # print(tools::checkDocStyle(dir = pkg$path))
  # print(tools::undoc(dir = pkg$path))
}


#' Show an Rd file in a package.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param file name of Rd file to open.  Can optionally omit Rd extension.
#' @export
#' @importFrom tools file_ext
#' @importFrom tools Rd2txt
show_rd <- function(pkg = NULL, file) {
  pkg <- as.package(pkg)
  if (file_ext(file) == "") file <- paste(file, ".Rd", sep ="")

  path <- file.path(pkg$path, "man", file)
  stopifnot(file.exists(path))
  
  temp <- Rd2txt(path, out = tempfile("Rtxt"), package = pkg$package)
  file.show(temp, title = paste("Dev documentation: ", file), 
    delete.file = TRUE) 
}
