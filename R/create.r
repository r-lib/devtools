#' Creates a new package, following all devtools package conventions.
#'
#' Similar to \code{\link{package.skeleton}}, except that it only creates
#' the standard devtools directory structures; it doesn't try and create
#' source code and data files by inspecting the global environment.
#'
#' \code{create} requires that the directory doesn't exist yet; it will be
#' created but deleted upon failure. \code{setup} assumes an existing
#' directory from which it will infer the package name.
#'
#' @param path location to create new package.  The last component of the path
#'   will be used as the package name.
#' @param description list of description values to override default values or
#'   add additional values.
#' @param check if \code{TRUE}, will automatically run \code{\link{check}}
#' @param rstudio Create an Rstudio project file?
#'   (with \code{\link{use_rstudio}})
#' @seealso Text with \code{\link{package.skeleton}}
#' @export
#' @examples
#' \dontrun{
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
  check_package_name(path)

  if (file.exists(path)) {
    stop("Directory already exists", call. = FALSE)
  }
  if (!file.exists(dirname(path))) {
    stop("Parent directory does not exist.", call. = FALSE)
  }

  dir.create(path)
  setup(path = path, description = description, rstudio = rstudio,
        check = check)

  invisible(TRUE)
}

#' @rdname create
#' @export
setup <- function(path = ".", description = getOption("devtools.desc"),
                  check = FALSE, rstudio = TRUE) {
  check_package_name(path)

  message("Creating package ", extract_package_name(path), " in ", dirname(path))

  dir.create(file.path(path, "R"))
  create_description(path, extra = description)
  create_namespace(path)

  if (rstudio) use_rstudio(path)

  if (check) check(path)
  invisible(TRUE)
}

extract_package_name <- function(path) {
  basename(normalizePath(path, mustWork = FALSE))
}

check_package_name <- function(path) {
  name <- extract_package_name(path)
  if (!valid_name(name)) {
    stop(
      name, " is not a valid package name: it should contain only\n",
      "ASCII letters, numbers and dot, have at least two characters\n",
      "and start with a letter and not end in a dot.",
      call. = FALSE
    )
  }
}


valid_name <- function(x) {
  grepl("^[[:alpha:]][[:alnum:].]+$", x) && !grepl("\\.$", x)
}

create_namespace <- function(path) {
  ns_path <- file.path(path, "NAMESPACE")
  cat('exportPattern("^[^\\\\.]")\n', file = ns_path)
}
