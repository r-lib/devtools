rtools_paths <- NULL
.onAttach <- function(...) {
  # Assume that non-windows users have paths set correctly
  if (.Platform$OS.type != "windows") return()

  rtools_paths <<- scan_path_for_rtools()
  if (!is.null(rtools_paths)) return()

  rtools_paths <<- scan_registry_for_rtools()
  if (!is.null(rtools_paths)) return()

  packageStartupMessage("Rtools not installed :(. Please install from ",
      rtools_url, " then restart R.")


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
