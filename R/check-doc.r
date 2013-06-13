#' Check documentation, as \code{R CMD check} does.
#'
#' Currently runs these checks: package parseRd, Rd metadata, Rd xrefs, and
#' Rd contents.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @return Nothing. This function is called purely for it's side effects: if
#   no errors there will be no output.
#' @export
#' @importFrom tools checkDocFiles
#' @examples
#' \dontrun{
#' document("mypkg")
#' check_doc("mypkg")
#' }
check_doc <- function(pkg = ".") {
  pkg <- as.package(pkg)
  old <- options(warn = -1)
  on.exit(options(old))

  print_if_not_null(tools:::.check_package_parseRd(dir = pkg$path))
  print_if_not_null(tools:::.check_Rd_metadata(dir = pkg$path))
  print_if_not_null(tools:::.check_Rd_xrefs(dir = pkg$path))
  print_if_not_null(tools:::.check_Rd_contents(dir = pkg$path))

  print_if_not_null(checkDocFiles(dir = pkg$path))
  # Can't run because conflicts with how devtools loads code
  # print_if_not_null(checkDocStyle(dir = pkg$path))
  # print_if_not_null(checkReplaceFuns(dir = pkg$path))
  # print_if_not_null(checkS3methods(dir = pkg$path))
  # print(undoc(dir = pkg$path))

  invisible()
}

print_if_not_null <- function(x) {
  if (is.null(x)) return(invisible())
  print(x)
}
