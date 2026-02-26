#' Build Rmarkdown files
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `build_rmd()` is deprecated, as it is a low-level helper for internal use. To
#' render your package's `README.Rmd` or `README.qmd`, use [build_readme()]. To
#' preview a vignette or article, use functions like [pkgdown::build_site()] or
#' [pkgdown::build_article()].
#'
#' @param files The Rmarkdown files to be rendered.
#' @param path path to the package to build the readme.
#' @param ...  additional arguments passed to [rmarkdown::render()]
#' @inheritParams install
#' @inheritParams rmarkdown::render
#' @export
#' @keywords internal
build_rmd <- function(
  files,
  path = ".",
  output_options = list(),
  ...,
  quiet = TRUE
) {
  lifecycle::deprecate_soft("2.5.0", "build_rmd()", "build_readme()")
  build_rmd_impl(
    files = files,
    path = path,
    output_options = output_options,
    ...,
    quiet = quiet
  )
}

# Created as part of the deprecation process to de-export build_rmd().
# We still want to use this internally without needing to suppress deprecation
# signals.
build_rmd_impl <- function(
  files,
  path = ".",
  output_options = list(),
  ...,
  quiet = TRUE
) {
  check_dots_used(action = getOption("devtools.ellipsis_action", warn))

  pkg <- as.package(path)

  check_installed("rmarkdown")
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
    if (!quiet) {
      cli::cli_inform(c(i = "Building {.path {path}}"))
    }
    callr::r_safe(
      function(...) rmarkdown::render(...),
      args = list(
        input = path,
        ...,
        output_options = output_options,
        quiet = quiet
      ),
      show = TRUE,
      spinner = FALSE,
      stderr = "2>&1"
    )
  }

  invisible(TRUE)
}

#' Build README
#'
#' Renders an executable README, such as `README.Rmd`, to `README.md`.
#' Specifically, `build_readme()`:
#' * Installs a copy of the package's current source to a temporary library
#' * Renders the README in a clean R session
#'
#' @param path Path to the package to build the README.
#' @param quiet If `TRUE`, suppresses most output. Set to `FALSE`
#'   if you need to debug.
#' @param ... Additional arguments passed to [rmarkdown::render()].
#' @export
build_readme <- function(path = ".", quiet = TRUE, ...) {
  pkg <- as.package(path)

  regexp <- paste0(path_file(pkg$path), "/(inst/)?readme[.]rmd$")
  readme_path <- path_abs(dir_ls(
    pkg$path,
    ignore.case = TRUE,
    regexp = regexp,
    recurse = 1,
    type = "file"
  ))

  if (length(readme_path) == 0) {
    cli::cli_abort("Can't find {.file README.Rmd} or {.file inst/README.Rmd}.")
  }
  if (length(readme_path) > 1) {
    cli::cli_abort(
      "Can't have both {.file README.Rmd} and {.file inst/README.Rmd}."
    )
  }

  build_rmd_impl(readme_path, path = path, quiet = quiet, ...)
}
