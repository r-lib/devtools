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
  packages <- vapply(
    loadedNamespaces(),
    function(x) !is.null(pkgload::dev_meta(x)), logical(1)
  )

  names(packages)[packages]
}

#' Print session information
#'
#' This is \code{\link{sessionInfo}()} re-written from scratch to both exclude
#' data that's rarely useful (e.g., the full collate string or base packages
#' loaded) and include stuff you'd like to know (e.g., where a package was
#' installed from).
#'
#' @param pkgs Either a vector of package names or NULL. If \code{NULL},
#'   displays all loaded packages. If a character vector, also, includes
#'   all dependencies of the package.
#' @param include_base Include base packages in summary? By default this is
#'   false since base packages should always match the R version.
#' @export
#' @examples
#' session_info()
#' session_info("devtools")
session_info <- function(pkgs = NULL, include_base = FALSE) {
  check_suggested("sessioninfo")
  sessioninfo::session_info(pkgs = pkgs, include_base = include_base)
}
