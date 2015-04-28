rstudio_release <- memoise::memoise(function() {
  url <- "http://s3.amazonaws.com/rstudio-server/current.ver"
  numeric_version(readLines(url, warn = FALSE))
})

r_release <- memoise::memoise(function() {
  R_system_version(rversions::r_release()$version)
})

#' Diagnose potential devtools issues
#'
#' This checks to make sure you're using the latest release of R,
#' the released version of RStudio (if you're using it as your gui),
#' and the latest version of devtools and its dependencies.
#'
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
