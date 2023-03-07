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
#' @param ... Additional arguments passed to [pkgbuild::build()].
#' @family build functions
#' @name check_win
NULL

#' @describeIn check_win Check package on the development version of R.
#' @export
check_win_devel <- function(pkg = ".", args = NULL, manual = TRUE, email = NULL, quiet = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  check_win(
    pkg = pkg, version = "R-devel", args = args, manual = manual,
    email = email, quiet = quiet, ...
  )
}

#' @describeIn check_win Check package on the released version of R.
#' @export
check_win_release <- function(pkg = ".", args = NULL, manual = TRUE, email = NULL, quiet = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  check_win(
    pkg = pkg, version = "R-release", args = args, manual = manual,
    email = email, quiet = quiet, ...
  )
}

#' @describeIn check_win Check package on the previous major release version of R.
#' @export
check_win_oldrelease <- function(pkg = ".", args = NULL, manual = TRUE, email = NULL, quiet = FALSE, ...) {
  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  check_win(
    pkg = pkg, version = "R-oldrelease", args = args, manual = manual,
    email = email, quiet = quiet, ...
  )
}

check_win <- function(pkg = ".", version = c("R-devel", "R-release", "R-oldrelease"),
                      args = NULL, manual = TRUE, email = NULL, quiet = FALSE, ...) {
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

  url <- glue(
    "ftp://win-builder.r-project.org/{version}/{path_file(built_path)}"
  )
  map(url, upload_ftp, file = built_path)

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
  curl::handle_setopt(h, readfunction = function(n) {
    readBin(con, raw(), n = n)
  }, verbose = verbose)
  curl::curl_fetch_memory(url, handle = h)
}
