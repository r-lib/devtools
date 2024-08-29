#' Build and check a package
#'
#' @description
#' `check()` automatically builds and checks a source package, using all known
#' best practices. `check_built()` checks an already-built package.
#'
#' Passing `R CMD check` is essential if you want to submit your package to
#' CRAN: you must not have any ERRORs or WARNINGs, and you want to ensure that
#' there are as few NOTEs as possible.  If you are not submitting to CRAN, at
#' least ensure that there are no ERRORs or WARNINGs: these typically represent
#' serious problems.
#'
#' `check()` automatically builds a package before calling `check_built()`, as
#' this is the recommended way to check packages.  Note that this process runs
#' in an independent R session, so nothing in your current workspace will affect
#' the process. Under-the-hood, `check()` and `check_built()` rely on
#' [pkgbuild::build()] and [rcmdcheck::rcmdcheck()].
#'
#' @section Environment variables:
#'
#' Devtools does its best to set up an environment that combines best practices
#' with how check works on CRAN. This includes:
#'
#' * The standard environment variables set by devtools:
#' [r_env_vars()]. Of particular note for package tests is the `NOT_CRAN` env
#' var, which lets you know that your tests are running somewhere other than
#' CRAN, and hence can take a reasonable amount of time.
#'
#' * Debugging flags for the compiler, set by
#' [`compiler_flags(FALSE)`][compiler_flags()].
#'
#' * If `aspell` is found, `_R_CHECK_CRAN_INCOMING_USE_ASPELL_`
#' is set to `TRUE`. If no spell checker is installed, a warning is issued.
#'
#' * Environment variables, controlled by arguments `incoming`, `remote` and
#' `force_suggests`.
#'
#' @return An object containing errors, warnings, notes, and more.
#' @template devtools
#' @inheritParams rcmdcheck::rcmdcheck
#' @param document By default (`NULL`) will document if your installed
#'   roxygen2 version matches the version declared in the `DESCRIPTION`
#'   file. Use `TRUE` or `FALSE` to override the default.
#' @param build_args Additional arguments passed to `R CMD build`
#' @param ... Additional arguments passed on to [pkgbuild::build()].
#' @param vignettes If `FALSE`, do not build or check vignettes, equivalent to
#'   using `args = '--ignore-vignettes'` and `build_args = '--no-build-vignettes'`.
#' @param cleanup `r lifecycle::badge("deprecated")` See `check_dir` for details.
#' @seealso [release()] if you want to send the checked package to
#'   CRAN.
#' @export
check <- function(pkg = ".",
                  document = NULL,
                  build_args = NULL,
                  ...,
                  manual = FALSE,
                  cran = TRUE,
                  remote = FALSE,
                  incoming = remote,
                  force_suggests = FALSE,
                  run_dont_test = FALSE,
                  args = "--timings",
                  env_vars = c(NOT_CRAN = "true"),
                  quiet = FALSE,
                  check_dir = NULL,
                  cleanup = deprecated(),
                  vignettes = TRUE,
                  error_on = c("never", "error", "warning", "note")) {
  pkg <- as.package(pkg)
  withr::local_options(list(warn = 1))

  save_all()

  if (lifecycle::is_present(cleanup)) {
    lifecycle::deprecate_stop("1.11.0", "check(cleanup = )")
  }

  if (missing(error_on) && !interactive()) {
    error_on <- "warning"
  }
  error_on <- match.arg(error_on)

  document <- document %||% can_document(pkg)
  if (document) {
    if (!quiet) {
      cat_rule("Documenting", col = "cyan", line = 2)
    }
    document(pkg, quiet = quiet)
    if (!quiet) {
      cli::cat_line()
    }
  }

  if (!quiet) {
    cat_rule("Building", col = "cyan", line = 2)
    show_env_vars(pkgbuild::compiler_flags(FALSE))
  }

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  if (identical(vignettes, FALSE)) {
    args <- union(args, "--ignore-vignettes")
  }

  withr::with_envvar(pkgbuild::compiler_flags(FALSE), action = "prefix", {
    built_path <- pkgbuild::build(
      pkg$path,
      tempdir(),
      args = build_args,
      quiet = quiet,
      manual = manual,
      vignettes = vignettes,
      ...
    )
    on.exit(file_delete(built_path), add = TRUE)
  })

  check_built(
    built_path,
    cran = cran,
    remote = remote,
    incoming = incoming,
    force_suggests = force_suggests,
    run_dont_test = run_dont_test,
    manual = manual,
    args = args,
    env_vars = env_vars,
    quiet = quiet,
    check_dir = check_dir,
    error_on = error_on
  )
}

