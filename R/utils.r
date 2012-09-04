# Given the name or vector of names, returns a named vector reporting
# whether each exists and is a directory.
dir.exists <- function(x) {
  res <- file.exists(x) & file.info(x)$isdir
  setNames(res, x)
}


"%||%" <- function(a, b) if (!is.null(a)) a else b

rule <- function() {
  message(paste(rep("-", getOption("width"), collapse = "")))
}

