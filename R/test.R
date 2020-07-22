#' Execute testthat tests in a package
#'
#' @description
#' * `test()` runs all tests in a package. It's a shortcut for
#'   [testthat::test_dir()]
#' * `test_file()` runs `test()` on the active file.
#' * `test_coverage()` computes test coverage for your package. It's a
#'   shortcut for [covr::package_coverage()] plus [covr::report()].
#' * `test_coverage_file()` computes test coverage for the active file. It's a
#'   shortcut for [covr::file_coverage()] plus [covr::report()].
#'
#' @template devtools
#' @param ... additional arguments passed to wrapped functions.
#' @param file One or more source or test files. If a source file the
#'   corresponding test file will be run. The default is to use the active file
#'   in RStudio (if available).
#' @inheritParams testthat::test_dir
#' @inheritParams pkgload::load_all
#' @inheritParams run_examples
#' @export
test <- function(pkg = ".", filter = NULL, stop_on_failure = FALSE, export_all = TRUE, ...) {
  save_all()

  pkg <- as.package(pkg)

  if (!uses_testthat(pkg) && interactive()) {
    message("No testing infrastructure found. Create it?")
    if (menu(c("Yes", "No")) == 1) {
      usethis_use_testthat(pkg)
    }
    return(invisible())
  }

  testthat::test_local(
    pkg$path,
    filter = filter,
    stop_on_failure = stop_on_failure,
    ...
  )
}

#' @export
#' @rdname test
test_file <- function(file = find_active_file(), ...) {
  ext <- tolower(tools::file_ext(file))
  valid_files <- ext %in% c("r", src_ext)
  if (any(!valid_files)) {
    stop("file(s): ",
      paste0("'", file[!valid_files], "'", collapse = ", "),
      " are not valid R or src files",
      call. = FALSE
    )
  }

  is_source_file <- basename(dirname(file)) %in% c("R", "src")

  test_files <- normalizePath(winslash = "/", mustWork = FALSE, c(
    vapply(file[is_source_file], find_test_file, character(1)),
    file[!is_source_file]
  ))

  pkg <- as.package(dirname(file)[[1]])
  if (pkg$package != "devtools") {
    load_all(pkg$path, quiet = TRUE)
  }
  testthat::test_file(test_files, ...)
}

#' @param show_report Show the test coverage report.
#' @export
#' @rdname test
# we now depend on DT in devtools so DT is installed when users call test_coverage
test_coverage <- function(pkg = ".", show_report = interactive(), ...) {
  # This is just here to avoid a R CMD check NOTE about unused dependencies
  DT::datatable

  pkg <- as.package(pkg)

  save_all()

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  withr::local_envvar(r_env_vars())
  testthat::local_test_directory(pkg$path, pkg$package)

  coverage <- covr::package_coverage(pkg$path, ...)

  if (isTRUE(show_report)) {
    covr::report(coverage)
  }

  invisible(coverage)
}

#' @rdname test
#' @export
test_coverage_file <- function(file = find_active_file(), filter = TRUE, show_report = interactive(), export_all = TRUE, ...) {

  is_source_file <- basename(dirname(file)) %in% c("R", "src")

  source_files <- normalizePath(winslash = "/", mustWork = FALSE, c(
    vapply(file[!is_source_file], find_source_file, character(1)),
    file[is_source_file]
  ))

  test_files <- normalizePath(winslash = "/", mustWork = FALSE, c(
    vapply(file[is_source_file], find_test_file, character(1)),
    file[!is_source_file]
  ))

  pkg <- as.package(dirname(file)[[1]])

  env <- load_all(pkg$path, quiet = TRUE, export_all = export_all)$env

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  withr::local_envvar(r_env_vars())
  testthat::local_test_directory(pkg$path, pkg$package)
  reporter <- testthat::local_snapshotter(cleanup = TRUE)
  reporter$start_file(file, "test")

  withr::with_dir("tests/testthat", {
    testthat::with_reporter(reporter, {
      coverage <- covr::environment_coverage(env, test_files, ...)
    })
  })

  filter <- isTRUE(filter) && all(file.exists(source_files))

  if (isTRUE(filter)) {
    coverage <- coverage[covr::display_name(coverage) %in% source_files]
  }

  # Use relative paths
  attr(coverage, "relative") <- TRUE
  attr(coverage, "package") <- pkg

  if (isTRUE(show_report)) {
    if (isTRUE(filter)) {
      covr::file_report(coverage)
    } else {
      covr::report(coverage)
    }
  }

  invisible(coverage)
}



#' Does a package use testthat?
#'
#' @export
#' @keywords internal
uses_testthat <- function(pkg = ".") {
  pkg <- as.package(pkg)

  paths <- c(
    file.path(pkg$path, "inst", "tests"),
    file.path(pkg$path, "tests", "testthat")
  )

  any(dir.exists(paths))
}
