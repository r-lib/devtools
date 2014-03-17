#' Creates a new package, following all devtools package conventions.
#'
#' Similar to \code{\link{package.skeleton}}, except that it only creates
#' the standard devtools directory structures, it doesn't try and create
#' source code and data files by inspecting the global environment.
#'
#' @param path location to create new package.  The last component of the path
#'   will be used as the package name.
#' @param description list of description values to override default values or
#'   add additional values.
#' @param check if \code{TRUE}, will automatically run \code{\link{check}}
#' @param rstudio Create an Rstudio project file?
#'   (with \code{\link{add_rstudio_project}})
#' @seealso Text with \code{\link{package.skeleton}}
#' @export
#' @examples
#' \donttest{
#' # Create a package using all defaults:
#' path <- file.path(tempdir(), "myDefaultPackage")
#' create(path)
#'
#' # Override a description attribute.
#' path <- file.path(tempdir(), "myCustomPackage")
#' my_description <- list("Maintainer" =
#'   "'Yoni Ben-Meshulam' <yoni@@opower.com>")
#' create(path, my_description)
#' }
create <- function(path, description = getOption("devtools.desc"),
                         check = FALSE, rstudio = TRUE) {
  name <- basename(path)
  message("Creating package ", name, " in ", dirname(path))

  if (file.exists(path)) {
    stop("Directory already exists", call. = FALSE)
  }
  if (!file.exists(dirname(path))) {
    stop("Parent directory does not exist.", call. = FALSE)
  }

  dir.create(path)
  dir.create(file.path(path, "R"))
  dir.create(file.path(path, "man"))
  create_description(path, extra = description)
  create_package_doc(path, name)

  if (rstudio) add_rstudio_project(path)

  if (check) check(path)
  invisible(TRUE)
}

#' @importFrom whisker whisker.render
create_package_doc <- function(path, name) {
  out <- render_template("packagename-package.r", list(name = name))

  target <- file.path(path, "R", paste(name, "-package.r", sep = ""))
  writeLines(out, target)
}
