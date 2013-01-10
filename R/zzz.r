.onAttach <- function(...) {
  find_rtools()
  invisible()
}

.onLoad <- function(libname, pkgname) {
  op <- options()
  op.devtools <- list(
    devtools.path="~/R-dev",
    github.user="hadley"
  )
  toset <- !(names(op.devtools) %in% names(op))
  if(any(toset)) options(op.devtools[toset])

  invisible()
}
