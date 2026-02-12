#' Release package to CRAN
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `release()` is deprecated in favour of [usethis::use_release_issue()].
#' We no longer feel confident recommending `release()` because we don't use it
#' ourselves, so there's no guarantee that it will track best practices as
#' they evolve over time.
#'
#' If you want to programmatical submit to CRAN, you can continue to use
#' [submit_cran()].
#'
#' @template devtools
#' @param check if `TRUE`, run checking, otherwise omit it.  This
#'   is useful if you've just checked your package and you're ready to
#'   release it.
#' @param args An optional character vector of additional command
#'   line arguments to be passed to `R CMD build`.
#' @seealso [usethis::use_release_issue()] to create a checklist of release
#'   tasks that you can use in addition to or in place of `release`.
#' @export
release <- function(pkg = ".", check = FALSE, args = NULL) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "release()",
    "usethis::use_release_issue()"
  )
  if (!is_interactive()) {
    cli::cli_abort("Interactive session required.")
  }

  pkg <- as.package(pkg)
  # Figure out if this is a new package
  cran_version <- cran_pkg_version(pkg$package)
  new_pkg <- is.null(cran_version)

  if (yesno("Have you checked for spelling errors (with `spell_check()`)?")) {
    return(invisible())
  }

  if (check) {
    cli::cat_rule(
      left = "Building and checking",
      right = pkg$package,
      line = 2
    )
    check(
      pkg,
      cran = TRUE,
      remote = TRUE,
      manual = TRUE,
      build_args = args,
      run_dont_test = TRUE
    )
  }
  if (yesno("Have you run `R CMD check` locally?")) {
    return(invisible())
  }

  release_checks(pkg)
  if (yesno("Were devtool's checks successful?")) {
    return(invisible())
  }

  if (!new_pkg) {
    show_cran_check <- TRUE
    cran_details <- NULL
    end_sentence <- " ?"
    if (requireNamespace("foghorn", quietly = TRUE)) {
      show_cran_check <- has_cran_results(pkg$package)
      cran_details <- foghorn::cran_details(pkg = pkg$package)
    }
    if (show_cran_check) {
      if (!is.null(cran_details)) {
        end_sentence <- "\n shown above?"
        cli::cat_rule(paste0(
          "Details of the CRAN check results for ",
          pkg$package
        ))
        summary(cran_details)
        cli::cat_rule()
      }
      cran_url <- paste0(
        cran_mirror(),
        "/web/checks/check_results_",
        pkg$package,
        ".html"
      )
      if (
        yesno(
          "Have you fixed all existing problems at \n{cran_url}{end_sentence}"
        )
      ) {
        return(invisible())
      }
    }
  }

  if (yesno("Have you checked on R-hub (see `?rhub::rhubv2`)?")) {
    return(invisible())
  }

  if (yesno("Have you checked on win-builder (with `check_win_devel()`)?")) {
    return(invisible())
  }

  deps <- if (new_pkg) 0 else length(revdep(pkg$package))
  if (deps > 0) {
    msg <- paste0(
      "Have you checked the ",
      deps,
      " reverse dependencies ",
      "(with the revdepcheck package)?"
    )
    if (yesno(msg)) {
      return(invisible())
    }
  }

  questions <- c(
    "Have you updated `NEWS.md` file?",
    "Have you updated `DESCRIPTION`?",
    "Have you updated `cran-comments.md?`",
    if (file_exists("codemeta.json")) {
      "Have you updated codemeta.json with codemetar::write_codemeta()?"
    },
    find_release_questions(pkg)
  )
  for (question in questions) {
    if (yesno(question)) return(invisible())
  }

  if (uses_git(pkg$path)) {
    git_checks(pkg)
    if (yesno("Were Git checks successful?")) {
      return(invisible())
    }
  }

  submit_cran(pkg, args = args)

  invisible(TRUE)
}

has_cran_results <- function(pkg) {
  cran_res <- foghorn::cran_results(
    pkg = pkg,
    show = c("error", "fail", "warn", "note")
  )
  sum(cran_res[, -1]) > 0
}

find_release_questions <- function(pkg = ".") {
  pkg <- as.package(pkg)

  q_fun <- pkgload::ns_env(pkg$package)$release_questions
  if (is.null(q_fun)) {
    character()
  } else {
    q_fun()
  }
}

yesno <- function(msg, .envir = parent.frame()) {
  if (!is_interactive()) {
    cli::cli_abort("Called from non-interactive context.")
  }

  yeses <- c(
    "Yes",
    "Definitely",
    "For sure",
    "Yup",
    "Yeah",
    "Of course",
    "Absolutely"
  )
  nos <- c("No way", "Not yet", "I forget", "No", "Nope", "Uhhhh... Maybe?")

  cli::cli_inform(msg, .envir = .envir)
  qs <- c(sample(yeses, 1), sample(nos, 2))
  rand <- sample(length(qs))

  utils::menu(qs[rand]) != which(rand == 1)
}

maintainer <- function(pkg = ".") {
  pkg <- as.package(pkg)

  authors <- pkg$`authors@r`
  if (!is.null(authors)) {
    people <- eval(parse(text = authors))
    if (is.character(people)) {
      maintainer <- utils::as.person(people)
    } else {
      maintainer <- Find(function(x) "cre" %in% x$role, people)
    }
  } else {
    maintainer <- pkg$maintainer
    if (is.null(maintainer)) {
      cli::cli_abort("No maintainer defined in package.")
    }
    maintainer <- utils::as.person(maintainer)
  }

  list(
    name = paste(maintainer$given, maintainer$family),
    email = maintainer$email
  )
}

