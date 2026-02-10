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
test <- function(
  pkg = ".",
  filter = NULL,
  stop_on_failure = FALSE,
  export_all = TRUE,
  ...
) {
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

  load_package <- load_package_for_testing(pkg)
  testthat::test_local(
    pkg$path,
    filter = filter,
    stop_on_failure = stop_on_failure,
    load_package = load_package,
    ...
  )
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

  load_package <- load_package_for_testing(pkg)
  testthat::test_file(
    test_files,
    package = pkg$package,
    load_package = load_package,
    ...
  )
}

load_package_for_testing <- function(pkg) {
  if (pkg$package == "testthat") {
    # Must load testthat outside of testthat so tests are run with
    # dev testthat
    load_all(pkg$path, quiet = TRUE, helpers = FALSE)
    "none"
  } else {
    "source"
  }
}

#' @param report How to display the coverage report.
#'  * `"html"` opens an interactive report in the browser.
#'  * `"zero"` prints uncovered lines to the console.
#'  * `"silent"` returns the coverage object without display.
#'
#'  Defaults to `"html"` if interactive; otherwise to `"zero"`.
#' @export
#' @rdname test
test_coverage <- function(pkg = ".", report = NULL, ...) {
  rlang::check_installed(c("covr", "DT"))

  save_all()
  pkg <- as.package(pkg)
  cli::cli_inform(c(i = "Computing test coverage for {.pkg {pkg$package}}"))

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  withr::local_envvar(r_env_vars())
  coverage <- covr::package_coverage(pkg$path, ...)

  show_report(coverage, report = report, path = pkg$path)
}

#' @rdname test
#' @export
test_coverage_active_file <- function(
  file = find_active_file(),
  filter = TRUE,
  report = NULL,
  export_all = TRUE,
  ...
) {
  rlang::check_installed(c("covr", "DT"))
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  test_file <- find_test_file(file)
  test_dir <- path_dir(test_file)
  pkg <- as.package(test_dir)

  env <- load_all(pkg$path, quiet = TRUE, export_all = export_all)$env
  # this always ends up using the package DESCRIPTION, which will refer
  # to the source package because of the load_all() above
  testthat::local_test_directory(test_dir, pkg$package)

  # To correctly simulate test_file() we need to set up both a temporary
  # snapshotter (with correct directory specification) for snapshot comparisons
  # and a stop reporter to inform the user about test failures
  snap_reporter <- testthat::local_snapshotter(
    snap_dir = file.path(test_dir, "_snaps")
  )
  snap_reporter$start_file(basename(test_file))
  reporter <- testthat::MultiReporter$new(
    reporters = list(
      testthat::StopReporter$new(praise = FALSE),
      snap_reporter
    )
  )

  withr::local_envvar(r_env_vars())
  testthat::with_reporter(reporter, {
    coverage <- covr::environment_coverage(env, test_file, ...)
    reporter$end_file() # needed to write new snapshots
  })

  if (isTRUE(filter)) {
    coverage_name <- name_source(covr::display_name(coverage))
    local_name <- name_test(test_file)
    coverage <- coverage[coverage_name %in% local_name]
  }

  # Use relative paths
  attr(coverage, "relative") <- TRUE
  attr(coverage, "package") <- pkg

  show_report(coverage, report = report, path = pkg$path)
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

report_default <- function(report, call = rlang::caller_env()) {
  if (is.null(report)) {
    if (is_llm() || !rlang::is_interactive()) "zero" else "html"
  } else {
    rlang::arg_match(report, c("silent", "zero", "html"), error_call = call)
  }
}

show_report <- function(coverage, report, path, call = rlang::caller_env()) {
  report <- report_default(report, call = call)

  if (report == "html") {
    covered <- unique(covr::display_name(coverage))

    if (length(covered) == 1) {
      covr::file_report(coverage)
    } else {
      covr::report(coverage)
    }
  } else if (report == "zero") {
    zero <- covr::zero_coverage(coverage)
    if (nrow(zero) == 0) {
      cli::cli_inform(c(v = "All lines covered!"))
    } else {
      for (file in unique(zero$filename)) {
        file_zero <- zero[zero$filename == file, ]
        lines_by_fun <- split(file_zero$line, file_zero$functions)

        rel_path <- path_rel(file, path)
        cli::cli_inform("Uncovered lines in {.file {rel_path}}:")
        for (fun in names(lines_by_fun)) {
          lines <- paste0(collapse_lines(lines_by_fun[[fun]]), collapse = ", ")
          cli::cli_inform(c("*" = "{.fn {fun}}: {lines}"))
        }
      }
    }
  }
  invisible(coverage)
}

collapse_lines <- function(x) {
  x <- sort(unique(x))
  breaks <- c(0, which(diff(x) != 1), length(x))

  ranges <- character(length(breaks) - 1)
  for (i in seq_along(ranges)) {
    start <- x[breaks[i] + 1]
    end <- x[breaks[i + 1]]
    if (start == end) {
      ranges[i] <- as.character(start)
    } else {
      ranges[i] <- paste0(start, "-", end)
    }
  }
  ranges
}


#' Defunct functions
#'
#' These functions are defunct and will be removed in a future version of
#' devtools.
#' @name devtools-defunct
#' @keywords internal
NULL

#' @rdname devtools-defunct
#' @export
test_file <- function(file = find_active_file(), ...) {
  lifecycle::deprecate_stop("2.5.0", "test_file()", "test_active_file()")
}

#' @rdname devtools-defunct
#' @export
test_coverage_file <- function(file = find_active_file(), ...) {
  lifecycle::deprecate_stop(
    "2.5.0",
    "test_coverage_file()",
    "test_coverage_active_file()"
  )
}
