
#' Build and check packag on r-hub
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
#' @param platform the r-hub platform to run the check on. See
#'   \code{\link[rhub]{platforms}} for the current platform list.
#'   if \code{NULL}, then the desired platform can be selected
#'   interactively.
#' @param interactive whether to show the status of the build
#'   interactively. R-hub will send an email to the package maintainer's
#'   email address, regardless of whether the check is interactive or not.
#' @param ... extra arguments, passed to \code{\link{build}}.
#' @inheritParams build
#' @family build functions, rhub functions
#' @return a handle that can be used to query the build status
#'   with \code{\link{rhub_check_status}}.
#'
#' @export

rhub_check <- function(pkg = ".", platform = NULL,
                       interactive = FALSE, ...) {

  pkg <- as.package(pkg)

  built_path <- build(pkg, tempdir(), quiet = !interactive, ...)
  on.exit(unlink(built_path), add = TRUE)

  status <- rhub::check(
    built_path,
    email = maintainer(pkg)$email,
    platform = platform,
    show_status = interactive
  )

  if (!interactive) {
    message("r-hub check for package ", sQuote(pkg$package), " submitted.")
    status
  } else {
    invisible(status)
  }
}

#' Check status of an r-hub check submission
#'
#' @param handle the handle returned by \code{\link{rhub_check}},
#'   or an r-hub job status URL, as printed by \code{\link{rhub_check}}.
#' @family rhub functions
#' @return A list containing the status of the build, which can be
#'   \sQuote{preparing}, \sQuote{in progress}, \sQuote{success} and
#'   \sQuote{error}.
#'
#' @export

rhub_check_status <- function(handle) {
  rhub::status(handle)
}
