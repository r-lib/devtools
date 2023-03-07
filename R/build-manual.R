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
  name <- glue("{pkg$package}_{pkg$version}.pdf")
  tryCatch(msg <- callr::rcmd("Rd2pdf", cmdargs = c(
    "--force",
    glue("--output={path}/{name}"),
    pkg$path
  ), fail_on_status = TRUE, stderr = "2>&1", spinner = FALSE),
  error = function(e) {
    cat(e$stdout)
    cli::cli_abort("Failed to build manual")
  })

  cat(msg$stdout)
  invisible(msg)
}
