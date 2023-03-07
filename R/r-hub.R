
#' Run CRAN checks for package on R-hub
#'
#' It runs [build()] on the package, with the arguments specified
#' in `args`, and then submits it to the R-hub builder at
#' <https://builder.r-hub.io>. The `interactive` option controls
#' whether the function waits for the check output. Regardless, after the
#' check is complete, R-hub sends an email with the results to the package
#' maintainer.
#'
#' @section About email validation on r-hub:
#' To build and check R packages on R-hub, you need to validate your
#' email address. This is because R-hub sends out emails about build
#' results. See more at [rhub::validate_email()].
#'
#' @param platforms R-hub platforms to run the check on. If `NULL`
#'   uses default list of CRAN checkers (one for each major platform, and
#'   one with extra checks if you have compiled code). You can also specify
#'   your own, see [rhub::platforms()] for a complete list.
#' @param email email address to notify, defaults to the maintainer
#'   address in the package.
#' @param interactive whether to show the status of the build
#'   interactively. R-hub will send an email to the package maintainer's
#'   email address, regardless of whether the check is interactive or not.
#' @param build_args Arguments passed to `R CMD build`
#' @param ... extra arguments, passed to [rhub::check_for_cran()].
#' @inheritParams check
#' @family build functions
#' @return a `rhub_check` object.
#'
#' @export

check_rhub <- function(pkg = ".",
                       platforms = NULL,
                       email = NULL,
                       interactive = TRUE,
                       build_args = NULL,
                       ...) {
  check_installed("rhub")
  pkg <- as.package(pkg)

  built_path <- build(pkg$path, tempdir(), quiet = !interactive,
                      args = build_args)
  on.exit(file_delete(built_path), add = TRUE)

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  status <- rhub::check_for_cran(
    path = built_path,
    email = email,
    platforms = platforms,
    show_status = interactive,
    ...
  )

  if (!interactive) {
    cli::cli_inform(c(v = "R-hub check for package {.pkg {pkg$package}} submitted."))
    status
  } else {
    status
  }
}
