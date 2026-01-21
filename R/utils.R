compact <- function(x) {
  x[lengths(x) > 0]
}

"%||%" <- function(a, b) if (!is.null(a)) a else b

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

vcapply <- function(x, FUN, ...) {
  vapply(x, FUN, FUN.VALUE = character(1), ...)
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

# Suppress cli wrapping
no_wrap <- function(x) {
  x <- gsub(" ", "\u00a0", x, fixed = TRUE)
  x <- gsub("\n", "\f", x, fixed = TRUE)
  x
}
