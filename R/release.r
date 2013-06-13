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
#'   \item Upload the package to CRAN
#'   \item Draft an email to the CRAN maintainer.
#' }
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
#' @importFrom RCurl ftpUpload
release <- function(pkg = ".", check = TRUE) {
  pkg <- as.package(pkg)

  if (check) {
    check(pkg, cran = TRUE, check_version = TRUE)
    if (yesno("Was package check successful?"))
      return(invisible())

  } else {
    # If we don't run the full checks, then check that the package version is
    # sufficient for submission to CRAN.
    cran_version <- cran_pkg_version(pkg$package)

    if (is.null(cran_version)) {
      message("Package ", pkg$package, " not found on CRAN. This is a new package.")

    } else if (as.package_version(pkg$version) > cran_version) {
      message("Local package ", pkg$package, " ", pkg$version,
        " is greater than CRAN version ", cran_version, ".")

    } else {
      stop("Local package ", pkg$package, " ", pkg$version,
        " must be greater than CRAN version ", cran_version, ".")
    }
  }

  if (yesno("Have you checked on win-builder (with build_win)?"))
    return(invisible())

  try(print(show_news(pkg)))
  if (yesno("Is package news up-to-date?"))
    return(invisible())

  cat(readLines(file.path(pkg$path, "DESCRIPTION")), sep = "\n")
  if (yesno("Is DESCRIPTION up-to-date?"))
    return(invisible())

  if (yesno("Have you checked packages that depend on this package?"))
    return(invisible())

  if (yesno("Ready to upload?"))
    return(invisible())

  message("Building")
  built_path <- build(pkg, tempdir())
  message("File size: ", file.info(built_path)$size, " bytes")

  message("Uploading")
  ftpUpload(built_path, paste("ftp://cran.R-project.org/incoming/",
    basename(built_path), sep = ""))

  message("Preparing email")
  body <- paste(
    "Dear CRAN maintainers,\n",
    "\n",
    "I have just uploaded a new version of ", pkg$package, " to CRAN.\n",
    "\n",
    "Thanks!\n",
    "\n",
    getOption("devtools.name"), "\n",
    sep = "")
  subject <- paste("CRAN submission ", pkg$package, " ", pkg$version, sep = "")
  email("cran@r-project.org", subject, body)
}

yesno <- function(question) {
  yeses <- c("Yes", "Definitely", "For sure", "Yup", "Yeah")
  nos <- c("No way", "Not yet", "I forgot", "No", "Nope")

  cat(question)
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
  browseURL(url)

  invisible(TRUE)
}
