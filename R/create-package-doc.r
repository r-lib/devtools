#' Creates package-level documentation, where the developer can add
#' documentation for data, vignettes, etc.
#' @param path path to the package
#' @param name of the package
#' @importFrom brew brew
#' @export
create_package_doc <- function(path, name) {
  
  package_doc_file <- file.path(path, 'R', sprintf("%s-package.r", name))
  brew(
       file=(system.file("templates/packagename-package.r", package="devtools")),
       output=package_doc_file
       )

}
