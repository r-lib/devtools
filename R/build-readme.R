#' Build a Rmarkdown files package
#'
#' `build_rmd()` is a wrapper around [rmarkdown::render()] that first installs
#' a temporary copy of the package, and then renders each `.Rmd` in a clean R
#' session. `build_readme()` locates your `README.Rmd` and builds it into a
#' `README.md`
#'
#' @param files The Rmarkdown files to be rendered.
#' @param path path to the package to build the readme.
#' @param ...  additional arguments passed to [rmarkdown::render()]
#' @inheritParams install
#' @inheritParams rmarkdown::render
#' @export
build_rmd <- function(files, path = ".", output_options = list(), ..., quiet = TRUE) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  pkg <- as.package(path)

  rlang::check_installed("rmarkdown")
  save_all()

  paths <- files
  abs_files <- is_absolute_path(files)
  paths[!abs_files] <- path(pkg$path, files[!abs_files])

  ok <- file_exists(paths)
  if (any(!ok)) {
    cli::cli_abort("Can't find file{?s}: {.path {files[!ok]}}.")
  }

  local_install(pkg, quiet = TRUE)

  # Ensure rendering github_document() doesn't generate HTML file
  output_options$html_preview <- FALSE


  for (path in paths) {
    cli::cli_alert_info("Building {.path {path}}")
    callr::r_safe(
      function(...) rmarkdown::render(...),
      args = list(input = path, ..., output_options = output_options, quiet = quiet),
      show = TRUE,
      spinner = FALSE,
      stderr = "2>&1"
    )
  }

  invisible(TRUE)
}

#' @rdname build_rmd
#' @export
build_readme <- function(path = ".", quiet = TRUE, ...) {
  pkg <- as.package(path)

  readme_path <- path_abs(dir_ls(pkg$path, ignore.case = TRUE, regexp = "(inst/)?readme[.]rmd", recurse = 1, type = "file"))

  if (length(readme_path) == 0) {
    rlang::abort("Can't find a 'README.Rmd' or 'inst/README.Rmd' file.")
  }

  if (length(readme_path) > 1) {
    rlang::abort("Can't have both a 'README.Rmd' and 'inst/README.Rmd' file.")
  }

  build_rmd(readme_path, path = path, quiet = quiet, ...)
}
