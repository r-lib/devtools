#' Read the in-development help for a package loaded with devtools.
#'
#' Note that this only renders a single documentation file, so that links
#' to other files within the package won't work.
#'
#' @param topic name of help to search for.
#' @param stage at which stage ("build", "install", or "render") should
#'   \\Sexpr macros be executed? This is only important if you're using
#'   \\Sexpr macro's in your Rd files.
#' @param type of html to produce: \code{"html"} or \code{"text"}. Defaults to
#'   your default documentation type.
#' @export
#' @examples
#' \dontrun{
#' library("ggplot2")
#' help("ggplot") # loads installed documentation for ggplot
#'
#' load_all("ggplot2")
#' dev_help("ggplot") # loads development documentation for ggplot
#' }
dev_help <- function(topic, stage = "render", type = getOption("help_type")) {
  path <- find_topic(topic)
  if (is.null(path)) {
    dev <- paste(dev_packages(), collapse = ", ")
    stop("Could not find topic ", topic, " in: ", dev)
  }

  pkg <- basename(names(path)[1])
  if (rstudioapi::hasFun("previewRd")) {
    rstudioapi::callFun("previewRd", path)
  } else {
    view_rd(path, pkg, stage = stage, type = type)
  }

}


#' @importFrom tools Rd2txt Rd2HTML
view_rd <- function(path, package, stage = "render", type = getOption("help_type")) {
  if (is.null(type)) type <- "text"
  type <- match.arg(type, c("text", "html"))

  out_path <- paste(tempfile("Rtxt"), type, sep = ".")

  if (type == "text") {
    Rd2txt(path, out = out_path, package = package, stages = stage)
    file.show(out_path, title = paste(package, basename(path), sep = ":"))
  } else if (type == "html") {
    Rd2HTML(path, out = out_path, package = package, stages = stage,
      no_links = TRUE)

    css_path <- file.path(tempdir(), "R.css")
    if (!file.exists(css_path)) {
      file.copy(file.path(R.home("doc"), "html", "R.css"), css_path)
    }

    browseURL(out_path)
  }
}


#' Drop-in replacements for help and ? functions
#'
#' The \code{?} and \code{help} are drop-in replacements for functions of the
#' same name in the utils package.
#'
#' The \code{?} function is a replacement for \code{\link[utils]{?}} from the
#' utils package. It will search for help in devtools-loaded packages first,
#' then in regular packages.
#'
#' The \code{help} function is a replacement for \code{\link[utils]{help}} from
#' the utils package. If \code{package} is not specified, it will search for
#' help in devtools-loaded packages first, then in regular packages. If
#' \code{package} is specified, then it will search for help in devtools-loaded
#' packages or regular packages, as appropriate.
#'
#' @inheritParams utils::help utils::`?`
#' @param topic A name or character string specifying the help topic.
#' @param package A name or character string specifying the package in which
#'   to search for the help topic. If NULL, seach all packages.
#' @param e1 First argument to pass along to \code{utils::`?`}.
#' @param e2 Second argument to pass along to \code{utils::`?`}.
#' @param ... Additional arguments to pass to \code{\link[utils]{help}}.
#' @export
#' @examples
#' \dontrun{
#' # This would load devtools and look at the help for load_all, if currently
#' # in the devtools source directory.
#' load_all()
#' ?load_all
#' help("load_all")
#' }
#'
#' # To see the help pages for utils::help and utils::`?`:
#' help("help", "utils")
#' help("?", "utils")
help <- function(topic, package = NULL, ...) {
  # Get string versions of topic and package
  if (is.name(substitute(topic))) {
    topic_str <- deparse(substitute(topic))
  } else {
    topic_str <- topic
  }

  if (is.name(substitute(package))) {
    package_str <- deparse(substitute(package))
  } else if (is.null(substitute(package))) {
    package_str <- NULL
  } else {
    package_str <- package
  }


  # If package is NULL, search for help in devtools-loaded packages, and if that
  # fails, try utils::help.
  # If the package was specified, then use dev_help or utils::help as
  # appropriate.
  if (is.null(package_str)) {
    if (!is.null(find_topic(topic_str))) {
      dev_help(topic_str)
    } else {
      call <- as.call(list(utils::help, substitute(topic), substitute(package), ...))
      return(eval(call))
    }

  } else if (package_str %in% dev_packages()) {
    dev_help(topic_str)

  } else {
    call <- as.call(list(utils::help, substitute(topic), substitute(package), ...))
    return(eval(call))
  }
}


#' @rdname help
#' @export
`?` <- function(e1, e2) {
  # Get string versions of e1 and e2
  if (is.name(substitute(e1))) {
    e1_str <- deparse(substitute(e1))
  } else {
    e1_str <- e1
  }

  if (is.name(substitute(e2))) {
    e2_str <- deparse(substitute(e2))
  } else {
    e2_str <- e2
  }

  # Search for the topic in devtools-loaded packages.
  # If not found, call utils::`?`.
  if (!is.null(find_topic(e1_str))) {
    dev_help(e1_str)
  } else {
    eval(as.call(list(utils::`?`, substitute(e1), substitute(e2))))
  }
}
