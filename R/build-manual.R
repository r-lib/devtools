#' Create package pdf manual
#'
#' @param pkg package description, can be path or package name.  See
#'   [as.package()] for more information.
#' @param path path in which to produce package manual.
#'   If `NULL`, defaults to the parent directory of the package.
#'
#' @seealso [Rd2pdf()]
#' @export
build_manual <- function(pkg = ".", path = NULL) {
  pkg <- as.package(pkg)
  path <- path %||% dirname(pkg$path)
  name <- paste0(pkg$package, "_", pkg$version, ".pdf", collapse = " ")
  tryCatch(msg <- callr::rcmd("Rd2pdf", cmdargs = c(
    "--force",
    paste0("--output=", path, "/", name),
    pkg$path
  ), fail_on_status = TRUE),
  error = function(e) {
    cat(e$stderr)
    stop("Failed to build manual", call. = FALSE)
  })

  cat(msg$stdout)
  invisible(msg)
}
