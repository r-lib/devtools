#' Release package to CRAN.
#'
#' Run automated and manual tests, then post package to CRAN.
#'
#' The package release process will:
#'
#' \itemize{
#'   \item Confirm that the package passes `R CMD check` on relevant platforms
#'   \item Confirm that important files are up-to-date
#'   \item Build the package
#'   \item Submit the package to CRAN, using comments in "cran-comments.md"
#' }
#'
#' You can add arbitrary extra questions by defining an (un-exported) function
#' called `release_questions()` that returns a character vector
#' of additional questions to ask.
#'
#' You also need to read the CRAN repository policy at
#' 'https://cran.r-project.org/web/packages/policies.html' and make
#' sure you're in line with the policies. `release` tries to automate as
#' many of polices as possible, but it's impossible to be completely
#' comprehensive, and they do change in between releases of devtools.
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
  pkg <- as.package(pkg)
  # Figure out if this is a new package
  cran_version <- cran_pkg_version(pkg$package)
  new_pkg <- is.null(cran_version)

  if (yesno("Have you checked for spelling errors (with `spell_check()`)?")) {
    return(invisible())
  }

  if (check) {
    cat_rule(
      left = "Building and checking",
      right = pkg$package,
      line = 2
    )
    check(pkg,
      cran = TRUE, remote = TRUE, manual = TRUE,
      build_args = args, run_dont_test = TRUE
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
        cat_rule(paste0("Details of the CRAN check results for ", pkg$package))
        summary(cran_details)
        cat_rule()
      }
      cran_url <- paste0(
        cran_mirror(), "/web/checks/check_results_",
        pkg$package, ".html"
      )
      if (yesno(
        "Have you fixed all existing problems at \n", cran_url,
        end_sentence
      )) {
        return(invisible())
      }
    }
  }

  if (yesno("Have you checked on R-hub (with `check_rhub()`)?")) {
    return(invisible())
  }

  if (yesno("Have you checked on win-builder (with `check_win_devel()`)?")) {
    return(invisible())
  }

  deps <- if (new_pkg) 0 else length(revdep(pkg$package))
  if (deps > 0) {
    msg <- paste0(
      "Have you checked the ", deps, " reverse dependencies ",
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
    if (dir_exists("docs/")) "Have you updated website in `docs/`?",
    if (file_exists("codemeta.json")) "Have you updated codemeta.json with codemetar::write_codemeta()?",
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

yesno <- function(...) {
  yeses <- c("Yes", "Definitely", "For sure", "Yup", "Yeah", "Of course", "Absolutely")
  nos <- c("No way", "Not yet", "I forget", "No", "Nope", "Uhhhh... Maybe?")

  cat(paste0(..., collapse = ""))
  qs <- c(sample(yeses, 1), sample(nos, 2))
  rand <- sample(length(qs))

  utils::menu(qs[rand]) != which(rand == 1)
}

# https://tools.ietf.org/html/rfc2368
email <- function(address, subject, body) {
  url <- paste(
    "mailto:",
    utils::URLencode(address),
    "?subject=", utils::URLencode(subject),
    "&body=", utils::URLencode(body),
    sep = ""
  )

  tryCatch({
    utils::browseURL(url, browser = email_browser())
  },
  error = function(e) {
    cli::cli_alert_danger("Sending failed with error: {e$message}")
    cat("To: ", address, "\n", sep = "")
    cat("Subject: ", subject, "\n", sep = "")
    cat("\n")
    cat(body, "\n", sep = "")
  }
  )

  invisible(TRUE)
}

email_browser <- function() {
  if (!identical(.Platform$GUI, "RStudio")) {
    return(getOption("browser"))
  }

  # Use default browser, even if RStudio running
  if (.Platform$OS.type == "windows") {
    return(NULL)
  }

  browser <- Sys.which(c("xdg-open", "open"))
  browser[nchar(browser) > 0][[1]]
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
      stop("No maintainer defined in package.", call. = FALSE)
    }
    maintainer <- utils::as.person(maintainer)
  }

  list(
    name = paste(maintainer$given, maintainer$family),
    email = maintainer$email
  )
}