can_document <- function(pkg) {
  required <- pkg$roxygennote
  if (is.null(required)) {
    # Doesn't use roxygen2 at all
    return(FALSE)
  }

  installed <- packageVersion("roxygen2")
  if (required != installed) {
    cli::cat_rule("Documenting", col = "red", line = 2)
    cli::cli_inform(c(
      i = "Installed roxygen2 version ({installed}) doesn't match required ({required})",
      x = "{.fun check} will not re-document this package"
    ))
    FALSE
  } else {
    TRUE
  }
}

#' @export
#' @rdname check
#' @param path Path to built package.
#' @param cran if `TRUE` (the default), check using the same settings as CRAN
#'   uses. Because this is a moving target and is not uniform across all of
#'   CRAN's machine, this is on a "best effort" basis. It is more complicated
#'   than simply setting `--as-cran`.
#' @param remote Sets `_R_CHECK_CRAN_INCOMING_REMOTE_` env var. If `TRUE`,
#'   performs a number of CRAN incoming checks that require remote access.
#' @param incoming Sets `_R_CHECK_CRAN_INCOMING_` env var. If `TRUE`, performs a
#'   number of CRAN incoming checks.
#' @param force_suggests Sets `_R_CHECK_FORCE_SUGGESTS_`. If `FALSE` (the
#'   default), check will proceed even if all suggested packages aren't found.
#' @param run_dont_test Sets `--run-donttest` so that examples surrounded in
#'   `\donttest{}` are also run. When `cran = TRUE`, this only affects R 3.6 and
#'   earlier; in R 4.0, code in `\donttest{}` is always run as part of CRAN
#'   submission.
#' @param manual If `FALSE`, don't build and check manual (`--no-manual`).
#' @param env_vars Environment variables set during `R CMD check`
#' @param quiet if `TRUE` suppresses output from this function.
#' @param error_on Whether to throw an error on `R CMD check` failures. Note
#'   that the check is always completed (unless a timeout happens), and the
#'   error is only thrown after completion.
#'
#'   `error_on` is passed through to [rcmdcheck::rcmdcheck()], which is the
#'   definitive source for what the different values mean. If not specified by
#'   the user, both `check()` and `check_built()` default to `error_on =
#'   "never"` in interactive use and `"warning"` in a non-interactive setting.
check_built <- function(path = NULL, cran = TRUE,
                        remote = FALSE, incoming = remote, force_suggests = FALSE,
                        run_dont_test = FALSE, manual = FALSE, args = "--timings",
                        env_vars = NULL, check_dir = tempdir(), quiet = FALSE,
                        error_on = c("never", "error", "warning", "note")) {
  if (missing(error_on) && !interactive()) {
    error_on <- "warning"
  }
  error_on <- match.arg(error_on)

  pkgname <- gsub("_.*?$", "", path_file(path))

  if (cran) {
    args <- c("--as-cran", args)
    env_vars <- c(
      "_R_CHECK_PACKAGES_USED_IGNORE_UNUSED_IMPORTS_" = as.character(FALSE),
      env_vars
    )
  }
  if (run_dont_test) {
    args <- c("--run-donttest", args)
  }

  if (manual && !pkgbuild::has_latex()) {
    cli::cli_inform(c(x = "pdflatex not found! Not building PDF manual"))
    manual <- FALSE
  }

  if (!manual) {
    args <- c(args, "--no-manual")
  }

  env_vars <- check_env_vars(cran, remote, incoming, force_suggests, env_vars)
  if (!quiet) {
    cat_rule("Checking", col = "cyan", line = 2)
    show_env_vars(env_vars)
  }

  withr::with_envvar(env_vars, action = "replace", {
    rcmdcheck::rcmdcheck(path,
      quiet = quiet, args = args,
      check_dir = check_dir, error_on = error_on
    )
  })
}

check_env_vars <- function(cran = FALSE, remote = FALSE, incoming = remote,
                           force_suggests = TRUE, env_vars = character()) {
  c(
    aspell_env_var(),
    # Switch off expensive check for package version
    # https://github.com/r-lib/devtools/issues/1271
    if (getRversion() >= "3.4.0" && as.numeric(R.version[["svn rev"]]) >= 70944) {
      c("_R_CHECK_CRAN_INCOMING_REMOTE_" = as.character(remote))
    },
    "_R_CHECK_CRAN_INCOMING_" = as.character(incoming),
    "_R_CHECK_FORCE_SUGGESTS_" = as.character(force_suggests),
    env_vars
  )
}

aspell_env_var <- function() {
  tryCatch({
    utils::aspell(NULL, program = "aspell")
    c("_R_CHECK_CRAN_INCOMING_USE_ASPELL_" = "TRUE")
  }, error = function(e) character())
}

show_env_vars <- function(env_vars) {
  cli::cat_line("Setting env vars:", col = "darkgrey")
  cat_bullet(paste0(format(names(env_vars)), ": ", unname(env_vars)), col = "darkgrey")
}
