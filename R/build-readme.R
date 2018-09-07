#' Build a Rmarkdown README for a package
#'
#' `build_readme()` is a wrapper around [rmarkdown::render()], it generates the
#' README.md from a README.Rmd file.
#'
#' @param path path to the package to build the readme.
#' @param ...  additional arguments passed to [rmarkdown::render()]
#' @inheritParams install
#' @export
build_readme <- function(path = ".", quiet = TRUE, ...) {
  check_suggested("rmarkdown")

  save_all()

  pkg <- as.package(path)

  readme_path <- grep(ignore.case = TRUE, value = TRUE,
                      "readme[.]rmd",
                      list.files(c(pkg$path, file.path(pkg$path, "inst"),
                                 full.names = TRUE)))
  if (length(readme_path) == 0) { return(invisible()) }

  readme_path <- file.path(pkg$path, readme_path[[1]])

  build <- function(pkg_path, readme_path, ..., quiet) {
    withr::with_temp_libpaths(action = "prefix", code = {
      devtools::install(pkg_path, upgrade_dependencies = FALSE, reload = FALSE, quiet = quiet)
      rmarkdown::render(readme_path, ..., quiet = quiet)
    })
  }

  message("Building ", pkg$package, " readme")

  output <- callr::r(build,
    args = list(pkg_path = pkg$path, readme_path = readme_path, ... = ..., quiet = quiet),
    show = TRUE, spinner = FALSE)

  invisible(TRUE)
}
