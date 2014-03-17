#' Add Rstudio project to a package.
#'
#' Does not modify \code{.Rbuildignore} as Rstudio will do that when
#' opened for the first time.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
add_rstudio_project <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, paste0(pkg$package, ".Rproj"))
  if (file.exists(path)) {
    stop(pkg$package, ".Rproj already exists", call. = FALSE)
  }
  message("Adding Rstudio project file to ", pkg$package)

  template_path <- system.file("templates/template.Rproj", package = "devtools")
  file.copy(template_path, path)

  add_build_ignore(pkg, ".travis.yml")

  invisible(TRUE)
}
