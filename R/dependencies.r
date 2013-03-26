#' Reverese dependency tools.
#'
#' Tools to check and notify maintainers of all all CRAN and bioconductor
#' packages that depend on the specified package.
#'
#' @param pkg package name
#' @inheritParams tools::dependsOnPkgs
#' @importFrom tools dependsOnPkgs
#' @export
#' @examples
#' \dontrun{revdep("ggplot2")}
revdep <- function(pkg = NULL, dependencies = c("Depends", "Imports",
                    "Suggests", "LinkingTo"), recursive = FALSE) {
  sort(dependsOnPkgs(pkg, dependencies, recursive, installed = packages()))
}

#' @rdname revdep
#' @export
revdep_maintainers <- function(pkg = ".") {
  as.person(unique(packages()[revdep(pkg), "Maintainer"]))
}

#' @rdname revdep
#' @param ... Other parameters passed on to \code{\link{check_cran}}
#' @export
revdep_check <- function(pkg = NULL, recursive = FALSE, ...) {
  pkgs <- revdep(pkg, recursive = recursive)
  check_cran(pkgs, ...)
}


#' @importFrom memoise memoise
cran_packages <- memoise(function() {
  local <- file.path(tempdir(), "packages.rds")
  download.file("http://cran.R-project.org/web/packages/packages.rds", local,
    mode = "wb", quiet = TRUE)
  on.exit(unlink(local))
  cp <- readRDS(local)
  rownames(cp) <- unname(cp[, 1])
  cp
})

#' @importFrom memoise memoise
bioc_packages <- memoise(function() {
  con <- url("http://bioconductor.org/packages/release/bioc/VIEWS")
  on.exit(close(con))
  bioc <- read.dcf(con)
  rownames(bioc) <- bioc[, 1]
  bioc
})

packages <- function() {
  cran <- cran_packages()
  bioc <- bioc_packages()
  cols <- intersect(colnames(cran), colnames(bioc))
  rbind(cran[, cols], bioc[, cols])
}

