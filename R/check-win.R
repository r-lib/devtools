#' Check a package on Windows
#'
#' This function first bundles a source package, then uploads it to
#' <https://win-builder.r-project.org/>. Once the service has built and checked
#' the package, an email is sent to address of the maintainer listed in
#' `DESCRIPTION`. This usually takes around 30 minutes. The email contains a
#' link to a directory with the package binary and check logs, which will be
#' deleted after a couple of days.
#'
#' @template devtools
#' @inheritParams pkgbuild::build
#' @param manual Should the manual be built?
#' @param email An alternative email address to use. If `NULL`, the default is
#'   to use the package maintainer's email.
#' @param quiet If `TRUE`, suppresses output.
#' @param webform If `TRUE`, uses web form instead of passive FTP upload.
#' @param ... Additional arguments passed to [pkgbuild::build()].
#' @family build functions
#' @name check_win
NULL

#' @describeIn check_win Check package on the development version of R.
#' @export
check_win_devel <- function(pkg = ".", args = NULL, manual = TRUE, email = NULL, quiet = FALSE, webform = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  check_win(
    pkg = pkg, version = "R-devel", args = args, manual = manual,
    email = email, quiet = quiet, webform = webform, ...
  )
}

#' @describeIn check_win Check package on the released version of R.
#' @export
check_win_release <- function(pkg = ".", args = NULL, manual = TRUE, email = NULL, quiet = FALSE, webform = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  check_win(
    pkg = pkg, version = "R-release", args = args, manual = manual,
    email = email, quiet = quiet, webform = webform, ...
  )
}

#' @describeIn check_win Check package on the previous major release version of R.
#' @export
check_win_oldrelease <- function(pkg = ".", args = NULL, manual = TRUE, email = NULL, quiet = FALSE, webform = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  check_win(
    pkg = pkg, version = "R-oldrelease", args = args, manual = manual,
    email = email, quiet = quiet, webform = webform, ...
  )
}

check_win <- function(pkg = ".", version = c("R-devel", "R-release", "R-oldrelease"),
                      args = NULL, manual = TRUE, email = NULL, quiet = FALSE,
                      webform = FALSE, ...) {
  pkg <- as.package(pkg)

  if (!is.null(email)) {
    desc_file <- path(pkg$path, "DESCRIPTION")
    backup <- file_temp()
    file_copy(desc_file, backup)
    on.exit(file_move(backup, desc_file), add = TRUE)

    change_maintainer_email(desc_file, email, call = parent.frame())

    pkg <- as.package(pkg$path)
  }

  version <- match.arg(version, several.ok = TRUE)

  if (!quiet) {
    cli::cli_inform(c(
      "Building windows version of {.pkg {pkg$package}} ({pkg$version})",
      i = "Using {paste(version, collapse = ', ')} with win-builder.r-project.org."
    ))

    email <- maintainer(pkg)$email
    if (interactive() && yesno("Email results to {.strong {email}}?")) {
      return(invisible())
    }
  }

  built_path <- pkgbuild::build(pkg$path, tempdir(),
                                args = args,
                                manual = manual, quiet = quiet, ...
  )
  on.exit(file_delete(built_path), add = TRUE)

  if (webform) {
    submit_winbuilder_webform(built_path, version)
  } else {
    submit_winbuilder_ftp(built_path, version)
  }

  if (!quiet) {
    time <- strftime(Sys.time() + 30 * 60, "%I:%M %p")
    email <- maintainer(pkg)$email

    cli::cat_rule(col = "cyan")
    cli::cli_inform(c(
      i = "Check <{.email {email}}> for the results in 15-30 mins (~{time})."
    ))
  }

  invisible()
}

submit_winbuilder_ftp <- function(path, version) {
  url <- paste0("ftp://win-builder.r-project.org/", version, "/", path_file(path))
  lapply(url, upload_ftp, file = path)
}

submit_winbuilder_webform <- function(path, version) {
  lapply(version, upload_webform, file = path)
}

change_maintainer_email <- function(path, email, call = parent.frame()) {
  desc <- desc::desc(file = path)

  if (!desc$has_fields("Authors@R")) {
    cli::cli_abort(
      "DESCRIPTION must use {.field Authors@R} field when changing {.arg email}",
      call = call
    )
  }
  if (desc$has_fields("Maintainer")) {
    cli::cli_abort(
      "DESCRIPTION can't use {.field Maintainer} field when changing {.arg email}",
      call = call
    )
  }

  aut <- desc$get_authors()
  roles <- aut$role
  ## Broken person() API, vector for 1 author, list otherwise...
  if (!is.list(roles)) {
    roles <- list(roles)
  }
  is_maintainer <- vapply(roles, function(r) all("cre" %in% r), logical(1))
  aut[is_maintainer]$email <- email
  desc$set_authors(aut)

  desc$write()
}

upload_ftp <- function(file, url, verbose = FALSE) {
  rlang::check_installed("curl")

  stopifnot(file_exists(file))
  stopifnot(is.character(url))
  con <- file(file, open = "rb")
  on.exit(close(con), add = TRUE)
  h <- curl::new_handle(upload = TRUE, filetime = FALSE)
  curl::handle_setopt(h, readfunction = function(n) {
    readBin(con, raw(), n = n)
  }, verbose = verbose)
  curl::curl_fetch_memory(url, handle = h)
}

extract_hidden_fields <- function(html_text) {
  extract_value <- function(name) {
    pattern <- sprintf('name="%s"[^>]*value="([^"]+)"', name)
    match <- regexec(pattern, html_text)
    result <- regmatches(html_text, match)
    if (length(result[[1]]) >= 2) result[[1]][2] else NA_character_
  }

  list(
    `__VIEWSTATE` = extract_value("__VIEWSTATE"),
    `__VIEWSTATEGENERATOR` = extract_value("__VIEWSTATEGENERATOR"),
    `__EVENTVALIDATION` = extract_value("__EVENTVALIDATION")
  )
}

upload_webform <- function(file, version) {
  rlang::check_installed("httr")

  upload_url <- "https://win-builder.r-project.org/upload.aspx"
  form_page <- httr::GET(upload_url)
  html_text <- httr::content(form_page, as = "text")

  field_map <- list(
    "R-release" = list(file = "FileUpload1", button = "Button1"),
    "R-devel" = list(file = "FileUpload2", button = "Button2"),
    "R-oldrelease" = list(file = "FileUpload3", button = "Button3")
  )

  fields <- field_map[[version]]

  body <- extract_hidden_fields(html_text)
  body[[fields$file]] <- httr::upload_file(file)
  body[[fields$button]] <- "Upload File"

  r <- httr::POST(
    url = upload_url,
    body = body,
    encode = "multipart"
  )
  httr::stop_for_status(r)
}
