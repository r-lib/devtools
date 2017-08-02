
#' Create package pdf manual
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information.
#' @param path path in which to produce package manual.
#'   If \code{NULL}, defaults to the parent directory of the package.
#'
#' @seealso \code{\link{Rd2pdf}}
#' @export

build_manual <- function(pkg = ".", path = NULL) {
  pkg <- as.package(pkg)
  if (is.null(path)) {
    path <- dirname(pkg$path)
  }
  name <- paste0(pkg$package, "_", pkg$version, ".pdf", collapse = " ")
  system(paste0("R CMD Rd2pdf --force --output=", path, "/", name, " ", shQuote(pkg$path), collapse = " "))
}
