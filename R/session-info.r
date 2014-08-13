#' Return a vector of names of attached packages
#' @export
#' @keywords internal
#' @return A data frame with columns package and path, giving the name of
#'   each package and the path it was loaded from.
loaded_packages <- function() {

  attached <- data.frame(
    package = search(),
    path = searchpaths(),
    stringsAsFactors = FALSE
  )
  packages <- attached[grepl("^package:", attached$package), , drop = FALSE]
  rownames(packages) <- NULL

  packages$package <- sub("^package:", "", packages$package)
  packages
}

#' Return a vector of names of packages loaded by devtools
#' @export
#' @keywords internal
dev_packages <- function() {
  packages <- vapply(loadedNamespaces(),
    function(x) !is.null(dev_meta(x)), logical(1))

  names(packages)[packages]
}

#' Print session information
#'
#' This function prints out the same information as
#' \code{\link[utils]{sessionInfo}()}, with one difference: it also prints out
#' the GithubSHA1 value of loaded packages, if present.
#'
#' @export
session_info <- function() {

  # This is a modified version of utils:::print.sessionInfo from R 3.1.1. It's
  # exactly the same except that it also prints out a package's GithubSHA1
  # value, if present.
  print_session_info <- function (x, locale = TRUE, ...) {
      mkLabel <- function(L, n) {
          vers <- sapply(L[[n]], function(x) {
              str <- x[["Version"]]
              if (!is.null(x$GithubSHA1)) {
                str <- paste0(str, "(", substr(x$GithubSHA1, 1, 7), ")")
              }
              str
          })
          pkg <- sapply(L[[n]], function(x) x[["Package"]])
          paste(pkg, vers, sep = "_")
      }
      cat(x$R.version$version.string, "\n", sep = "")
      cat("Platform: ", x$platform, "\n\n", sep = "")
      if (locale) {
          cat("locale:\n")
          print(strsplit(x$locale, ";", fixed = TRUE)[[1]], quote = FALSE,
              ...)
          cat("\n")
      }
      cat("attached base packages:\n")
      print(x$basePkgs, quote = FALSE, ...)
      if (!is.null(x$otherPkgs)) {
          cat("\nother attached packages:\n")
          print(mkLabel(x, "otherPkgs"), quote = FALSE, ...)
      }
      if (!is.null(x$loadedOnly)) {
          cat("\nloaded via a namespace (and not attached):\n")
          print(mkLabel(x, "loadedOnly"), quote = FALSE, ...)
      }
      invisible(x)
  }

  print_session_info(sessionInfo())
}
