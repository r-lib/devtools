#' Add a file to \code{.Rbuildignore}
#'
#' \code{.Rbuildignore} has a regular expression on each line, but it's
#' usually easier to work with specific file names. By default, will (crudely)
#' turn a filename into a regular expression that will only match that
#' path. Repeated entries will be silently removed.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param file Name of file.
#' @param escape If \code{TRUE}, the default, will escape \code{.} to
#'   \code{\\.} and surround with \code{^} and \code{$}.
#' @return Nothing, called for its side effect.
#' @export
#' @keywords internal
add_build_ignore <- function(pkg = ".", file, escape = TRUE) {
  pkg <- as.package(pkg)

  if (escape) {
    file <- paste0("^", gsub("\\.", "\\\\.", file), "$")
  }

  path <- file.path(pkg$path, ".Rbuildignore")
  if (file.exists(path)) {
    ignore <- readLines(path, warn = FALSE)
  } else {
    ignore <- character()
  }

  ignore <- union(ignore, file)

  writeLines(ignore, path)
  invisible(TRUE)
}
