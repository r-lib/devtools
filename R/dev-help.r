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


view_rd <- function(path, package, stage = "render", type = getOption("help_type")) {
  if (is.null(type)) type <- "text"
  type <- match.arg(type, c("text", "html"))

  out_path <- paste(tempfile("Rtxt"), type, sep = ".")

  if (type == "text") {
    tools::Rd2txt(path, out = out_path, package = package, stages = stage)
    file.show(out_path, title = paste(package, basename(path), sep = ":"))
  } else if (type == "html") {
    tools::Rd2HTML(path, out = out_path, package = package, stages = stage,
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
#' The \code{?} and \code{help} functions are replacements for functions of the
#' same name in the utils package. They are made available when a package is
#' loaded with \code{\link{load_all}}.
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
#'
#' @rdname help
#' @name help
#' @usage # help(topic, package = NULL, ...)
#'
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
#'
#' \dontrun{
#' # Examples demonstrating the multiple ways of supplying arguments
#' # NB: you can't do pkg <- "ggplot2"; help("ggplot2", pkg)
#' shim_help(lm)
#' shim_help(lm, stats)
#' shim_help(lm, 'stats')
#' shim_help('lm')
#' shim_help('lm', stats)
#' shim_help('lm', 'stats')
#' shim_help(package = stats)
#' shim_help(package = 'stats')
#' topic <- "lm"
#' shim_help(topic)
#' shim_help(topic, stats)
#' shim_help(topic, 'stats')
#' }
shim_help <- function(topic, package = NULL, ...) {
  # Reproduce help's NSE for topic - try to eval it and see if it's a string
  topic_name <- substitute(topic)
  is_char <- FALSE
  try(is_char <- is.character(topic) && length(topic) == 1L, silent = TRUE)
  if (is_char) {
    topic_str <- topic
    topic_name <- as.name(topic)
  } else if (missing(topic_name)) {
    # Leave the vars missing
  } else if (is.null(topic_name)) {
    topic_str <- NULL
    topic_name <- NULL
  } else {
    topic_str <- deparse(substitute(topic))
  }

  # help's NSE for package is slightly simpler
  package_name <- substitute(package)
  if (is.name(package_name)) {
    package_str <- as.character(package_name)
  } else if (is.null(package_name)) {
    package_str <- NULL
  } else {
    package_str <- package
    package_name <- as.name(package)
  }

  use_dev <- (!is.null(package_str) && package_str %in% dev_packages()) ||
    (is.null(package_str) && !is.null(find_topic(topic_str)))
  if (use_dev) {
    dev_help(topic_str)
  } else {
    # This is similar to list(), except that one of the args is a missing var,
    # it will replace it with an empty symbol instead of trying to evaluate it.
    as_list <- function(..., .env = parent.frame()) {
      dots <- match.call(expand.dots = FALSE)$`...`

      lapply(dots, function(var) {
        is_missing <- eval(substitute(missing(x), list(x = var)), .env)
        if (is_missing) {
          quote(expr=)
        } else {
          eval(var, .env)
        }
      })
    }

    call <- substitute(
      utils::help(topic, package, ...),
      as_list(topic = topic_name, package = package_name)
    )
    eval(call)
  }
}


#' @usage
#' # ?e2
#' # e1?e2
#'
#' @rdname help
#' @name ?
shim_question <- function(e1, e2) {
  # Get string version of e1, for find_topic
  e1_expr <- substitute(e1)
  if (is.name(e1_expr)) {
    # Called with a bare symbol, like ?foo
    e1_str <- deparse(e1_expr)

  } else if (is.call(e1_expr)) {
    if (e1_expr[[1]] == "?") {
      # Double question mark, like ??foo
      e1_str <- NULL
    } else {
      # Called with function arguments, like ?foo(12)
      e1_str <- deparse(e1_expr[[1]])
    }

  } else {
    # If we got here, it's probably a string
    e1_str <- e1
  }

  # Search for the topic in devtools-loaded packages.
  # If not found, call utils::`?`.
  if (!is.null(find_topic(e1_str))) {
    dev_help(e1_str)
  } else {
    eval(as.call(list(utils::`?`, substitute(e1), substitute(e2))))
  }
}
