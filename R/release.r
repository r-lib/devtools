#' Release package to CRAN.
#'
#' Run automated and manual tests, then ftp to CRAN.
#'
#' The package release process will:
#'
#' \itemize{
#'
#'   \item Confirm that the package passes \code{R CMD check}
#'   \item Ask if you've checked your code on win-builder
#'   \item Confirm that news is up-to-date
#'   \item Confirm that DESCRIPTION is ok
#'   \item Ask if you've checked packages that depend on your package
#'   \item Build the package
#'   \item Submit the package to CRAN, using comments in "cran-comments.md"
#' }
#'
#' You can also add arbitrary extra questions by defining an (un-exported)
#' function called \code{release_questions()} that returns a character vector
#' of additional questions to ask.
#'
#' You also need to read the CRAN repository policy at
#' \url{http://cran.r-project.org/web/packages/policies.html} and make
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
#' @export
release <- function(pkg = ".", check = TRUE) {
  pkg <- as.package(pkg)

  # Figure out if this is a new package
  cran_version <- cran_pkg_version(pkg$package)
  new_pkg <- is.null(cran_version)

  if (check) {
    check(pkg, cran = TRUE, check_version = TRUE)
    if (yesno("Was package check successful?"))
      return(invisible())

  } else {
    # Even if we don't run the full checks, at least check that the package
    # version is sufficient for submission to CRAN.

    if (new_pkg) {
      message("Package ", pkg$package, " not found on CRAN. This is a new package.")

    } else if (as.package_version(pkg$version) > cran_version) {
      message("Local package ", pkg$package, " ", pkg$version,
        " is greater than CRAN version ", cran_version, ".")

    } else {
      stop("Local package ", pkg$package, " ", pkg$version,
        " must be greater than CRAN version ", cran_version, ".")
    }
  }

  policies <- paste("Have you read and do you agree to the the CRAN policies?",
    "\n(http://cran.r-project.org/web/packages/policies.html)")
  if (yesno(policies))
    return(invisible())

  if (yesno("Have you checked on win-builder (with build_win())?"))
    return(invisible())

  if (file.exists("NEWS")) {
    try(print(show_news(pkg)))
    if (yesno("Is package news up-to-date?"))
      return(invisible())
  }

  rule("DESCRIPTION")
  cat(readLines(file.path(pkg$path, "DESCRIPTION")), sep = "\n")
  cat("\n")
  if (yesno("Is DESCRIPTION up-to-date?"))
    return(invisible())

  deps <- if (new_pkg) 0 else length(revdep(pkg$package))
  if (deps > 0) {
    msg <- paste0("Have you checked the ", deps ," packages that depend on ",
      "this package (with check_cran())?")

    if (yesno(msg))
      return(invisible())
  }

  release_questions <- pkg_env(pkg)$release_questions
  if (!is.null(release_questions)) {
    questions <- release_questions()
    for (question in questions) {
      if (yesno(question)) return(invisible())
    }
  }

  if (yesno("Is your email address ", maintainer(pkg)$email, "?"))
    return(invisible())

  rule("cran-comments.md ")
  cat(cran_comments(pkg), "\n\n")
  if (yesno("Are the CRAN submission comments correct?"))
    return(invisible())

  if (yesno("Ready to submit?"))
    return(invisible())

  submit_cran(pkg)

  if (file.exists(file.path(pkg$path, ".git"))) {
    message("Don't forget to tag the release when the package is accepted!")
  }
  invisible(TRUE)
}

release_email <- function(name, new_pkg) {
  paste(
    "Dear CRAN maintainers,\n",
    "\n",
    if (new_pkg) {
      paste("I have uploaded a new package, ", name, ", to CRAN. ",
        "I have read and agree to the CRAN policies.\n", sep = "")
    } else {
      paste("I have just uploaded a new version of ", name, " to CRAN.\n",
        sep = "")
    },
    "\n",
    "Thanks!\n",
    "\n",
    getOption("devtools.name"), "\n",
    sep = "")
}

yesno <- function(...) {
  yeses <- c("Yes", "Definitely", "For sure", "Yup", "Yeah")
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
    URLencode(address),
    "?subject=", URLencode(subject),
    "&body=", URLencode(body),
    sep = ""
  )

  tryCatch({
    browseURL(url, browser = email_browser())},
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
  if (!identical(.Platform$GUI, "RStudio"))
    return (getOption("browser"))

  # Use default browser, even if RStudio running
  if (.Platform$OS.type == "windows")
    return (NULL)

  browser <- Sys.which(c("xdg-open", "open"))
  browser[nchar(browser) > 0][[1]]
}


maintainer <- function(pkg = ".") {
  pkg <- as.package(pkg)

  authors <- pkg$`authors@r`
  if (!is.null(authors)) {
    people <- eval(parse(text = authors))
    if (is.character(people)) {
      maintainer <- as.person(people)
    } else {
      maintainer <- Find(function(x) "cre" %in% x$role, people)
    }
  } else {
    maintainer <- pkg$maintainer
    if (is.null(maintainer)) {
      stop("No maintainer defined in package.", call. = FALSE)
    }
    maintainer <- as.person(maintainer)
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
    stop("Can't find cran-comments.md in ", pkg$package, ".\n",
      "This file for comments for package submission and must exist.\n",
      "Please create and add to .Rbuildignore (with add_build_ignore())",
      call. = FALSE)
  }

  paste0(readLines(path, warn = FALSE), collapse = "\n")
}

cran_submission_url <- "http://xmpalantir.wu.ac.at/cransubmit/index2.php"

#' Submit a package to CRAN.
#'
#' This uses the new CRAN web-form submission process. After submission, you
#' will recieve an email asking you to confirm submission - this is used
#' to check that the package is submitted by the maintainer.
#'
#' It's recommend that you use \code{\link{release}()} rather than this
#' function as it performs more checks prior to submission.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
#' @keywords internal
submit_cran <- function(pkg = ".") {
  pkg <- as.package(pkg)
  maint <- maintainer(pkg)
  comments <- cran_comments(pkg)

  message("Building")
  built_path <- build(pkg, tempdir())
  message("File size: ", file.info(built_path)$size, " bytes")

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
  new_url$query$strErr

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
    message("Package submission successful.\n",
      "Check your email for confirmation link.")
  } else {
    stop("Package failed to upload.", call. = FALSE)
  }

  invisible(TRUE)
}
