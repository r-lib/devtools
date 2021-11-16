#' Check macOS package
#'
#' This function works by bundling source package, and then uploading to
#' <https://mac.r-project.org/macbuilder/submit.html>.  Once building is
#' complete you'll receive a link to the built package in the email address
#' listed in the maintainer field.
#'
#' @template devtools
#' @inheritParams pkgbuild::build
#' @param email An alternative email to use, default `NULL` uses the package
#'   Maintainer's email.
#' @param quiet If `TRUE`, suppresses output.
#' @param ... Additional arguments passed to [pkgbuild::build()].
#' @family build functions
#' @return The url with the check results (invisibly)
#' @export
check_mac_release <- function(pkg = ".", args = NULL, manual = TRUE, email = NULL, quiet = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  pkg <- as.package(pkg)

  if (!is.null(email)) {
    desc_file <- path(pkg$path, "DESCRIPTION")
    backup <- file_temp()
    file_copy(desc_file, backup)
    on.exit(file_move(backup, desc_file), add = TRUE)

    change_maintainer_email(desc_file, email)

    pkg <- as.package(pkg$path)
  }

  if (!quiet) {
    cli::cli_alert_info(
      "Building macOS version of {.pkg {pkg$package}} ({pkg$version})",
      "with https://mac.r-project.org/macbuilder/submit.html."
    )
  }

  built_path <- pkgbuild::build(pkg$path, tempdir(),
    args = args,
    manual = manual, quiet = quiet, ...
  )
  on.exit(file_delete(built_path), add = TRUE)

  url <- "https://mac.r-project.org/macbuilder/v1/submit"

  res <- httr::POST(url,
    body = list(
      pkgfile = httr::upload_file(built_path)
    ),
    headers = list(
      "Content-Type" = "multipart/form-data"
    ),
    encode = "multipart"
  )

  httr::stop_for_status(res)

  response_url <- httr::content(res)$url

  if (!quiet) {
    time <- strftime(Sys.time() + 30 * 60, "%I:%M %p")

    cli::cli_alert_success(
      "[{Sys.Date()}] Check {.url {response_url}} for a link to results in 15-30 mins (~{time})."
    )
  }

  invisible(response_url)
}
