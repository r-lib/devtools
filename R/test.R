#' Execute testthat tests in a package
#'
#' @description
#' * `test()` runs all tests in a package. It's a shortcut for
#'   [testthat::test_dir()]
#' * `test_active_file()` runs `test()` on the active file.
#' * `test_coverage()` computes test coverage for your package. It's a
#'   shortcut for [covr::package_coverage()] plus [covr::report()].
#' * `test_coverage_active_file()` computes test coverage for the active file. It's a
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

  if (!uses_testthat(pkg)) {
    cli::cli_inform(c(i = "No testing infrastructure found."))
    if (!interactive()) {
      ui_todo('Setup testing with {ui_code("usethis::use_testthat()")}.')
      return(invisible())
    }
    if (yesno("Create it?")) {
      return(invisible())
    }
    usethis_use_testthat(pkg)
    return(invisible())
  }

  cli::cli_inform(c(i = "Testing {.pkg {pkg$package}}"))
  withr::local_envvar(r_env_vars())
  testthat::test_local(
    pkg$path,
    filter = filter,
    stop_on_failure = stop_on_failure,
    ...
  )
}

#' @rdname devtools-deprecated
#' @export
test_file <- function(file = find_active_file(), ...) {
  lifecycle::deprecate_soft("2.4.0", "test_file()", "test_active_file()")
  test_active_file(file, ...)
}

#' @export
#' @rdname test
test_active_file <- function(file = find_active_file(), ...) {
  save_all()
  test_files <- find_test_file(file)
  pkg <- as.package(path_dir(test_files)[[1]])

  withr::local_envvar(r_env_vars())
  if (is_rstudio_running()) {
    rstudioapi::executeCommand("activateConsole", quiet = TRUE)
  }
  testthat::test_file(test_files, ..., load_package = "source")
}

#' @param show_report Show the test coverage report.
#' @export
#' @rdname test
test_coverage <- function(pkg = ".", show_report = interactive(), ...) {
  rlang::check_installed(c("covr", "DT"))

  save_all()
  pkg <- as.package(pkg)
  cli::cli_inform(c(i = "Computing test coverage for {.pkg {pkg$package}}"))

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  withr::local_envvar(r_env_vars())
  testthat::local_test_directory(pkg$path, pkg$package)
  coverage <- covr::package_coverage(pkg$path, ...)

  if (isTRUE(show_report)) {
    covr::report(coverage)
  }

  invisible(coverage)
}

#' @rdname devtools-deprecated
#' @export
test_coverage_file <- function(file = find_active_file(), ...) {
  lifecycle::deprecate_soft("2.4.0", "test_coverage()", "test_coverage_active_file()")
  test_coverage_active_file(file, ...)
}

#' @rdname test
#' @export
test_coverage_active_file <- function(file = find_active_file(), filter = TRUE, show_report = interactive(), export_all = TRUE, ...) {
  rlang::check_installed(c("covr", "DT"))

  save_all()
  test_files <- find_test_file(file)
  pkg <- as.package(path_dir(file)[[1]])

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  withr::local_envvar(r_env_vars())
  testthat::local_test_directory(pkg$path, pkg$package)
  reporter <- testthat::local_snapshotter()
  reporter$start_file(file, "test")

  env <- load_all(pkg$path, quiet = TRUE, export_all = export_all)$env
  testthat::with_reporter(reporter, {
    coverage <- covr::environment_coverage(env, test_files, ...)
  })

  if (isTRUE(filter)) {
    coverage_name <- name_source(covr::display_name(coverage))
    local_name <- name_test(file)
    coverage <- coverage[coverage_name %in% local_name]
  }

  # Use relative paths
  attr(coverage, "relative") <- TRUE
  attr(coverage, "package") <- pkg

  if (isTRUE(show_report)) {
    covered <- unique(covr::display_name(coverage))

    if (length(covered) == 1) {
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
    path(pkg$path, "inst", "tests"),
    path(pkg$path, "tests", "testthat")
  )

  any(dir_exists(paths))
}
