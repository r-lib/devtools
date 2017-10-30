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
#' @param document If \code{NA} and the package uses roxygen2, will
#'   rerun \code{\link{document}} prior to checking. Use \code{TRUE}
#'   and \code{FALSE} to override this default.
#' @param build_args Additional arguments passed to \code{R CMD build}
#' @param check_dir This argument is ignored, and exists only for backwards
#'   compatibility. \code{args = "--output=/foo/bar"} can be used to change the
#'   check directory.
#' @param ... Additional arguments passed on to \code{\link[pkgbuild]{build}()}.
#' @seealso \code{\link{release}} if you want to send the checked package to
#'   CRAN.
#' @export
check <- function(pkg = ".",
                  document = NA,
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
                  check_dir) {
  pkg <- as.package(pkg)
  withr::local_options(list(warn = 1))

  if (rstudioapi::hasFun("documentSaveAll")) {
    rstudioapi::documentSaveAll()
  }

  # document only if package uses roxygen, i.e. has RoxygenNote field
  if (identical(document, NA)) {
    document <- !is.null(pkg$roxygennote)
  }
  if (document) {
    document(pkg)
  }

  if (!quiet) {
    cat_rule(
      left = "Building",
      right = pkg$package,
      background_col = "blue",
      col = "white"
    )
    show_env_vars(pkgbuild::compiler_flags(FALSE))
  }

  withr::with_envvar(pkgbuild::compiler_flags(FALSE), action = "prefix", {
    built_path <- pkgbuild::build(
      pkg$path,
      tempdir(),
      quiet = quiet,
      args = build_args,
      manual = manual,
      ...
    )
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
    quiet = quiet
  )
}

#' @export
#' @rdname check
#' @param path Path to built package.
#' @param cran if \code{TRUE} (the default), check using the same settings as
#'   CRAN uses.
#' @param check_version Sets \code{_R_CHECK_CRAN_INCOMING_} env var.
#'   If \code{TRUE}, performs a number of checked related
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
#' @param quiet if \code{TRUE} suppresses output from this function.
check_built <- function(path = NULL, cran = TRUE,
                        check_version = FALSE, force_suggests = FALSE,
                        run_dont_test = FALSE, manual = FALSE, args = NULL,
                        env_vars = NULL, quiet = FALSE) {

  pkgname <- gsub("_.*?$", "", basename(path))

  args <- c("--timings", args)
  if (cran) {
    args <- c("--as-cran", args)
  }
  if (run_dont_test) {
    args <- c("--run-donttest", args)
  }

  if (manual && !pkgbuild::has_latex()) {
    message(
      "pdflatex not found! Not building PDF manual or vignettes.\n",
      "If you are planning to release this package, please run a check with ",
      "manual and vignettes beforehand."
    )
    manual <- FALSE
  }

  if (!manual) {
    args <- c(args, "--no-manual")
  }

  env_vars <- check_env_vars(cran, check_version, force_suggests, env_vars)
  if (!quiet) {
    cat_rule(
      left = "Checking",
      right = pkgname,
      background_col = "blue",
      col = "white"
    )
    show_env_vars(env_vars)
  }

  withr::with_envvar(env_vars, action = "prefix", {
    rcmdcheck::rcmdcheck(path, quiet = quiet, args = args)
  })
}

check_env_vars <- function(cran = FALSE, check_version = FALSE,
                           force_suggests = TRUE, env_vars = character()) {
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
  cat_line("Setting env vars:", col = "darkgrey")
  cat_bullet(paste0(format(names(env_vars)), ": ", unname(env_vars)), col = "darkgrey")
  cat_rule(col = "darkgrey")
}
