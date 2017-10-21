#' Execute all \pkg{test_that} tests in a package.
#'
#' `test()` is a shortcut for [testthat::test_dir()].
#' `test_coverage()` is a shortcut for [covr::package_coverage()].
#'
#' @md
#' @param pkg package description, can be path or package name. See
#'   [as.package()] for more information
#' @param ... additional arguments passed to [testthat::test_dir()] and
#'   [covr::package_coverage()]
#' @inheritParams testthat::test_dir
#' @inheritParams run_examples
#' @export
test <- function(pkg = ".", filter = NULL, ...) {
  check_suggested("testthat")

  if (rstudioapi::hasFun("documentSaveAll")) {
    rstudioapi::documentSaveAll()
  }

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
    testthat_args <- c(testthat_args,
      load_helpers = FALSE,
      encoding = pkg$encoding %||% "unknown"
    )
  }

  withr::with_envvar(r_env_vars(),
    do.call(testthat::test_dir, testthat_args))
}

#' @export
#' @rdname test
test_coverage <- function(pkg = ".", ...) {
  pkg <- as.package(pkg)

  check_suggested("covr")

  coverage <- covr::package_coverage(pkg$path, ...)
  covr::report(coverage)

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
