#' Evaluate code in specified locale.
#' @keywords internal
with_locale <- function(locale, code) {
  cur <- Sys.getlocale(category = "LC_COLLATE")
  Sys.setlocale(category = "LC_COLLATE", locale = locale)
  res <- force(code)
  Sys.setlocale(category = "LC_COLLATE", locale = cur)
  res
}