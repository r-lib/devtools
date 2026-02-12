"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

is_windows <- isTRUE(.Platform$OS.type == "windows")
is_macos <- isTRUE(tolower(Sys.info()[["sysname"]]) == "darwin")

sort_ci <- function(x) {
  withr::with_collate("C", x[order(tolower(x), x)])
}

is_loaded <- function(pkg = ".") {
  pkg <- as.package(pkg)
  pkg$package %in% loadedNamespaces()
}

is_attached <- function(pkg = ".") {
  pkg <- as.package(pkg)

  !is.null(pkgload::pkg_env(pkg$package))
}

release_bullets <- function() {
  c(
    '`usethis::use_latest_dependencies(TRUE, "CRAN")`',
    NULL
  )
}

is_testing <- function() {
  identical(Sys.getenv("TESTTHAT"), "true")
}

is_positron <- function() {
  Sys.getenv("POSITRON") == "1"
}

is_rstudio_running <- function() {
  !is_testing() && rstudioapi::isAvailable()
}

# Copied from testthat:::is_llm()
is_llm <- function() {
  nzchar(Sys.getenv("AGENT")) ||
    nzchar(Sys.getenv("CLAUDECODE")) ||
    nzchar(Sys.getenv("GEMINI_CLI")) ||
    nzchar(Sys.getenv("CURSOR_AGENT"))
}

# Suppress cli wrapping
no_wrap <- function(x) {
  x <- gsub("{", "{{", x, fixed = TRUE)
  x <- gsub("}", "}}", x, fixed = TRUE)
  x <- gsub(" ", "\u00a0", x, fixed = TRUE)
  x <- gsub("\n", "\f", x, fixed = TRUE)
  x
}
