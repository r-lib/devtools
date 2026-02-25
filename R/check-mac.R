#' Check a package on macOS
#'
#' Check on either the released or development versions of R, using
#' <https://mac.r-project.org/macbuilder/>.
#'
#'
#' @template devtools
#' @inheritParams check_win
#' @param dep_pkgs Additional custom dependencies to install prior to checking
#'   the package.
#' @family build functions
#' @return The url with the check results (invisibly)
#' @export
check_mac_release <- function(
  pkg = ".",
  dep_pkgs = character(),
  args = NULL,
  manual = TRUE,
  quiet = FALSE,
  ...
) {
  check_dots_used(action = getOption("devtools.ellipsis_action", warn))

  check_mac(
    pkg = pkg,
    version = "R-release",
    dep_pkgs = dep_pkgs,
    args = args,
    manual = manual,
    quiet = quiet,
    ...
  )
}

#' @rdname check_mac_release
#' @export
check_mac_devel <- function(
  pkg = ".",
  dep_pkgs = character(),
  args = NULL,
  manual = TRUE,
  quiet = FALSE,
  ...
) {
  check_dots_used(action = getOption("devtools.ellipsis_action", warn))

  check_mac(
    pkg = pkg,
    version = "R-devel",
    dep_pkgs = dep_pkgs,
    args = args,
    manual = manual,
    quiet = quiet,
    ...
  )
}

check_mac <- function(
  pkg = ".",
  version = c("R-devel", "R-release"),
  dep_pkgs = character(),
  args = NULL,
  manual = TRUE,
  quiet = FALSE,
  ...
) {
  pkg <- as.package(pkg)

  version <- match.arg(version, several.ok = FALSE)

  if (!quiet) {
    cli::cli_inform(c(
      "Checking macOS version of {.pkg {pkg$package}} ({pkg$version})",
      i = "Using https://mac.r-project.org/macbuilder/submit.html."
    ))
  }

  built_path <- pkgbuild::build(
    pkg$path,
    tempdir(),
    args = args,
    manual = manual,
    quiet = quiet,
    ...
  )

  dep_built_paths <- character()
  for (i in seq_along(dep_pkgs)) {
    dep_pkg <- as.package(dep_pkgs[[i]])$path
    dep_built_paths[[i]] <- pkgbuild::build(
      dep_pkg,
      tempdir(),
      args = args,
      manual = manual,
      quiet = quiet,
      ...
    )
  }
  on.exit(file_delete(c(built_path, dep_built_paths)), add = TRUE)

  url <- "https://mac.r-project.org/macbuilder/v1/submit"

  check_installed("httr2")
  body <- list(
    pkgfile = curl::form_file(built_path),
    rflavor = tolower(version)
  )

  if (length(dep_built_paths) > 0) {
    uploads <- map(dep_built_paths, curl::form_file)
    names(uploads) <- rep("depfiles", length(uploads))
    body <- append(body, uploads)
  }

  req <- httr2::request(url) |>
    httr2::req_body_multipart(!!!body) |>
    httr2::req_headers(Accept = "application/json")
  resp <- httr2::req_perform(req)

  response_url <- httr2::resp_body_json(resp)$url

  if (!quiet) {
    time <- strftime(Sys.time() + 10 * 60, "%I:%M %p")

    cli::cat_rule(col = "cyan")
    cli::cli_inform(c(
      i = "Check {.url {response_url}} for the results in 5-10 mins (~{time})."
    ))
  }

  invisible(response_url)
}
