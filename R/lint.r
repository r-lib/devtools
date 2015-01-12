#' Lint all source files in a package.
#'
#' The default lintings correspond to the style guide at
#' \url{http://r-pkgs.had.co.nz/r.html#style}, however it is possible to
#' override any or all of them using the \code{linters} parameter.
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information
#' @param ... additional arguments passed to \code{\link[lintr]{lint_package}}
#' @seealso \code{\link[lintr]{lint_package}}, \code{\link[lintr]{lint}}
#' @export
lint <- function(pkg = ".", ...) {
  check_lintr()
  pkg <- as.package(pkg)

  message("Linting ", pkg$package, appendLF = FALSE)
  lintr::lint_package(pkg$path, ...)
}

check_lintr <- function() {
  if (!requireNamespace("lintr", quietly = TRUE)) {
    stop("Please install lintr", call. = FALSE)
  }
}
