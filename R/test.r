#' Execute \pkg{test_that} tests in a package.
#'
#' `test()` is a shortcut for [testthat::test_dir()], it runs all of a
#'   package's tests.
#' `test_file` runs `test()` on the active file.
#' `test_coverage()` computes test coverage for your package. It is a shortcut
#'   for [covr::package_coverage()] and [covr::report()].
#' `test_coverage_file()` computes test coverage for the active file. Is a
#'   shortcut for [covr::file_coverage()] and [covr::report()].
#'
#' @md
#' @param pkg package description, can be path or package name. See
#'   [as.package()] for more information
#' @param ... additional arguments passed to [testthat::test_dir()] and
#'   [covr::package_coverage()]
#' @param file One or more source or test files. If a source file the
#'   corresponding test file will be run. The default is to use the active file
#'   in RStudio (if available).
#' @inheritParams testthat::test_dir
#' @inheritParams run_examples
#' @export
test <- function(pkg = ".", filter = NULL, ...) {
  check_suggested("testthat")

  save_all()

  pkg <- as.package(pkg)

  if (!uses_testthat(pkg) && interactive()) {
    message("No testing infrastructure found. Create it?")
    if (menu(c("Yes", "No")) == 1) {
      use_testthat(pkg)
    }
    return(invisible())
  }

  test_path <- find_test_dir(pkg$path)
  test_files <- dir(test_path, "^test.*\\.[rR]$")
  if (length(test_files) == 0) {
    message("No tests: no files in ", test_path, " match '^test.*\\.[rR]$'")
    return(invisible())
  }

  # Need to attach testthat so that (e.g.) context() is available
  # Update package dependency to avoid explicit require() call (#798)
  if (pkg$package != "testthat") {
    pkg$depends <- paste0("testthat, ", pkg$depends)
    if (grepl("^testthat, *$", pkg$depends))
      pkg$depends <- "testthat"
  }

  # Run tests in a child of the namespace environment, like
  # testthat::test_package
  message("Loading ", pkg$package)
  ns_env <- load_all(pkg$path, quiet = TRUE)$env

  message("Testing ", pkg$package)
  Sys.sleep(0.05); utils::flush.console() # Avoid misordered output in RStudio

  env <- new.env(parent = ns_env)

  testthat_args <- list(test_path, filter = filter, env = env, ... = ...)
  if (packageVersion("testthat") >= "1.0.2.9000") { # 2.0.0
    testthat_args <- c(testthat_args, load_helpers = FALSE)
  } else if (packageVersion("testthat") > "1.0.2") {
    testthat_args <- c(testthat_args, load_helpers = FALSE)
  }

  withr::with_options(c(useFancyQuotes = FALSE),
    withr::with_envvar(r_env_vars(),
      do.call(testthat::test_dir, testthat_args)
    )
  )
}

#' @param show_report Show the test coverage report.
#' @export
#' @rdname test
test_coverage <- function(pkg = ".", show_report = interactive(), ...) {
  pkg <- as.package(pkg)

  check_suggested("covr")

  save_all()

  withr::with_envvar(r_env_vars(),
    coverage <- covr::package_coverage(pkg$path, ...)
  )

  if (isTRUE(show_report)) {
    covr::report(coverage)
  }

  invisible(coverage)
}

find_test_dir <- function(path) {
  testthat <- file.path(path, "tests", "testthat")
  if (dir.exists(testthat)) return(testthat)

  inst <- file.path(path, "inst", "tests")
  if (dir.exists(inst)) return(inst)

  stop("No testthat directories found in ", path, call. = FALSE)
}

#' Return the path to one of the packages in the devtools test dir
#'
#' Devtools comes with some simple packages for testing. This function
#' returns the path to them.
#'
#' @param package Name of the test package.
#' @keywords internal
#' @examples
#' if (has_tests()) {
#' devtest("testUseData")
#' }
#' @export
devtest <- function(package) {
  stopifnot(has_tests())

  path <- system.file(package = "devtools", "tests", "testthat", package)
  if (path == "") stop(package, " not found", call. = FALSE)

  path
}

#' @inheritParams test
#' @rdname test
#' @export
uses_testthat <- function(pkg = ".") {
  pkg <- as.package(pkg)

  paths <- c(
    file.path(pkg$path, "inst", "tests"),
    file.path(pkg$path, "tests", "testthat")
  )

  any(dir.exists(paths))
}

#' @export
#' @rdname test
test_file <- function(file = find_active_file(), ...) {
  is_source_file <- basename(dirname(file)) == "R"

  has_r_ext <- grepl("\\.[rR]$", file)
  if (any(!has_r_ext)) {
    stop("file(s): ",
         paste0("'", file[!has_r_ext], "'", collapse = ", "),
         " are not R files", call. = FALSE)
  }

  file <- basename(file)
  file[!is_source_file] <- sub("^test-?", "", file[!is_source_file])

  file <- sub("\\.[rR]$", "", file)

  regex <- paste0("^", escape_special_regex(file), "$", collapse = "|")

  test(filter = regex, ...)
}

find_active_file <- function(arg = "file") {
  if (!rstudioapi::isAvailable()) {
    stop("Argument `", arg, "` is missing, with no default", call. = FALSE)
  }
  rstudioapi::getSourceEditorContext()$path
}

find_test_file <- function(file) {
  dir <- basename(dirname(file))
  if (dir != "R") {
    stop("Open file not in `R/` directory", call. = FALSE)
  }

  if (!grepl("\\.[Rr]$", file)) {
    stop("Open file is does not end in `.R`", call. = FALSE)
  }

  file.path("tests", "testthat", paste0("test-", basename(file)))
}

find_source_file <- function(file) {
  dir <- basename(dirname(file))

  if (dir != "testthat") {
    stop("Open file not in `tests/testthat/` directory", call. = FALSE)
  }

  if (!grepl("\\.[Rr]$", file)) {
    stop("Open file is does not end in `.R`", call. = FALSE)
  }

  file.path("R", gsub("^test-", "", basename(file)))
}

#' @rdname test
#' @export
test_coverage_file <- function(file = find_active_file(), filter = TRUE, show_report = interactive(), ...) {
  check_suggested("covr")

  is_source_file <- basename(dirname(file)) == "R"

  source_files <- normalizePath(winslash = "/", mustWork = FALSE, c(
    vapply(file[!is_source_file], find_source_file, character(1)),
    file[is_source_file]))

  test_files <- normalizePath(winslash = "/", mustWork = FALSE, c(
    vapply(file[is_source_file], find_test_file, character(1)),
    file[!is_source_file]))

  pkg <- as.package(dirname(file)[[1]])

  env <- load_all(pkg$path, quiet = TRUE)$env

  withr::with_envvar(r_env_vars(),
    withr::with_dir("tests/testthat", {
      coverage <- covr::environment_coverage(env, test_files, ...)
    })
  )

  if (isTRUE(filter)) {
    coverage <- coverage[covr::display_name(coverage) %in% source_files]
  }

  # Use relative paths
  attr(coverage, "relative") <- TRUE
  attr(coverage, "package") <- pkg

  if (isTRUE(show_report)) {
    covr::file_report(coverage)
  }

  invisible(coverage)
}
