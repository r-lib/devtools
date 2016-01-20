#' Build and check a package, cleaning up automatically on success.
#'
#' \code{check} automatically builds and checks a source package, using all
#' known best practices. Passing \code{R CMD check} is essential if you want to
#' submit your package to CRAN: you must not have any ERRORs or WARNINGs, and
#' you want to ensure that there are as few NOTEs as possible.  If you are not
#' submitting to CRAN, at least ensure that there are no ERRORs: these
#' typically represent serious problems.
#'
#' \code{check} automatically builds a package before using \code{R CMD check}
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
#'
#' }
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param document if \code{TRUE} (the default), will update and check
#'   documentation before running formal check.
#' @param cleanup if \code{TRUE} the check directory is removed if the check
#'   is successful - this allows you to inspect the results to figure out what
#'   went wrong. If \code{FALSE} the check directory is never removed.
#' @param cran if \code{TRUE} (the default), check using the same settings as
#'   CRAN uses.
#' @param check_version Sets \code{_R_CHECK_CRAN_INCOMING_} env var.
#'   If \code{TRUE}, performns a number of checked related
#'   to version numbers of packages on CRAN.
#' @param force_suggests Sets \code{_R_CHECK_FORCE_SUGGESTS_}. If
#'   \code{FALSE} (the default), check will proceed even if all suggested
#'   packages aren't found.
#' @param args,build_args An optional character vector of additional command
#'   line arguments to be passed to \code{R CMD check}/\code{R CMD build}/\code{R CMD INSTALL}.
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @param check_dir the directory in which the package is checked
#' @param ... Additional arguments passed to \code{\link{build}}
#' @seealso \code{\link{release}} if you want to send the checked package to
#'   CRAN.
#' @export
check <- function(pkg = ".", document = TRUE, cleanup = TRUE, cran = TRUE,
                  check_version = FALSE, force_suggests = FALSE, args = NULL,
                  build_args = NULL, quiet = FALSE, check_dir = tempdir(),
                  ...) {

  pkg <- as.package(pkg)

  if (document) {
    document(pkg)
  }

  show_env_vars(compiler_flags(FALSE))
  withr::with_envvar(compiler_flags(FALSE), {

    rule("Building ", pkg$package)
    built_path <- build(pkg, tempdir(), quiet = quiet, args = build_args, ...)
    on.exit(unlink(built_path), add = TRUE)

    r_cmd_check_path <- check_r_cmd(pkg$package, built_path, cran, check_version,
      force_suggests, args, quiet = quiet, check_dir = check_dir)

    if (cleanup) {
      unlink(r_cmd_check_path, recursive = TRUE)
    } else {
      if (!quiet) message("R CMD check results in ", r_cmd_check_path)
    }

    invisible(TRUE)
  }, "prefix")
}


# Run R CMD check and return the path for the check
# @param built_path The path to the built .tar.gz source package.
# @param check_dir The directory to unpack the .tar.gz file to
check_r_cmd <- function(name, built_path = NULL, cran = TRUE,
                        check_version = FALSE, force_suggests = FALSE,
                        args = NULL, check_dir = tempdir(), quiet = FALSE, ...) {

  pkgname <- gsub("_.*?$", "", basename(built_path))

  opts <- "--timings"
  if (!has_latex()) {
    message("pdflatex not found! Not building PDF manual or vignettes.\n",
      "If you are planning to release this package, please run a check with manual and vignettes beforehand.\n")
    opts <- c(opts, "--no-build-vignettes", "--no-manual")
  }
  if (cran) {
    opts <- c("--as-cran", "--run-donttest", opts)
  }

  env_vars <- check_env_vars(cran, check_version, force_suggests)
  if (!quiet)
    show_env_vars(env_vars)

  if (!quiet)
    rule("Checking ", name)
  opts <- paste(paste(opts, collapse = " "), paste(args, collapse = " "))
  R(paste("CMD check ", shQuote(built_path), " ", opts, sep = ""), check_dir,
    env_vars, quiet = quiet, ...)

  # Return the path to the check output
  file.path(normalizePath(check_dir), paste(pkgname, ".Rcheck", sep = ""))
}

check_env_vars <- function(cran = FALSE, check_version = FALSE,
                           force_suggests = TRUE) {
  c(
    aspell_env_var(),
    "_R_CHECK_CRAN_INCOMING_" = as.character(check_version),
    "_R_CHECK_FORCE_SUGGESTS_" = as.character(force_suggests)
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
