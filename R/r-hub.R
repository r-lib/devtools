
#' Run CRAN checks for package on r-hub
#'
#' It runs \code{\link{build}} on the package, with the arguments specified
#' in \code{args}, and then submits it to the r-hub builder at
#' \url{https://builder.r-hub.io}. The \code{interactive} option controls
#' whether the function waits for the check output. Regardless, after the
#' check is complete, r-hub sends an email with the results to the package
#' maintainer.
#'
#' @section About email validation on r-hub:
#' To build and check R packages on r-hub, you need to validate your
#' email address. This is because r-hub sends out emails about build
#' results. See more at \code{\link[rhub]{validate_email}}.
#'
#' @param platforms R-hub platforms to run the check on. If \code{NULL}
#'   uses default list of CRAN checkers (one for each major platform, and
#'   one with extra checks if you have compiled code). You can also specify
#'   your own, see \code{\link[rhub]{platforms}} for a complete list.
#' @param email email address to notify, defaults to the maintainer
#'   address in the package.
#' @param interactive whether to show the status of the build
#'   interactively. R-hub will send an email to the package maintainer's
#'   email address, regardless of whether the check is interactive or not.
#' @param ... extra arguments, passed to \code{\link[pkgbuild]{build}}.
#' @inheritParams check
#' @family build functions, rhub functions
#' @return a \code{rhub_check} object.
#'
#' @export

check_rhub <- function(pkg = ".",
                       platforms = NULL,
                       email = NULL,
                       interactive = TRUE,
                       ...) {
  check_suggested("rhub")
  pkg <- as.package(pkg)

  built_path <- build(pkg$path, tempdir(), quiet = !interactive, ...)
  on.exit(unlink(built_path), add = TRUE)

  status <- rhub::check_for_cran(
    path = built_path,
    email = email,
    platforms = platforms,
    show_status = interactive
  )

  if (!interactive) {
    message("r-hub check for package ", sQuote(pkg$package), " submitted.")
    status
  } else {
    status
  }
}
