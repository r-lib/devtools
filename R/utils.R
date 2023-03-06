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

release_bullets <- function() {
  c(
    '`usethis::use_latest_dependencies(TRUE, "CRAN")`',
    NULL
  )
}

is_testing <- function() {
  identical(Sys.getenv("TESTTHAT"), "true")
}

is_rstudio_running <- function() {
  !is_testing() && rstudioapi::isAvailable()
}
