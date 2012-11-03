
compile_rcpp_attributes <- function(pkg) {
  
  # Only scan for attributes in packages explicitly linking to Rcpp
  if (!is.null(pkg$linkingto) && grepl("Rcpp", pkg$linkingto)) {
    
    if (!require("Rcpp")) 
      stop("Rcpp required for building this package")
    
    # Only compile attributes if we know we have the function available
    if (utils::packageVersion("Rcpp") >= "0.9.15.6")
      compileAttributes(pkg$path)
  }
}