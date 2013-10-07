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
  if (rstudio_has("previewRd")) {
    rstudio::previewRd(path)
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
