#' Use roxygen to make documentation.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param check if \code{TRUE} (the default), will automatically 
#'   check documentation after running roxygen.
#' @keywords programming
#' @export
document <- function(pkg, check = TRUE) {
  message("Updating documentation with roxygen")
  pkg <- as.package(pkg)
  
  require(roxygen)
  if (exists("roxygenise")) {
    # My version of roxygen
    roxygenise(pkg$path, pkg$path, roclets = c("had", "collate", "namespace"))
  } else {
    # Standard version of roxygen
    roxygenize(pkg$path, pkg$path)
  }
  
  if (check) check_doc(pkg)
  invisible()
}

check_doc <- function(pkg) {
  message("Checking documentation")
  pkg <- as.package(pkg)

  check <- tools:::.check_package_description(
    file.path(pkg$path, "DESCRIPTION"))
  if (length(check) > 0) {
    msg <- capture.output(tools:::print.check_package_description(check))
    message("Invalid DESCRIPTION:\n", paste(msg, collapse = "\n"))
  }
  
  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full = TRUE)
  files <- sort(files)
  
  lapply(files, function(x) {
    print(tools::checkRd(x))
  })
  invisible()
}