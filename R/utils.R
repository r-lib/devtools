compact <- function(x) {
  is_empty <- vapply(x, function(x) length(x) == 0, logical(1))
  x[!is_empty]
}

"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

is_windows <- isTRUE(.Platform$OS.type == "windows")

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

is_testing <- function() {
  identical(Sys.getenv("TESTTHAT"), "true")
}

release_bullets <- function() {
  c(
    '`usethis::use_latest_dependencies(TRUE, "CRAN")`',
    NULL
  )
}

is_rstudio_running <- function() {
  !is_testing() && rstudioapi::isAvailable()
}
