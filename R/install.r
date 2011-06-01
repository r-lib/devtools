#' Install a package.
#'
#' @export
install <- function(pkg) {
  pkg <- as.package(pkg)
  
  in_dir(dirname(pkg$path), {
    system(paste("R CMD install ", basename(pkg$path), sep = ""))    
  })  
}