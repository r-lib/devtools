
compile_rcpp_attributes <- function(pkg) {
  
  # Only scan for attributes in packages explicitly linking to Rcpp
  if (links_to_rcpp(pkg)) {
    
    if (!require("Rcpp")) 
      stop("Rcpp required for building this package")
    
    # Only compile attributes if we know we have the function available
    if (utils::packageVersion("Rcpp") >= "0.9.15.6")
      compileAttributes(pkg$path)
  }
}

links_to_rcpp <- function(pkg) {
  !is.null(pkg$linkingto) && grepl("Rcpp", pkg$linkingto, fixed = T)
}