#' Show package news
#'
#' @template devtools
#' @param latest if `TRUE`, only show the news for the most recent
#'   version.
#' @param ... other arguments passed on to `news`
#' @export
show_news <- function(pkg = ".", latest = TRUE, ...) {
  pkg <- as.package(pkg)

  news_path <- path_abs(c(
    file.path(pkg$path, "inst", "NEWS.Rd"),
    file.path(pkg$path, "NEWS.md"),
    file.path(pkg$path, "NEWS"),
    file.path(pkg$path, "inst", "NEWS")
  ))
  news_path <- news_path[file_exists(news_path)]

  if (length(news_path) == 0) {
    cli::cli_abort("No NEWS found")
  }

  news_db <- switch(
    path_ext(news_path),
    Rd = ("tools" %:::% ".build_news_db_from_package_NEWS_Rd")(news_path),
    md = ("tools" %:::% ".build_news_db_from_package_NEWS_md")(news_path),
    ("tools" %:::% ".news_reader_default")(news_path)
  )

  if (is.null(news_db)) {
    cli::cli_abort("Unable to parse NEWS")
  }

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  out <- utils::news(..., db = news_db)
  if (latest) {
    ver <- numeric_version(out$Version)
    recent <- ver == max(ver)
    structure(out[recent, ], class = class(out), bad = attr(out, "bad")[recent])
  } else {
    out
  }
}
