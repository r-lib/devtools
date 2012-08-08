#' Creates a new package, following all devtools package conventions.
#'
#' @param name character string: the package name and directory name for
#'        your package.
#' @param path to put the package directory in
#' @param description list of description values to override default values or add additional values.
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
                   description=list()
                   ) {

  description.defaults <- list(
                            Package=name,
                            Maintainer="Who to complain to <yourfault@somewhere.net>",
                            Author=Sys.getenv("USER"),
                            Version="1.0",
                            License="GPL-3",
                            Title=name,
                            Description=name,
                            Suggests="\ntestthat,\nroxygen2"
                            )

  package_path <- file.path(path, name)
  message(sprintf("Creating package [%s] in path [%s]", name, package_path))

  dir.create(package_path)
  dir.create(file.path(package_path, 'R'))

  description <- modifyList(description.defaults, description)

  save_package_description(package_path, description)
  create_package_doc(package_path, name)

  message("Checking devtools tasks on the new package.")
  check(package_path)

}
