#' Create package pdf manual
#'
#' @template devtools
#' @param path path in which to produce package manual.
#'   If `NULL`, defaults to the parent directory of the package.
#'
#' @seealso [Rd2pdf()]
#' @export
build_manual <- function(pkg = ".", path = NULL) {
  pkg <- as.package(pkg)
  path <- path %||% path_dir(pkg$path)
  name <- paste0(pkg$package, "_", pkg$version, ".pdf", collapse = " ")
  tryCatch(msg <- callr::rcmd("Rd2pdf", cmdargs = c(
    "--force",
    paste0("--output=", path, "/", name),
    pkg$path
  ), fail_on_status = TRUE, stderr = "2>&1", spinner = FALSE),
  error = function(e) {
    cat(e$stdout)
    msg <- regmatches(e$stderr,
                      regexpr("LaTeX Error:.*", e$stderr, perl = TRUE))
    cli::cli_abort(c("x" = msg,
                     "!" = "Failed to build manual"))
  })

  cat(msg$stdout)
  invisible(msg)
}
