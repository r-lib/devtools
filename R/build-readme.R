#' Build Rmarkdown files
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `build_rmd()` is deprecated, as it is a low-level helper for internal use. To
#' render your package's `README.qmd` or `README.Rmd`, use [build_readme()]. To
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
#' Renders an executable README, i.e. `README.qmd` or `README.Rmd`, to
#' `README.md`. Specifically, `build_readme()`:
#' * Installs a copy of the package's current source to a temporary library
#' * Renders the README in a clean R session
#'
#' @param path Path to the top-level directory of the source package.
#' @param quiet If `TRUE`, suppresses most output. Set to `FALSE`
#'   if you need to debug.
#' @param ... Additional arguments passed to [rmarkdown::render()], in the
#'   case of `README.Rmd`. Not used for `README.qmd`
#' @export
build_readme <- function(path = ".", quiet = TRUE, ...) {
  pkg <- as.package(path)

  readme_candidates <- c(
    path(pkg$path, "README.qmd"),
    path(pkg$path, "README.Rmd"),
    path(pkg$path, "inst", "README.qmd"),
    path(pkg$path, "inst", "README.Rmd")
  )
  readme_path <- readme_candidates[file_exists(readme_candidates)]

  if (length(readme_path) == 0) {
    cli::cli_abort(
      "Can't find {.file README.qmd} or {.file README.Rmd}, at the top-level or
      below {.file inst/}."
    )
  }
  if (length(readme_path) > 1) {
    rel_paths <- path_rel(readme_path, pkg$path)
    cli::cli_abort(
      "Found multiple executable READMEs: {.file {rel_paths}}. There can only be
      one."
    )
  }

  if (!quiet) {
    cli::cli_inform(c(i = "Building {.path {readme_path}}"))
  }

  if (path_ext(readme_path) == "qmd") {
    build_qmd_readme(readme_path, path = path, quiet = quiet)
  } else {
    build_rmd_impl(readme_path, path = path, quiet = quiet, ...)
  }
}

build_qmd_readme <- function(readme_path, path = ".", quiet = TRUE) {
  pkg <- as.package(path)

  check_installed("quarto")
  save_all()

  local_install(pkg, quiet = TRUE)

  # Quarto spawns its own R process for knitr, which won't inherit .libPaths().

  # Pass library paths via R_LIBS_USER so the quarto subprocess finds the
  # temporarily installed package first, ahead of any user-installed version.
  lib_paths <- paste(.libPaths(), collapse = .Platform$path.sep)

  callr::r_safe(
    function(input, quiet) {
      quarto::quarto_render(input = input, quiet = quiet)
    },
    args = list(input = readme_path, quiet = quiet),
    env = c(callr::rcmd_safe_env(), R_LIBS_USER = lib_paths),
    show = TRUE,
    spinner = FALSE,
    stderr = "2>&1"
  )

  invisible(TRUE)
}
