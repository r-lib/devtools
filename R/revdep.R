#' Reverse dependency tools.
#'
#' Tools to check and notify maintainers of all CRAN and Bioconductor
#' packages that depend on the specified package.
#'
#' The first run in a session will be time-consuming because it must download
#' all package metadata from CRAN and Bioconductor. Subsequent runs will
#' be faster.
#'
#' @param pkg Package name. This is unlike most devtools packages which
#'   take a path because you might want to determine dependencies for a package
#'   that you don't have installed. If omitted, defaults to the name of the
#'   current package.
#' @param ignore A character vector of package names to ignore. These packages
#'   will not appear in returned vector.
#' @param dependencies A character vector listing the types of dependencies
#'   to follow.
#' @param bioconductor If `TRUE` also look for dependencies amongst
#'   Bioconductor packages.
#' @param recursive If `TRUE` look for full set of recursive dependencies.
#' @seealso The [revdepcheck](https://github.com/r-lib/revdepcheck) package can
#'  be used to run R CMD check on all reverse dependencies.
#' @export
#' @keywords internal
#' @examples
#' \dontrun{
#' revdep("ggplot2")
#'
#' revdep("ggplot2", ignore = c("xkcd", "zoo"))
#' }
revdep <- function(
  pkg,
  dependencies = c("Depends", "Imports", "Suggests", "LinkingTo"),
  recursive = FALSE,
  ignore = NULL,
  bioconductor = FALSE
) {
  if (missing(pkg)) {
    pkg <- as.package(".")$package
  }

  all <- if (bioconductor) packages() else cran_packages()

  deps <- tools::dependsOnPkgs(pkg, dependencies, recursive, installed = all)
  deps <- setdiff(deps, ignore)
  sort_ci(deps)
}

#' @rdname revdep
#' @export
revdep_maintainers <- function(pkg = ".") {
  if (missing(pkg)) {
    pkg <- as.package(".")$package
  }

  maintainers <- unique(packages()[revdep(pkg), "Maintainer"])
  class(maintainers) <- "maintainers"

  maintainers
}

#' @export
print.maintainers <- function(x, ...) {
  x <- gsub("\n", " ", x)
  cat(x, sep = ",\n")
  cat("\n")
}

# Package caches ----------------------------------------------------------

cran_packages <- memoise::memoise(
  function() {
    local <- path_temp("packages.rds")
    utils::download.file(
      "https://cran.R-project.org/web/packages/packages.rds",
      local,
      mode = "wb",
      quiet = TRUE
    )
    on.exit(file_delete(local))
    cp <- readRDS(local)
    rownames(cp) <- unname(cp[, 1])
    cp
  },
  ~ memoise::timeout(30 * 60)
)

bioc_packages <- memoise::memoise(
  function(
    views = paste(BiocManager::repositories()[["BioCsoft"]], "VIEWS", sep = "/")
  ) {
    con <- url(views)
    on.exit(close(con))
    bioc <- read.dcf(con)
    rownames(bioc) <- bioc[, 1]
    bioc
  },
  ~ memoise::timeout(30 * 60)
)

packages <- function() {
  bioc <- bioc_packages()
  cran <- cran_packages()
  cols <- intersect(colnames(cran), colnames(bioc))
  rbind(cran[, cols], bioc[, cols])
}
