#' Release package to CRAN.
#'
#' Run automated and manual tests, then post package to CRAN.
#'
#' The package release process will:
#'
#' \itemize{
#'   \item Confirm that the package passes \code{R CMD check} on relevant platoforms
#'   \item Confirm that important files are up-to-date
#'   \item Build the package
#'   \item Submit the package to CRAN, using comments in "cran-comments.md"
#' }
#'
#' You can add arbitrary extra questions by defining an (un-exported) function
#' called \code{release_questions()} that returns a character vector
#' of additional questions to ask.
#'
#' You also need to read the CRAN repository policy at
#' \url{https://cran.r-project.org/web/packages/policies.html} and make
#' sure you're in line with the policies. \code{release} tries to automate as
#' many of polices as possible, but it's impossible to be completely
#' comprehensive, and they do change in between releases of devtools.
#'
#' @section Guarantee:
#'
#' If a devtools bug causes one of the CRAN maintainers to treat you
#' impolitely, I will personally send you a handwritten apology note.
#' Please forward me the email and your address, and I'll get a card in
#' the mail.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param check if \code{TRUE}, run checking, otherwise omit it.  This
#'   is useful if you've just checked your package and you're ready to
#'   release it.
#' @param args An optional character vector of additional command
#'   line arguments to be passed to \code{R CMD build}.
#' @export
release <- function(pkg = ".", check = FALSE, args = NULL) {
  pkg <- as.package(pkg)
  # Figure out if this is a new package
  cran_version <- cran_pkg_version(pkg$package)
  new_pkg <- is.null(cran_version)

  dr_d <- dr_devtools()
  if (!dr_d) {
    print(dr_d)

    if (yesno("Proceed anyway?")) {
      return(invisible())
    }
  }

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
    if (dir.exists("docs/")) "Have you updated website in `docs/`?",
    if (file.exists("codemeta.json")) "Have you updated codemeta.json with codemetar::write_codemeta()?",
    find_release_questions()
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

release_email <- function(name, new_pkg) {
  paste(
    "Dear CRAN maintainers,\n",
    "\n",
    if (new_pkg) {
      paste("I have uploaded a new package, ", name, ", to CRAN. ",
        "I have read and agree to the CRAN policies.\n",
        sep = ""
      )
    } else {
      paste("I have just uploaded a new version of ", name, " to CRAN.\n",
        sep = ""
      )
    },
    "\n",
    "Thanks!\n",
    "\n",
    getOption("devtools.name"), "\n",
    sep = ""
  )
}

yesno <- function(...) {
  yeses <- c("Yes", "Definitely", "For sure", "Yup", "Yeah", "I agree", "Absolutely")
  nos <- c("No way", "Not yet", "I forget", "No", "Nope", "Uhhhh... Maybe?")

  cat(paste0(..., collapse = ""))
  qs <- c(sample(yeses, 1), sample(nos, 2))
  rand <- sample(length(qs))

  menu(qs[rand]) != which(rand == 1)
}

# http://tools.ietf.org/html/rfc2368
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
    message("Sending failed with error: ", e$message)
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

  path <- file.path(pkg$path, "cran-comments.md")
  if (!file.exists(path)) {
    warning("Can't find cran-comments.md.\n",
      "This file gives CRAN volunteers comments about the submission,\n",
      "Create it with use_cran_comments().\n",
      call. = FALSE
    )
    return(character())
  }

  paste0(readLines(path, warn = FALSE), collapse = "\n")
}

cran_submission_url <- "http://xmpalantir.wu.ac.at/cransubmit/index2.php"

#' Submit a package to CRAN.
#'
#' This uses the new CRAN web-form submission process. After submission, you
#' will receive an email asking you to confirm submission - this is used
#' to check that the package is submitted by the maintainer.
#'
#' It's recommended that you use \code{\link{release}()} rather than this
#' function as it performs more checks prior to submission.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @inheritParams release
#' @export
#' @keywords internal
submit_cran <- function(pkg = ".", args = NULL) {
  if (yesno("Is your email address ", maintainer(pkg)$email, "?")) {
    return(invisible())
  }

  if (yesno("Ready to submit to CRAN?")) {
    return(invisible())
  }

  pkg <- as.package(pkg)
  built_path <- build_cran(pkg, args = args)
  upload_cran(pkg, built_path)

  flag_release(pkg)
}

build_cran <- function(pkg, args) {
  message("Building")
  built_path <- pkgbuild::build(pkg$path, tempdir(), manual = TRUE, args = args)
  message("Submitting file: ", built_path)
  message(
    "File size: ",
    format(as.object_size(file.info(built_path)$size), units = "auto")
  )
  built_path
}

upload_cran <- function(pkg, built_path) {
  pkg <- as.package(pkg)
  maint <- maintainer(pkg)
  comments <- cran_comments(pkg)

  # Initial upload ---------
  message("Uploading package & comments")
  body <- list(
    pkg_id = "",
    name = maint$name,
    email = maint$email,
    uploaded_file = httr::upload_file(built_path, "application/x-gzip"),
    comment = comments,
    upload = "Upload package"
  )
  r <- httr::POST(cran_submission_url, body = body)
  httr::stop_for_status(r)
  new_url <- httr::parse_url(r$url)

  # Confirmation -----------
  message("Confirming submission")
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
    message(
      "Package submission successful.\n",
      "Check your email for confirmation link."
    )
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

  message("Don't forget to tag this release once accepted by CRAN")

  date <- Sys.Date()
  commit <- git2r::commits(git2r::init(pkg$path), n = 1)[[1]]
  sha <- substr(as.data.frame(commit)$sha, 1, 10)

  msg <- paste0(
    "This package was submitted to CRAN on ", date, ".\n",
    "Once it is accepted, delete this file and tag the release (commit ", sha, ")."
  )
  writeLines(msg, file.path(pkg$path, "CRAN-RELEASE"))
  usethis::use_build_ignore("CRAN-RELEASE")
}
