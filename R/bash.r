#' Open bash shell in package directory.
#'
#' @param pkg package description, can be path or package name.  See
#'   [as.package()] for more information
#' @export
bash <- function(pkg = ".") {
  pkg <- as.package(pkg)

  withr::with_dir(pkg$path, system("bash"))
}
