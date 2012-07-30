#' Creates a new package, following all devtools package conventions.
#'
#' Similar to package.skeleton, except that it omits the default of adding
#' current environment variables, instead defaulting to adding no objects.
#' Also adds the standard devtools conventions.
#' @param name character string: the package name and directory name for
#'        your package.
#' @param path to put the package directory in
#' @param environment to be included in the package. Defaults to empty environment.
#' @param description list of description values to override default values or add additional values.
#' @param ... other options passed to \code{package.skeleton}
#' @seealso Text with \code{\link{package.skeleton}}
#' @export
#' @examples
#'
#' # Create a package using all defaults:
#' path_to_package <- tempdir()
#' create(name='myDefaultPackage', path=path_to_package)
#'
#' # Override a description attribute.
#' # Note that overriding one atribute implies that you must override
#' # all default attributes, as well.
#' my_description <- list("Maintainer"="'Yoni Ben-Meshulam' <yoni@@opower.com>")
#' create(name='myCustomPackage', path=path_to_package, description=my_description)
create <- function(
                   name,
                   path,
                   environment=new.env(),
                   description=list(),
                   ...) {

  description.defaults <- c(
                            "Package"=name,
                            "Maintainer"="Who to complain to <yourfault@somewhere.net>",
                            "Author"=Sys.getenv("USER"),
                            "Version"="1.0",
                            "License"="GPL-3",
                            "Title"=name,
                            "Description"=name,
                            "Suggests"="\ntestthat,\nroxygen2"
                            )

  package_path <- file.path(path, name)
  message(sprintf("Creating package [%s] in path [%s]", name, package_path))

  created_dummy_function <- FALSE
  # Workaround for empty environments. Will add a simple function that prints 'hello'.
  # This is a known issue documented here:
  # https://stat.ethz.ch/pipermail/r-devel/2011-October/062279.html
  if(length(ls(environment)) == 0) {
    created_dummy_function <- TRUE
    assign('hello', function() print('hello'), environment)
  }

  package.skeleton(name=name, path=path, environment=environment, ...)

  message("Removing automatically generated documentation, since we're using Roxygen to generate the actual documenation.")
  paths_to_remove <- c('man', 'Read-and-delete-me')
  unlink(file.path(package_path, paths_to_remove), recursive = TRUE)

  # Add empty R directory:
  r_path <- file.path(package_path, 'R')
  if(!file.exists(r_path)) dir.create(r_path)

  # Combine default and override values:
  description <- c(description, description.defaults)
  description <- description[unique(names(description))]

  write_description(package_path, description)
  create_package_doc(package_path, name)

  # Run common devtools tasks on the new package:
  message("Checking devtools tasks on the new package.")
  check(package_path)

}
