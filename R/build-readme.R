#' Build a qmd or Rmarkdown files package
#'
#' `build_md()` is a wrapper around [rmarkdown::render()] and
#' [quarto::quarto_render()] that first installs a temporary copy of the
#' package, and then renders each `.Rmd` or `.qmd` in a clean R session.
#' `build_readme()` locates your `README.Rmd` or `README.qmd` and builds it into
#' a `README.md`.
#'
#' @param files The R Markdown or Quarto files to be rendered.
#' @param path path to the package to build the readme.
#' @param output_options A list of options passed to [rmarkdown::render()] for
#'   `.Rmd` inputs. Ignored for Quarto `.qmd` inputs.
#' @param ...  additional arguments passed to [rmarkdown::render()] for `.Rmd`
#'   inputs or to [quarto::quarto_render()] for `.qmd` inputs. Arguments are shared.
#' @inheritParams install
#' @inheritParams rmarkdown::render
#' @export
build_md <- function(
  files,
  path = ".",
  output_options = list(),
  ...,
  quiet = TRUE
) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  pkg <- as.package(path)

  save_all()

  paths <- files
  abs_files <- is_absolute_path(files)
  paths[!abs_files] <- path(pkg$path, files[!abs_files])

  ok <- file_exists(paths)
  if (any(!ok)) {
    cli::cli_abort("Can't find file{?s}: {.path {files[!ok]}}.")
  }

  is_rmd <- grepl("\\.[Rr]md$", paths)
  is_qmd <- grepl("\\.[Qq]md$", paths)

  if (!all(is_rmd | is_qmd)) {
    cli::cli_abort("Can only build {.file .Rmd} or {.file .qmd} files.")
  }

  if (any(is_rmd)) {
    rlang::check_installed("rmarkdown")
    # Ensure rendering github_document() doesn't generate HTML file
    output_options$html_preview <- FALSE
  }

  if (any(is_qmd)) {
    rlang::check_installed("quarto")
  }

  local_install(pkg, quiet = TRUE)
  env <- r_env_vars()

  for (path in paths) {
    cli::cli_inform(c(i = "Building {.path {path}}"))
    if (grepl("\\.[Qq]md$", path)) {
      callr::r_safe(
        function(...) quarto::quarto_render(...),
        args = list(
          input = path,
          ...,
          quiet = quiet
        ),
        show = TRUE,
        spinner = FALSE,
        stderr = "2>&1",
        env = env
      )
    } else {
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
        stderr = "2>&1",
        env = env
      )
    }
  }

  invisible(TRUE)
}

#' @rdname build_md
#' @export
build_rmd <- function(...) {
  cli::cli_warn(
    c(
      "!" = "{.fn build_rmd} is deprecated.",
      "i" = "Please use {.fn build_md} instead."
    ),
    .frequency = "regularly",
    .frequency_id = "build_rmd"
  )
  build_md(...)
}

#' @rdname build_md
#' @export
build_readme <- function(path = ".", quiet = TRUE, ...) {
  pkg <- as.package(path)

  regexp <- paste0(path_file(pkg$path), "/(inst/)?readme[.](r|q)md$")
  readme_path <- path_abs(
    dir_ls(
      pkg$path,
      ignore.case = TRUE,
      regexp = regexp,
      recurse = 1,
      type = "file"
    )
  )

  if (length(readme_path) == 0) {
    cli::cli_abort(
      "Can't find {.file README.Rmd}, {.file inst/README.Rmd}, {.file README.qmd}, or {.file inst/README.qmd}."
    )
  }
  if (length(readme_path) > 1) {
    cli::cli_abort(
      "Can't have multiple README sources: {.file README.Rmd}, {.file inst/README.Rmd}, {.file README.qmd}, or {.file inst/README.qmd}."
    )
  }

  build_md(readme_path, path = path, quiet = quiet, ...)
}
