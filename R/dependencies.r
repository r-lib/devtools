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
#' revdep("ggplot2")
revdep <- function(pkg, dependencies = c("Depends", "Imports")) {
  sort(dependsOnPkgs(pkg, installed = packages()))
}

#' @rdname revdep
revdep_maintainers <- function(pkg) {
  as.person(unique(packages()[revdep(pkg), "Maintainer"]))
}

#' @rdname revdep
revdep_check <- function(pkg) {
  pkgs <- revdep(pkg)
  check_cran(pkgs)
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
  on.exit(closeAllConnections())
  
  bioc <- read.dcf(url("http://bioconductor.org/packages/2.10/bioc/VIEWS"))
  rownames(bioc) <- bioc[, 1]
  bioc
})

packages <- function() {
  cran <- cran_packages()
  bioc <- bioc_packages()
  cols <- intersect(colnames(cran), colnames(bioc))
  rbind(cran[, cols], bioc[, cols])
}

