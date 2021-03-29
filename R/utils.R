compact <- function(x) {
  is_empty <- vapply(x, function(x) length(x) == 0, logical(1))
  x[!is_empty]
}

"%||%" <- function(a, b) if (!is.null(a)) a else b

"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

# Modified version of utils::file_ext. Instead of always returning the text
# after the last '.', as in "foo.tar.gz" => ".gz", if the text that directly
# precedes the last '.' is ".tar", it will include also, so
# "foo.tar.gz" => ".tar.gz"
file_ext <- function(x) {
  pos <- regexpr("\\.((tar\\.)?[[:alnum:]]+)$", x)
  ifelse(pos > -1L, substring(x, pos + 1L), "")
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

# This is base::trimws from 3.2 on
trim_ws <- function(x, which = c("both", "left", "right")) {
  which <- match.arg(which)
  mysub <- function(re, x) sub(re, "", x, perl = TRUE)
  if (which == "left") {
    return(mysub("^[ \t\r\n]+", x))
  }
  if (which == "right") {
    return(mysub("[ \t\r\n]+$", x))
  }
  mysub("[ \t\r\n]+$", mysub("^[ \t\r\n]+", x))
}

# throws a warning if the argument is not the current directory.
warn_unless_current_dir <- function(pkg, envir = parent.frame()) {
  if (pkg != ".") {
    warning("`pkg` is not `.`, which is now unsupported.\n  Please use `usethis::proj_set()` to set the project directory.", immediate. = TRUE)
    usethis::local_project(pkg, quiet = TRUE, .local_envir = envir)
  }
}

menu <- function(...) {
  utils::menu(...)
}

escape_special_regex <- function(x) {
  chars <- c("*", ".", "?", "^", "+", "$", "|", "(", ")", "[", "]", "{", "}", "\\")
  gsub(paste0("([\\", paste0(collapse = "\\", chars), "])"), "\\\\\\1", x, perl = TRUE)
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
