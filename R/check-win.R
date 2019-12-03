#' Build windows binary package.
#'
#' This function works by bundling source package, and then uploading to
#' <https://win-builder.r-project.org/>.  Once building is complete you'll
#' receive a link to the built package in the email address listed in the
#' maintainer field.  It usually takes around 30 minutes. As a side effect,
#' win-build also runs `R CMD check` on the package, so `check_win`
#' is also useful to check that your package is ok on windows.
#'
#' @template devtools
#' @inheritParams pkgbuild::build
#' @param email An alternative email to use, default `NULL` uses the package
#'   Maintainer's email.
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

#' @describeIn check_win Check package on the release version of R.
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
    desc_file <- file.path(pkg$path, "DESCRIPTION")
    backup <- tempfile()
    file.copy(desc_file, backup)
    on.exit(file.rename(backup, desc_file), add = TRUE)

    change_maintainer_email(desc_file, email)

    pkg <- as.package(pkg$path)
  }

  version <- match.arg(version, several.ok = TRUE)

  if (!quiet) {
    message(
      "Building windows version of ", pkg$package, " (", pkg$version, ")",
      " for ", paste(version, collapse = ", "),
      " with win-builder.r-project.org.\n"
    )
    if (interactive() && yesno("Email results to ", maintainer(pkg)$email, "?")) {
      return(invisible())
    }
  }

  built_path <- pkgbuild::build(pkg$path, tempdir(),
    args = args,
    manual = manual, quiet = quiet, ...
  )
  on.exit(unlink(built_path), add = TRUE)

  url <- paste0(
    "ftp://win-builder.r-project.org/", version, "/",
    basename(built_path)
  )
  lapply(url, upload_ftp, file = built_path)

  if (!quiet) {
    message(
      "[", strftime(Sys.time(), "%I:%M %p (%Y-%m-%d)"), "] ",
      "Check ", maintainer(pkg)$email, " for a link to the built package",
      if (length(version) > 1) "s" else "",
      " in 15-30 mins."
    )
  }

  invisible()
}

change_maintainer_email <- function(desc, email) {
  desc <- desc::desc(file = desc)

  if (!desc$has_fields("Authors@R")) {
    stop("DESCRIPTION must use `Authors@R` field to change the maintainer email", call. = FALSE)
  }
  aut <- desc$get_authors()
  roles <- aut$role
  ## Broken person() API, vector for 1 author, list otherwise...
  if (!is.list(roles)) roles <- list(roles)
  is_maintainer <- vapply(roles, function(r) all("cre" %in% r), logical(1))
  aut[is_maintainer]$email <- email

  desc$set_authors(aut)

  desc$write()
}
