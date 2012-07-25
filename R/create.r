#' Creates a new package, following all devtools package conventions.
#' Similar to package.skeleton, except that it omits the default of adding
#' current environment variables, instead defaulting to adding no objects.
#' Also adds the standard devtools conventions.
#' @param name character string: the package name and directory name for
#'        your package.
#' @param path to put the package directory in
#' @param environment to be included in the package. Defaults to empty environment.
#' @param description names vector of description values to add. Note that default values exist, as well.
#' @param ... other options passed to \code{package.skeleton}
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
#' my_description <- as.list(formals(create)$description)
#' my_description$Package <- "myCustomPackage"
#' my_description$Maintainer <- "'Yoni Ben-Meshulam' <yoni@@opower.com>"
#' 
#' create(name='myCustomPackage', path=path_to_package, description=my_description)
create <- function(
                   name,
                   path,
                   environment=new.env(),
                   description=c("Package"=name,
                                 "Maintainer"="Who to complain to <yourfault@somewhere.net>",
                                 "Author"=Sys.getenv("USER"),
                                 "Version"="1.0",
                                 "License"="GPL-3",
                                 "Title"="",
                                 "Description"="",
                                 "Suggests"="\ntestthat,\nroxygen2"
                                 ),
                   ...) {

  package_path <- file.path(path, name)
  message(sprintf("Creating package [%s] in path [%s]", name, package_path))

  created_dummy_function <- FALSE
  # Workaround for empty environments. Will add a simple function that prints 'hello'.
  if(length(ls(environment)) == 0) {
    created_dummy_function <- TRUE
    assign('hello', function() print('hello'), environment)
  }

  package.skeleton(name=name, path=path, environment=environment, ...)
  message("Removing automatically generated documentation, since we're using Roxygen to generate it.")

  # These are package.skeleton generated files which add more noise than help. We'll replace them with
  # Roxygen-generated documentation and devtools workflows.
  paths_to_remove <- c('man', 'Read-and-delete-me')
  unlink(file.path(package_path, paths_to_remove), recursive = TRUE)

  # Add empty R and data paths.
  r_path <- file.path(package_path, 'R')
  if(!file.exists(r_path)) dir.create(r_path)

  write_description(package_path, description)

  # Run common devtools tasks on the new package:
  message("Checking devtools tasks on the new package.")
  document(package_path)
  check(package_path)
  install(package_path)

}
