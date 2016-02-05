# Supress R CMD check note
#' @importFrom memoise memoise
NULL

.rstudio_release <- function() {
  url <- "http://s3.amazonaws.com/rstudio-server/current.ver"
  numeric_version(readLines(url, warn = FALSE))
}

rstudio_release <- memoise::memoise(.rstudio_release)

.r_release <- function() {
  check_suggested("rversions")
  R_system_version(rversions::r_release()$version)
}

r_release <- memoise::memoise(.r_release)


#' Diagnose potential devtools issues
#'
#' This checks to make sure you're using the latest release of R,
#' the released version of RStudio (if you're using it as your gui),
#' and the latest version of devtools and its dependencies.
#'
#' @family doctors
#' @export
#' @examples
#' \donttest{
#' dr_devtools()
#' }
dr_devtools <- function() {
  msg <- character()

  if (getRversion() < r_release()) {
    msg[["R"]] <- paste0(
      "* R is out of date (", getRversion(), " vs ", r_release(), ")"
    )
  }

  deps <- package_deps("devtools", dependencies = NA)
  old <- deps$diff < 0
  if (any(old)) {
    msg[["devtools"]] <- paste0(
      "* Devtools or dependencies out of date: \n",
      paste(deps$package[old], collapse = ", ")
    )
  }

  if (rstudioapi::isAvailable()) {
    rel <- rstudio_release()
    cur <- rstudioapi::getVersion()

    if (cur < rel) {
      msg[["rstudio"]] <- paste0(
        "* RStudio is out of date (", cur, " vs ", rel, ")"
      )
    }
  }

  doctor("devtools", msg)
}

#' Diagnose potential GitHub issues
#'
#' @param path Path to repository to check. Defaults to current working
#'   directory
#' @family doctors
#' @export
#' @examples
#' \donttest{
#' dr_github()
#' }
dr_github <- function(path = ".") {
  if (!uses_git(path)) {
    return(doctor("github", "Path is not a git repository"))
  }
  if (!uses_github(path)) {
    return(doctor("github", "Path is not a GitHub repository"))
  }

  msg <- character()
  r <- git2r::repository(path, discover = TRUE)

  config <- git2r::config(r)
  config_names <- names(modifyList(config$global, config$local))

  if (!uses_github(path))
    msg[["github"]] <- " * cannot detect that this repo is connected to GitHub"
  if (!("user.name" %in% config_names))
    msg[["name"]] <- "* user.name config option not set"
  if (!("user.email" %in% config_names))
    msg[["user"]] <- "* user.email config option not set"

  if (!file.exists("~/.ssh/id_rsa"))
    msg[["ssh"]] <- "* SSH private key not found"

  if (identical(Sys.getenv("GITHUB_PAT"), ""))
    msg[["PAT"]] <- paste("* GITHUB_PAT environment variable not set",
      "(this is not necessary unless you want to install private repos",
      "or connect local repos to GitHub)")

  desc_path <- file.path(path, "DESCRIPTION")
  desc <- read_dcf(desc_path)
  field_empty <- function(d, f) is.null(d[[f]]) || identical(d[[f]], "")
  field_no_re <- function(d, f, re) !grepl(re, d[[f]])

  re <- "https://github.com/(.*?)/(.*)"
  if (field_empty(desc, "URL")) {
    msg[["URL_empty"]] <-"* empty URL field in DESCRIPTION"
  } else if (field_no_re(desc, "URL", re)) {
    msg[["URL"]] <-"* no GitHub repo link in URL field in DESCRIPTION"
  }

  re <- paste0(re, "/issues")
  if (field_empty(desc, "BugReports")) {
    msg[["BugReports_empty"]] <-"* empty BugReports field in DESCRIPTION"
  } else if (field_no_re(desc, "BugReports", re)) {
    msg[["BugReports"]] <-"* no GitHub Issues link in URL field in DESCRIPTION"
  }

  doctor("github", msg)
}

# Doctor class ------------------------------------------------------------

doctor <- function(name, messages) {
  structure(
    length(messages) == 0,
    doctor = paste0("DR_", toupper(name)),
    messages = messages,
    class = "doctor"
  )
}

#' @export
print.doctor <- function(x, ...) {
  if (x) {
    message(attr(x, "doctor"), " SAYS YOU LOOK HEALTHY")
    return()
  }

  warning(attr(x, "doctor"), " FOUND PROBLEMS", call. = FALSE, immediate. = TRUE)
  messages <- strwrap(attr(x, "messages"), exdent = 2)
  message(paste(messages, collapse = "\n"))
}
