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
#' @importFrom httr2 request req_body_multipart req_perform resp_check_status resp_body_string
#' @family build functions
#' @return The url with the check results (invisibly)
#' @export
check_mac_release <- function(pkg = ".", dep_pkgs = character(), args = NULL, manual = TRUE, quiet = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  pkg <- as.package(pkg)

  if (!quiet) {
    cli::cli_inform(c(
      "Building macOS version of {.pkg {pkg$package}} ({pkg$version})",
      i = "Using https://mac.r-project.org/macbuilder/submit.html."
    ))
  }

  built_path <- pkgbuild::build(pkg$path, tempdir(),
    args = args,
    manual = manual, quiet = quiet, ...
  )

  dep_built_paths <- character()
  for (i in seq_along(dep_pkgs)) {
    dep_pkg <- as.package(dep_pkgs[[i]])$path
    dep_built_paths[[i]] <- pkgbuild::build(dep_pkg, tempdir(),
      args = args,
      manual = manual, quiet = quiet, ...
    )
  }
  on.exit(file_delete(c(built_path, dep_built_paths)), add = TRUE)

  url <- "https://mac.r-project.org/macbuilder/v1/submit"

  rlang::check_installed("httr2")
  body <- list(pkgfile = upload_file(built_path))

  # upload_file function implemented in utils.R
  
  if (length(dep_built_paths) > 0) {
    uploads <- lapply(dep_built_paths, upload_file)
    names(uploads) <- rep("depfiles", length(uploads))
    body <- append(body, uploads)
  }

  req <- httr2::request(url)
  req <- httr2::req_body_multipart(req, !!!body)
  res <- httr2::req_perform(req)

  httr2::resp_check_status(res, info = "Uploading package")

  res_body <- httr2::resp_body_string(res)
  response_url <- regmatches(res_body, regexpr("https://mac\\.R-project\\.org/macbuilder/results/[0-9a-zA-Z\\-]+/", res_body))

  if (!quiet) {
    time <- strftime(Sys.time() + 10 * 60, "%I:%M %p")

    cli::cat_rule(col = "cyan")
    cli::cli_inform(c(
      i = "Check {.url {response_url}} for the results in 5-10 mins (~{time})."
    ))
  }

  invisible(response_url)
}


