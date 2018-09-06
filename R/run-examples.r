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
#'   rerun them every time you fix a problem.
#' @family example functions
#' @param show DEPRECATED.
#' @param test if \code{TRUE}, code in \code{\\donttest{}} will be commented
#'   out. If \code{FALSE}, code in \code{\\testonly{}} will be commented out.
#' @param run if \code{TRUE}, code in \code{\\dontrun{}} will be commented
#'   out.
#' @param fresh if \code{TRUE}, will be run in a fresh R session. This has
#'   the advantage that there's no way the examples can depend on anything in
#'   the current session, but interactive code (like \code{\link{browser}})
#'   won't work.
#' @param document if \code{TRUE}, \code{\link{document}} will be run to ensure
#'   examples are updated before running them.
#' @keywords programming
#' @export
run_examples <- function(pkg = ".", start = NULL, show = TRUE, test = FALSE,
                         run = TRUE, fresh = FALSE, document = TRUE) {
  pkg <- as.package(pkg)

  if (fresh) {
    to_run <-
      eval(substitute(
        function() devtools::run_examples(pkg = path, start = start, test = test, run = run, fresh = FALSE),
        list(path = pkg$path, start = start, test = test, run = run)
      ))
    callr::r(to_run, show = TRUE, spinner = FALSE)
    return(invisible())
  }

  if (document) {
    document(pkg)
  }

  if (!missing(show)) {
    warning("`show` is deprecated", call. = FALSE)
  }

  files <- rd_files(pkg$path, start = start)
  if (length(files) == 0) {
    return()
  }

  cat_rule(
    left = paste0("Running ", length(files), " example files"),
    right = pkg$package
  )

  load_all(pkg$path, reset = TRUE, export_all = FALSE)
  on.exit(load_all(pkg$path, reset = TRUE))

  lapply(files, pkgload::run_example, test = test, run = run)

  invisible()
}
# If an error occurs, should print out the suspect line of code, and offer
# the following options:
#   * skip to the next example
#   * quit
#   * browser
#   * rerun example and rerun
#   * reload code and rerun


rd_files <- function(pkg = ".", start = NULL) {
  pkg <- as.package(pkg)

  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full.names = TRUE)
  names(files) <- basename(files)
  files <- sort_ci(files)

  if (!is.null(start)) {
    topic <- pkgload::dev_help(start, dev_packages = pkg$package)
    start_path <- basename(topic$path)

    start_pos <- which(names(files) == start_path)
    if (length(start_pos) == 1) {
      files <- files[-seq(1, start_pos - 1)]
    }
  }

  files
}
