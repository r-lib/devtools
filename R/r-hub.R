#' Run CRAN checks for package on R-hub
#'
#' It runs an R-hub GitHub action on the package.
#' Used to check if the package passes CRAN checks on
#' different platforms and R versions.
#'
#' @section GitHub and R-hub:
#' To use R-hub you must first setup a GitHub repository.
#' Use [usethis::use_github()] to do that. Then setup your
#' R-hub GH Action with [rhub::rhub_setup()].
#'
#' @param platforms Platforms to use, a character vector.
#' Defaults to most common platforms. Use NULL to select from
#' a list in interactive sessions. See [rhub::rhub_platforms()].
#'
#' @inheritParams rhub::rhub_check
#' @family build functions
#' @return NULL
#'
#' @export

rhub_check <- function(gh_url = NULL,
                       platforms = c("ubuntu-release", "windows", "macos"),
                       r_versions = NULL,
                       branch = NULL) {
  rlang::check_installed("rhub", version = "2.0.0")

  rhub::rhub_doctor(gh_url = gh_url)

  rhub::rhub_check(gh_url = gh_url,
                   platforms = platforms,
                   r_versions = r_versions,
                   branch = branch)
}

#' @rdname rhub_check
#' @export

check_rhub <- function(gh_url = NULL,
                       platforms = c("ubuntu-release", "windows", "macos"),
                       r_versions = NULL,
                       branch = NULL) {
  lifecycle::deprecate_soft(when = "2.4.6", what = "check_rhub()", with = "rhub_check()")
  rhub_check(gh_url = gh_url,
             platforms = platforms,
             r_versions = r_versions,
             branch = branch)
}
