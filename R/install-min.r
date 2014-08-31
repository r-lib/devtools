install_min <- function(pkg = ".", dest, components = NULL, args = NULL, quiet = FALSE) {
  pkg <- as.package(pkg)
  stopifnot(is.character(dest), length(dest) == 1, file.exists(dest))

  poss <- c("R", "data", "help", "demo", "inst", "docs", "exec", "libs")
  if (!is.null(components)) {
    components <- match.arg(components, poss, several.ok = TRUE)
  }
  no <- setdiff(poss, components)
  no_args <- paste0("--no-", no)

  RCMD("INSTALL", c(
    shQuote(pkg$path),
    paste("--library=", shQuote(dest), sep = ""),
    no_args,
    "--no-multiarch",
    "--no-test-load",
    args
  ), quiet = quiet)

  invisible(file.path(dest, pkg$package))
}
