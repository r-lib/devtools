#' Sources an R file in a clean environment.
#' 
#' Opens up a fresh R environment and sources file, ensuring that it works
#' independently of the current working environment.
#'
#' @param path path to R script
#' @param vanilla if \code{TRUE} tells R not to use any system specific 
#'   settings.
#' @export
clean_source <- function(path, vanilla = FALSE) {
  stopifnot(file.exists(path))
  
  if (vanilla) {
    opts <- c("--no-restore", "--no-save")
  } else {
    opts <- c("--vanilla")
  }
  
  opts <- c("--quiet", paste("--file=", shQuote(path), sep = ""))
  R(opts, dirname(path))
}
