#' Check a package on macOS
#'
#' This function first bundles a source package, then uploads it to
#' <https://mac.r-project.org/macbuilder/submit.html>. This function returns a
#' link to the page where the check results will appear.
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
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  pkg <- as.package(pkg)

  if (!quiet) {
    cli::cli_inform(c(
      "Building macOS version of {.pkg {pkg$package}} ({pkg$version})",
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

  rlang::check_installed("httr")
  body <- list(pkgfile = httr::upload_file(built_path))

  if (length(dep_built_paths) > 0) {
    uploads <- lapply(dep_built_paths, httr::upload_file)
    names(uploads) <- rep("depfiles", length(uploads))
    body <- append(body, uploads)
  }

  res <- httr::POST(
    url,
    body = body,
    headers = list(
      "Content-Type" = "multipart/form-data"
    ),
    encode = "multipart"
  )

  httr::stop_for_status(res, task = "Uploading package")

  response_url <- httr::content(res)$url

  if (!quiet) {
    time <- strftime(Sys.time() + 10 * 60, "%I:%M %p")

    cli::cat_rule(col = "cyan")
    cli::cli_inform(c(
      i = "Check {.url {response_url}} for the results in 5-10 mins (~{time})."
    ))
  }

  invisible(response_url)
}
