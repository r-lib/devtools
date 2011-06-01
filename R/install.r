#' Install a package.
#'
install <- function(pkg) {
  pkg <- as.package(pkg)
  
  in_dir(dirname(pkg$path), {
    system(paste("R CMD install ", pkg$package, sep = ""))    
  })  
}