cran_comments <- function(pkg = ".", call = parent.frame()) {
  pkg <- as.package(pkg)

  path <- path(pkg$path, "cran-comments.md")
  if (!file_exists(path)) {
    cli::cli_warn(
      c(
        x = "Can't find {.file cran-comments.md}.",
        i = "This file is used to communicate your release process to the CRAN team.",
        i = "Create it with {.code use_cran_comments()}."
      ),
      call = call
    )
    return(character())
  }

  paste0(readLines(path, warn = FALSE), collapse = "\n")
}

cran_submission_url <- "https://xmpalantir.wu.ac.at/cransubmit/index2.php"

#' Submit a package to CRAN
#'
#' @description
#' This submits your package to CRAN using the web-form submission process.
#' To complete the submission you will need respond to the email sent to the
#' maintainer email address.
#'
#' We generally recommend using this part of the process defined by
#' [use_release_issue()]; this process maximizes the chances of a successful
#' submission.
#'
#' @template devtools
#' @inheritParams release
#' @export
#' @keywords internal
submit_cran <- function(pkg = ".", args = NULL) {
  if (yesno("Is your email address {maintainer(pkg)$email}?")) {
    return(invisible())
  }

  pkg <- as.package(pkg)

  built_path <- pkgbuild::build(pkg$path, tempdir(), manual = TRUE, args = args)

  size <- format(as.object_size(file_info(built_path)$size), units = "auto")
  cli::cat_rule("Submitting", col = "cyan")
  cli::cli_inform(c(
    "i" = "Path {.file {built_path}}",
    "i" = "File size: {size}"
  ))
  cli::cat_line()

  if (yesno("Ready to submit {pkg$package} ({pkg$version}) to CRAN?")) {
    return(invisible())
  }

  upload_cran(pkg, built_path)

  usethis::with_project(pkg$path, flag_release(pkg))
}

extract_cran_msg <- function(msg) {
  # Remove "CRAN package Submission" and "Submit package to CRAN"
  msg <- gsub("CRAN package Submission|Submit package to CRAN", "", msg)

  # remove all html tags
  msg <- gsub("<[^>]+>", "", msg)

  # remove tabs
  msg <- gsub("\t+", "", msg)

  # Remove extra newlines
  msg <- gsub("\n+", "\n", msg)

  msg
}

upload_cran <- function(pkg, built_path, call = parent.frame()) {
  pkg <- as.package(pkg)
  maint <- maintainer(pkg)
  comments <- cran_comments(pkg, call = call)

  # Initial upload ---------
  cli::cli_inform(c(i = "Uploading package & comments"))
  check_installed("httr2")
  body <- list(
    pkg_id = "",
    name = maint$name,
    email = maint$email,
    uploaded_file = curl::form_file(built_path, "application/x-gzip"),
    comment = comments,
    upload = "Upload package"
  )
  req <- httr2::request(cran_submission_url) |>
    httr2::req_body_multipart(!!!body)

  httr2::resp_check_status(resp)
  new_url <- httr2::url_parse(httr2::resp_url(resp))

  # Confirmation -----------
  cli::cli_inform(c(i = "Confirming submission"))
  body <- list(
    pkg_id = new_url$query$pkg_id,
    name = maint$name,
    email = maint$email,
    policy_check = "1/",
    submit = "Submit package"
  )
  req <- do.call(
    httr2::req_body_multipart,
    c(list(httr2::request(cran_submission_url)), body)
  )
  resp <- httr2::req_perform(req)
  new_url <- httr2::url_parse(httr2::resp_url(resp))
  if (new_url$query$submit == "1") {
    cli::cli_inform(c(
      "v" = "Package submission successful",
      "i" = "Check your email for confirmation link."
    ))
  } else {
    cli::cli_abort("Package failed to upload.", call = call)
  }

  invisible(TRUE)
}

as.object_size <- function(x) structure(x, class = "object_size")

flag_release <- function(pkg = ".") {
  pkg <- as.package(pkg)
  if (!uses_git(pkg$path)) {
    return(invisible())
  }

  cli::cli_inform(c(
    "!" = "Don't forget to tag this release once accepted by CRAN"
  ))

  withr::with_dir(pkg$path, {
    sha <- system2("git", c("rev-parse", "HEAD"), stdout = TRUE)
  })

  dat <- list(
    Version = pkg$version,
    Date = format(Sys.time(), tz = "UTC", usetz = TRUE),
    SHA = sha
  )

  write.dcf(dat, file = path(pkg$path, "CRAN-SUBMISSION"))
  usethis::use_build_ignore("CRAN-SUBMISSION")
}

cran_mirror <- function(repos = getOption("repos")) {
  repos[repos == "@CRAN@"] <- "https://cloud.r-project.org"

  if (is.null(names(repos))) {
    names(repos) <- "CRAN"
  }

  repos[["CRAN"]]
}

# Return the version of a package on CRAN (or other repository)
# @param package The name of the package.
# @param available A matrix of information about packages.
cran_pkg_version <- function(package, available = utils::available.packages()) {
  idx <- available[, "Package"] == package
  if (any(idx)) {
    as.package_version(available[package, "Version"])
  } else {
    NULL
  }
}
