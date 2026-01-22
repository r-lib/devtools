#' Show package news
#'
#' @template devtools
#' @param latest if `TRUE`, only show the news for the most recent
#'   version.
#' @param ... other arguments passed on to `news`
#' @export
show_news <- function(pkg = ".", latest = TRUE, ...) {
  pkg <- as.package(pkg)
  news_path <- find_news(pkg$path)

  withCallingHandlers(
    {
      news_db <- switch(
        path_ext(news_path),
        Rd = ("tools" %:::% ".build_news_db_from_package_NEWS_Rd")(news_path),
        md = ("tools" %:::% ".build_news_db_from_package_NEWS_md")(news_path),
        ("tools" %:::% ".news_reader_default")(news_path)
      )
    },
    error = function(e) {
      cli::cli_abort("Failed to parse NEWS file.", parent = e)
    }
  )

  check_dots_used(action = getOption("devtools.ellipsis_action", warn))

  out <- utils::news(..., db = news_db)
  if (latest) {
    ver <- numeric_version(out$Version)
    recent <- ver == max(ver)
    structure(out[recent, ], class = class(out), bad = attr(out, "bad")[recent])
  } else {
    out
  }
}

find_news <- function(path) {
  news_paths <- c(
    file.path(path, "inst", "NEWS.Rd"),
    file.path(path, "NEWS.md"),
    file.path(path, "NEWS"),
    file.path(path, "inst", "NEWS")
  )
  news_path <- news_paths[file_exists(news_paths)]

  if (length(news_path) == 0) {
    cli::cli_abort("Failed to find NEWS file.")
  }

  path_abs(news_path[[1]])
}
