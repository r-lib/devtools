#' Build and check a package, cleaning up automatically on success.
#'
#' \code{check} automatically builds and checks a source package, using all
#' known best practices. \code{check_built} checks an already built package.
#'
#' Passing \code{R CMD check} is essential if you want to submit your package
#' to CRAN: you must not have any ERRORs or WARNINGs, and you want to ensure
#' that there are as few NOTEs as possible.  If you are not submitting to CRAN,
#' at least ensure that there are no ERRORs or WARNINGs: these typically
#' represent serious problems.
#'
#' \code{check} automatically builds a package before calling \code{check_built}
#' as this is the recommended way to check packages.  Note that this process
#' runs in an independent realisation of R, so nothing in your current
#' workspace will affect the process.
#'
#' @section Environment variables:
#'
#' Devtools does its best to set up an environment that combines best practices
#' with how check works on CRAN. This includes:
#'
#' \itemize{
#'
#'  \item The standard environment variables set by devtools:
#'    \code{\link{r_env_vars}}. Of particular note for package tests is the
#'    \code{NOT_CRAN} env var which lets you know that your tests are not
#'    running on cran, and hence can take a reasonable amount of time.
#'
#'  \item Debugging flags for the compiler, set by
#'    \code{\link{compiler_flags}(FALSE)}.
#'
#'  \item If \code{aspell} is found \code{_R_CHECK_CRAN_INCOMING_USE_ASPELL_}
#'   is set to \code{TRUE}. If no spell checker is installed, a warning is
#'   issued.)
#'
#'  \item env vars set by arguments \code{check_version} and
#'    \code{force_suggests}
#' }
#'
#' @return An object containing errors, warnings, and notes.
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param document if \code{TRUE} (the default), will update and check
#'   documentation before running formal check.
#' @param build_args Additional arguments passed to \code{R CMD build}
#' @param ... Additional arguments passed on to \code{\link{build}()}.
#' @param cleanup Deprecated.
#' @seealso \code{\link{release}} if you want to send the checked package to
#'   CRAN.
#' @export
check <- function(pkg = ".",
                  document = TRUE,
                  build_args = NULL,
                  ...,
                  manual = FALSE,
                  cran = TRUE,
                  check_version = FALSE,
                  force_suggests = FALSE,
                  run_dont_test = FALSE,
                  args = NULL,
                  env_vars = NULL,
                  quiet = FALSE,
                  check_dir = tempdir(),
                  cleanup = TRUE) {
  pkg <- as.package(pkg)
  if (!missing(cleanup)) {
    warning("`cleanup` is deprecated", call. = FALSE)
  }

  if (document) {
    document(pkg)
  }

  if (!quiet) {
    show_env_vars(compiler_flags(FALSE))
    rule("Building ", pkg$package)
  }

  withr::with_envvar(compiler_flags(FALSE), action = "prefix", {
    built_path <- build(pkg, tempdir(), quiet = quiet, args = build_args,
                        manual = manual, ...)
    on.exit(unlink(built_path), add = TRUE)
  })

  check_built(
    built_path,
    cran = cran,
    check_version = check_version,
    force_suggests = force_suggests,
    run_dont_test = run_dont_test,
    manual = manual,
    args = args,
    env_vars = env_vars,
    quiet = quiet,
    check_dir = check_dir
  )
}

#' @export
#' @rdname check
#' @param path Path to built package.
#' @param cran if \code{TRUE} (the default), check using the same settings as
#'   CRAN uses.
#' @param check_version Sets \code{_R_CHECK_CRAN_INCOMING_} env var.
#'   If \code{TRUE}, performns a number of checked related
#'   to version numbers of packages on CRAN.
#' @param force_suggests Sets \code{_R_CHECK_FORCE_SUGGESTS_}. If
#'   \code{FALSE} (the default), check will proceed even if all suggested
#'   packages aren't found.
#' @param run_dont_test Sets \code{--run-donttest} so that tests surrounded in
#'   \code{\\dontest\{\}} are also tested. This is important for CRAN
#'   submission.
#' @param manual If \code{FALSE}, don't build and check manual
#'   (\code{--no-manual}).
#' @param args Additional arguments passed to \code{R CMD check}
#' @param env_vars Environment variables set during \code{R CMD check}
#' @param check_dir the directory in which the package is checked
#' @param quiet if \code{TRUE} suppresses output from this function.
check_built <- function(path = NULL, cran = TRUE,
                        check_version = FALSE, force_suggests = FALSE,
                        run_dont_test = FALSE, manual = FALSE, args = NULL,
                        env_vars = NULL,
                        check_dir = tempdir(), quiet = FALSE) {

  pkgname <- gsub("_.*?$", "", basename(path))

  args <- c("--timings", args)
  if (cran) {
    args <- c("--as-cran", args)
  }
  if (run_dont_test) {
    args <- c("--run-donttest", args)
  }

  if (manual && !has_latex(verbose = TRUE)) {
    manual <- FALSE
  }

  if (!manual) {
    args <- c(args, "--no-manual")
  }

  env_vars <- check_env_vars(cran, check_version, force_suggests, env_vars)
  if (!quiet) {
    show_env_vars(env_vars)
    rule("Checking ", pkgname)
  }

  R(c(paste("CMD check", shQuote(path)), args),
    path = check_dir,
    env_vars = env_vars,
    quiet = quiet,
    throw = FALSE
  )

  package_path <- file.path(
    normalizePath(check_dir),
    paste(pkgname, ".Rcheck", sep = "")
  )
  if (!file.exists(package_path)) {
    stop("Check failed: '", package_path, "' doesn't exist", call. = FALSE)
  }

  # Record successful completion
  writeLines("OK", file.path(package_path, "COMPLETE"))

  log_path <- file.path(package_path, "00check.log")
  parse_check_results(log_path)
}

check_env_vars <- function(cran = FALSE, check_version = FALSE,
                           force_suggests = TRUE, env_vars) {
  c(
    aspell_env_var(),
    "_R_CHECK_CRAN_INCOMING_" = as.character(check_version),
    "_R_CHECK_FORCE_SUGGESTS_" = as.character(force_suggests),
    env_vars
  )
}

aspell_env_var <- function() {
  tryCatch({
    utils::aspell(NULL)
    c("_R_CHECK_CRAN_INCOMING_USE_ASPELL_" = "TRUE")
  }, error = function(e) character())
}

show_env_vars <- function(env_vars) {
  rule("Setting env vars")
  message(paste0(format(names(env_vars)), ": ", unname(env_vars), collapse = "\n"))
}
