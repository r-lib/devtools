#' Add basic travis template to a package
#'
#' Also adds \code{.travis.yml} to \code{.Rbuildignore} so it isn't included
#' in the built package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
add_travis <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, ".travis.yml")
  if (file.exists(path)) {
    stop(".travis.yml already exists", call. = FALSE)
  }
  message("Adding .travis.yml to ", pkg$package, ". Next: \n",
    " * Turn on travis for this repo at https://travis-ci.org/profile\n",
    " * Add a travis shield to your README.md"
  )

  template_path <- system.file("templates/travis.yml", package = "devtools")
  file.copy(template_path, path)

  add_build_ignore(pkg, ".travis.yml")

  invisible(TRUE)
}
