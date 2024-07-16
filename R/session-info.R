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
  packages <- map_lgl(
    loadedNamespaces(), function(x) !is.null(pkgload::dev_meta(x))
  )

  names(packages)[packages]
}

#' @export
#' @importFrom sessioninfo session_info
sessioninfo::session_info

#' @export
#' @importFrom sessioninfo package_info
sessioninfo::package_info
