#' Read the in-development help for a package loaded with devtools.
#'
#' Note that this only renders a single documentation file, so that links
#' to other files within the package won't work.
#' 
#' @param topic name of help to search for.
#' @param stage at which stage (‘"build"’, ‘"install"’, or ‘"render"’) should
#'   \\Sexpr macros be executed? This is only important if you're using
#'   \\Sexpr macro's in your Rd files.
#' @examples
#' \dontrun{
#' library("ggplot2")
#' help("ggplot") # loads installed documentation for ggplot
#' 
#' load_all("ggplot2")
#' dev_help("ggplot") # loads development documentation for ggplot
#' }
dev_help <- function(topic, stage = "render") {
  path <- find_topic(topic)
  if (is.null(path)) {
    dev <- paste(dev_packages(), collapse = ", ")
    stop("Could not find topic ", topic, " in: ", dev)
  }
  
  view_rd(path, stage = stage)  
} 

#' Show an Rd file in a package.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param file topic or name Rd file to open. 
#' @param ... additional arguments passed onto \code{\link[tools]{Rd2txt}}.
#'   This is particular useful if you're checking macros and want to simulate
#'   what happens when the package is built (\code{stage = "build"})
#' @export
#' @importFrom tools file_ext
#' @importFrom tools Rd2txt
show_rd <- function(pkg = NULL, file, ...) {
  .Deprecated("dev_help")
  pkg <- as.package(pkg)
  
  rd <- find_pkg_topic(pkg, file)
  if (is.null(rd)) {
    stop("Could not find topic or Rd file ", file, call. = FALSE)
  }

  path <- file.path(pkg$path, "man", rd)  
  view_rd(path, ...)
}

view_rd <- function(path, package, stage = "render") {
  temp <- Rd2txt(path, out = tempfile("Rtxt"), package = "In development", 
    stages = stage)
  file.show(temp, title = paste("Dev documentation: ", basename(path)), 
    delete.file = TRUE) 
}
