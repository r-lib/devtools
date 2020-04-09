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

  check_suggested("rmarkdown")
  save_all()

  message("Installing ", pkg$package, " in temporary library")
  withr::local_temp_libpaths()
  install(pkg, upgrade = "never", reload = FALSE, quick = TRUE, quiet = quiet)

  # Ensure rendering github_document() doesn't generate HTML file
  output_options$html_preview <- FALSE

  paths <- file.path(pkg$path, files)
  for (path in paths) {
    message("Building ", path)
    callr::r_safe(
      function(...) rmarkdown::render(...),
      args = list(input = path, ..., output_options = output_options, quiet = quiet),
      show = TRUE,
      spinner = FALSE
    )
  }

  invisible(TRUE)
}

#' @rdname build_rmd
#' @export
build_readme <- function(path = ".", quiet = TRUE, ...) {
  pkg <- as.package(path)

  readme_path <- grep(
    ignore.case = TRUE, value = TRUE,
    "readme[.]rmd",
    list.files(c(pkg$path, file.path(pkg$path, "inst"),
      full.names = TRUE
    ))
  )
  if (length(readme_path) == 0) {
    return(invisible())
  }

  build_rmd(readme_path, path = path, quiet = quiet, ...)
}
