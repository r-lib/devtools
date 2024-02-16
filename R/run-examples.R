#' Run all examples in a package.
#'
#' One of the most frustrating parts of `R CMD check` is getting all of your
#' examples to pass - whenever one fails you need to fix the problem and then
#' restart the whole process.  This function makes it a little easier by
#' making it possible to run all examples from an R function.
#'
#' @template devtools
#' @inheritParams pkgload::run_example
#' @param start Where to start running the examples: this can either be the
#'   name of `Rd` file to start with (with or without extensions), or
#'   a topic name. If omitted, will start with the (lexicographically) first
#'   file. This is useful if you have a lot of examples and don't want to
#'   rerun them every time you fix a problem.
#' @family example functions
#' @param show DEPRECATED.
#' @param fresh if `TRUE`, will be run in a fresh R session. This has
#'   the advantage that there's no way the examples can depend on anything in
#'   the current session, but interactive code (like [browser()])
#'   won't work.
#' @param document if `TRUE`, [document()] will be run to ensure
#'   examples are updated before running them.
#' @keywords programming
#' @export
run_examples <- function(pkg = ".", start = NULL, show = deprecated(), run_donttest = FALSE,
                         run_dontrun = FALSE, fresh = FALSE, document = TRUE,
                         run = deprecated(), test = deprecated()) {

  if (!missing(run)) {
    lifecycle::deprecate_warn("2.3.1", "run_examples(run)", 'run_example(run_dontrun)')
    run_dontrun <- run
  }
  if (!missing(test)) {
    lifecycle::deprecate_warn("2.3.1", "run_examples(test)", 'run_example(run_donttest)')
    run_donttest <- test
  }
  if (!missing(show)) {
    lifecycle::deprecate_warn("2.3.1", "run_examples(show)")
  }
  rlang::local_interactive(FALSE)

  pkg <- as.package(pkg)

  if (fresh) {
    to_run <-
        function(path, start, run_donttest, run_dontrun) devtools::run_examples(pkg = path, start = start, run_donttest = run_donttest, run_dontrun = run_dontrun, document = FALSE)

    callr::r(to_run, args = list(path = pkg$path, start = start, run_donttest = run_donttest, run_dontrun = run_dontrun), show = TRUE, spinner = FALSE, stderr = "2>&1")
    return(invisible())
  }

  if (document) {
    document(pkg)
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

  purrr::walk(files, function(x) pkgload::run_example(x, run_donttest = run_donttest, run_dontrun = run_dontrun))

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

  path_man <- path(pkg$path, "man")
  files <- dir_ls(path_man, regexp = "\\.[Rr]d$")
  names(files) <- path_file(files)
  files <- sort_ci(files)

  if (!is.null(start)) {
    topic <- pkgload::dev_help(start, dev_packages = pkg$package)
    start_path <- path_file(topic$path)

    start_pos <- which(names(files) == start_path)
    if (length(start_pos) == 1) {
      files <- files[-seq(1, start_pos - 1)]
    }
  }

  files
}
