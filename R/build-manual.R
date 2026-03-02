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
  name <- paste0(pkg$package, "_", pkg$version, ".pdf")
  output <- file.path(path, name)

  cli::cli_inform("Saving manual to {.file {output}}")
  withCallingHandlers(
    invisible(rd2pdf(pkg$path, output)),
    error = function(e) {
      cli::cli_abort(
        c("Failed to build manual.", no_wrap(e$stderr)),
        call = quote(build_manual()),
        parent = e
      )
    }
  )
}

rd2pdf <- function(pkg_path, output_path) {
  callr::rcmd(
    "Rd2pdf",
    cmdargs = c("--force", paste0("--output=", output_path), pkg_path),
    stdout = "",
    fail_on_status = TRUE,
    spinner = FALSE
  )
}
