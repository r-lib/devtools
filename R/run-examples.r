#' Run all examples in a package.
#'
#' One of the most frustrating parts of `R CMD check` is getting all of your
#' examples to pass - whenever one fails you need to fix the problem and then
#' restart the whole process.  This function makes it a little easier by
#' making it possible to run all examples from an R function.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param start Where to start running the examples: this can either be the
#'   name of \code{Rd} file to start with (with or without extensions), or
#'   a topic name. If omitted, will start with the (lexicographically) first
#'   file. This is useful if you have a lot of examples and don't want to
#'   rerun them every time when you fix a problem.
#' @family example functions
#' @param show if \code{TRUE}, code in \code{\\dontshow{}} will be commented
#'   out
#' @param test if \code{TRUE}, code in \code{\\donttest{}} will be commented
#'   out. If \code{FALSE}, code in \code{\\testonly{}} will be commented out.
#' @param run if \code{TRUE}, code in \code{\\dontrun{}} will be commented
#'   out.
#' @keywords programming
#' @export
run_examples <- function(pkg = ".", start = NULL, show = TRUE, test = FALSE, run = TRUE) {
  pkg <- as.package(pkg)
  load_all(pkg, reset = TRUE, export_all = FALSE)
  on.exit(load_all(pkg, reset = TRUE))
  document(pkg, reload = FALSE)
  
  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full.names = TRUE)
  names(files) <- basename(files)
  files <- with_collate("C", sort(files))
  
  if (!is.null(start)) {
    start_path <- find_pkg_topic(pkg, start)
    if (is.null(start_path)) {
      stop("Couldn't find start position ", start, call. = FALSE)
    }
    
    start_pos <- which(names(files) == start_path)
    if (length(start_pos) == 1) {
      files <- files[- seq(1, start_pos - 1)]
    }
  }
  
  message("Running ", length(files), " example files in ", pkg$package)
  rule()
  lapply(files, run_example, show = show, test = test, run = run)
  
  invisible()
}
# If an error occurs, should print out the suspect line of code, and offer
# the following options:
#   * skip to the next example
#   * quit
#   * browser
#   * rerun example and rerun
#   * reload code and rerun
