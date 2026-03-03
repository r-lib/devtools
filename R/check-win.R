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
check_win_devel <- function(
  pkg = ".",
  args = NULL,
  manual = TRUE,
  email = NULL,
  quiet = FALSE,
  webform = FALSE,
  ...
) {
  check_dots_used(action = getOption("devtools.ellipsis_action", warn))

  check_win(
    pkg = pkg,
    version = "R-devel",
    args = args,
    manual = manual,
    email = email,
    quiet = quiet,
    webform = webform,
    ...
  )
}

#' @describeIn check_win Check package on the released version of R.
#' @export
check_win_release <- function(
  pkg = ".",
  args = NULL,
  manual = TRUE,
  email = NULL,
  quiet = FALSE,
  webform = FALSE,
  ...
) {
  check_dots_used(action = getOption("devtools.ellipsis_action", warn))

  check_win(
    pkg = pkg,
    version = "R-release",
    args = args,
    manual = manual,
    email = email,
    quiet = quiet,
    webform = webform,
    ...
  )
}

#' @describeIn check_win Check package on the previous major release version of R.
#' @export
check_win_oldrelease <- function(
  pkg = ".",
  args = NULL,
  manual = TRUE,
  email = NULL,
  quiet = FALSE,
  webform = FALSE,
  ...
) {
  check_dots_used(action = getOption("devtools.ellipsis_action", warn))

  check_win(
    pkg = pkg,
    version = "R-oldrelease",
    args = args,
    manual = manual,
    email = email,
    quiet = quiet,
    webform = webform,
    ...
  )
}

check_win <- function(
  pkg = ".",
  version = c("R-devel", "R-release", "R-oldrelease"),
  args = NULL,
  manual = TRUE,
  email = NULL,
  quiet = FALSE,
  webform = FALSE,
  ...
) {
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
    confirm_maintainer_email(email)
  }

  built_path <- pkgbuild::build(
    pkg$path,
    tempdir(),
    args = args,
    manual = manual,
    quiet = quiet,
    ...
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
  url <- paste0(
    "ftp://win-builder.r-project.org/",
    version,
    "/",
    path_file(path)
  )
  walk(url, upload_ftp, file = path)
}

submit_winbuilder_webform <- function(path, version) {
  walk(version, upload_webform, file = path)
}

confirm_maintainer_email <- function(email, call = parent.frame()) {
  if (!rlang::is_interactive()) {
    return(FALSE)
  }

  if (!yesno("Email results to {.strong {email}}?")) {
    return()
  }

  cli::cli_abort(
    c(
      "User declined upload.",
      i = "Use `email = {.str your email}` to override."
    ),
    call = call
  )
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
  is_maintainer <- map_lgl(roles, function(r) all("cre" %in% r))
  aut[is_maintainer]$email <- email
  desc$set_authors(aut)

  desc$write()
}

upload_ftp <- function(file, url, verbose = FALSE) {
  check_installed("curl")

  stopifnot(file_exists(file))
  stopifnot(is.character(url))
  con <- file(file, open = "rb")
  on.exit(close(con), add = TRUE)
  h <- curl::new_handle(upload = TRUE, filetime = FALSE)
  curl::handle_setopt(
    h,
    readfunction = function(n) {
      readBin(con, raw(), n = n)
    },
    verbose = verbose
  )
  curl::curl_fetch_memory(url, handle = h)
}

parse_winbuilder_form <- function(url, version) {
  req <- httr2::request(url)
  resp <- httr2::req_perform(req)
  html <- xml2::read_html(httr2::resp_body_string(resp))

  # Extract hidden fields shared by the whole form
  hidden_nodes <- xml2::xml_find_all(html, ".//input[@type='hidden']")
  hidden <- as.list(xml2::xml_attr(hidden_nodes, "value"))
  names(hidden) <- xml2::xml_attr(hidden_nodes, "name")

  # Find the <h2> heading for the requested version, then grab the file
  # input and submit button from the <div> that follows it
  headings <- xml2::xml_find_all(html, ".//h2")
  heading_texts <- xml2::xml_text(headings)
  idx <- match(version, heading_texts)
  if (is.na(idx)) {
    cli::cli_abort(
      "Could not find {.val {version}} section in the WinBuilder form."
    )
  }

  section <- xml2::xml_find_first(headings[[idx]], "following-sibling::div")
  file_field <- xml2::xml_attr(
    xml2::xml_find_first(section, ".//input[@type='file']"),
    "name"
  )
  button_field <- xml2::xml_attr(
    xml2::xml_find_first(section, ".//input[@type='submit']"),
    "name"
  )

  list(hidden = hidden, file_field = file_field, button_field = button_field)
}

upload_webform <- function(file, version) {
  check_installed(c("httr2", "xml2"))

  upload_url <- "https://win-builder.r-project.org/upload.aspx"
  form <- parse_winbuilder_form(upload_url, version)

  body <- form$hidden
  body[[form$file_field]] <- curl::form_file(file)
  body[[form$button_field]] <- "Upload File"

  req <- httr2::request(upload_url)
  req <- httr2::req_body_multipart(req, !!!body)
  httr2::req_perform(req)
}