cran_comments <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- path(pkg$path, "cran-comments.md")
  if (!file_exists(path)) {
    warning("Can't find cran-comments.md.\n",
      "This file gives CRAN volunteers comments about the submission,\n",
      "Create it with use_cran_comments().\n",
      call. = FALSE
    )
    return(character())
  }

  paste0(readLines(path, warn = FALSE), collapse = "\n")
}

cran_submission_url <- "https://xmpalantir.wu.ac.at/cransubmit/index2.php"

#' Submit a package to CRAN.
#'
#' This uses the new CRAN web-form submission process. After submission, you
#' will receive an email asking you to confirm submission - this is used
#' to check that the package is submitted by the maintainer.
#'
#' It's recommended that you use [release()] rather than this
#' function as it performs more checks prior to submission.
#'
#' @template devtools
#' @inheritParams release
#' @export
#' @keywords internal
submit_cran <- function(pkg = ".", args = NULL) {
  if (yesno("Is your email address ", maintainer(pkg)$email, "?")) {
    return(invisible())
  }

  pkg <- as.package(pkg)
  built_path <- build_cran(pkg, args = args)

  if (yesno("Ready to submit ", pkg$package, " (", pkg$version, ") to CRAN?")) {
    return(invisible())
  }

  upload_cran(pkg, built_path)

  usethis::with_project(pkg$path,
    flag_release(pkg)
  )
}

build_cran <- function(pkg, args) {
  cli::cli_alert_info("Building")
  built_path <- pkgbuild::build(pkg$path, tempdir(), manual = TRUE, args = args)
  cli::cli_alert_info("Submitting file: {built_path}")
  size <- format(as.object_size(file_info(built_path)$size), units = "auto")
  cli::cli_alert_info("File size: {size}")
  built_path
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

upload_cran <- function(pkg, built_path) {
  pkg <- as.package(pkg)
  maint <- maintainer(pkg)
  comments <- cran_comments(pkg)

  # Initial upload ---------
  cli::cli_alert_info("Uploading package & comments")
  body <- list(
    pkg_id = "",
    name = maint$name,
    email = maint$email,
    uploaded_file = httr::upload_file(built_path, "application/x-gzip"),
    comment = comments,
    upload = "Upload package"
  )
  r <- httr::POST(cran_submission_url, body = body)

  # If a 404 likely CRAN is closed for maintenance, try to get the message
  if (httr::status_code(r) == 404) {
    msg <- ""
    try({
      r2 <- httr::GET(sub("index2", "index", cran_submission_url))
      msg <- extract_cran_msg(httr::content(r2, "text"))
    })
    stop("Submission failed:", msg, call. = FALSE)
  }

  httr::stop_for_status(r)
  new_url <- httr::parse_url(r$url)

  # Confirmation -----------
  cli::cli_alert_info("Confirming submission")
  body <- list(
    pkg_id = new_url$query$pkg_id,
    name = maint$name,
    email = maint$email,
    policy_check = "1/",
    submit = "Submit package"
  )
  r <- httr::POST(cran_submission_url, body = body)
  httr::stop_for_status(r)
  new_url <- httr::parse_url(r$url)
  if (new_url$query$submit == "1") {
    cli::cli_alert_success("Package submission successful")
    cli::cli_alert_info("Check your email for confirmation link.")
  } else {
    stop("Package failed to upload.", call. = FALSE)
  }

  invisible(TRUE)
}

as.object_size <- function(x) structure(x, class = "object_size")

flag_release <- function(pkg = ".") {
  pkg <- as.package(pkg)
  if (!uses_git(pkg$path)) {
    return(invisible())
  }

  cli::cli_alert_warning("Don't forget to tag this release once accepted by CRAN")

  withr::with_dir(pkg$path, {
    sha <- system2("git", c("rev-parse", "HEAD"), stdout = TRUE)
  })

  dat <- list(
    Version = pkg$version,
    Date = format(Sys.time(), tz = "UTC", usetz = TRUE),
    SHA = sha
  )

  write.dcf(dat, file = path(pkg$path, "CRAN-RELEASE"))
  usethis::use_build_ignore("CRAN-RELEASE")
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
cran_pkg_version <- function(package, available = available.packages()) {
  idx <- available[, "Package"] == package
  if (any(idx)) {
    as.package_version(available[package, "Version"])
  } else {
    NULL
  }
}
