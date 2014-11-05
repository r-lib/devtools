#' Reverse dependency tools.
#'
#' Tools to check and notify maintainers of all CRAN and bioconductor
#' packages that depend on the specified package.
#'
#' The first run in a session will be time-consuming because it must download
#' all package metadata from CRAN and bioconductor. Subsequent runs will
#' be faster.
#'
#' @param pkg Package name. This is unlike most devtools packages which
#'   take a path because you might want to determine dependencies for a package
#'   that you don't have installed.
#' @param ignore A character vector of package names to ignore. These packages
#'   will not appear in returned vector. This is used in
#'   \code{\link{revdep_check}} to avoid packages with installation problems
#'   or extremely long check times.
#' @inheritParams tools::dependsOnPkgs
#' @seealso \code{\link{revdep_check}()} to run R CMD check on all reverse
#'   dependencies.
#' @export
#' @examples
#' \dontrun{
#' revdep("ggplot2")
#'
#' revdep("ggplot2", ignore = c("xkcd", "zoo"))
#'}
revdep <- function(pkg, dependencies = c("Depends", "Imports",
                   "Suggests", "LinkingTo"), recursive = FALSE, ignore = NULL) {
  deps <- tools::dependsOnPkgs(pkg, dependencies, recursive, installed = packages())
  deps <- setdiff(deps, ignore)
  sort(deps)
}

#' @rdname revdep
#' @export
revdep_maintainers <- function(pkg) {
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

#' Run R CMD check on all downstream dependencies.
#'
#' This is neeeded when you submit a new version of a package to CRAN.
#'
#' By \code{revdep_check} uses temporary library to store any packages that
#' are required by the packages being tests. This ensures that they don't
#' interfere with your default library, but means that if you restart R
#' between checks, you'll need to reinstall all the packages. If you're
#' doing reverse dependency checks frequently, I recommend that you create
#' a directory for these packages and set \code{libpath}.
#'
#' @inheritParams revdep
#' @inheritParams check_cran
#' @seealso \code{\link{revdep_maintainers}()} to run R CMD check on all reverse
#'   dependencies.
#' @export
#' @return An invisible list of results. But you'll probably want to look
#'   at the check results on disk, which are saved in \code{check_dir}.
#'   Summaries of all ERRORs and WARNINGs will be stored in
#'   \code{check_dir/00check-summary.txt}.
#' @examples
#' \dontrun{
#' # Run R CMD check on all downstream dependencies of ggplot2
#' revdep_check("ggplot2")
#' }
revdep_check <- function(pkg, recursive = FALSE, ignore = NULL,
                         libpath = file.path(tempdir(), "R-lib"),
                         srcpath = libpath, bioconductor = FALSE,
                         type = getOption("pkgType"),
                         threads = getOption("Ncpus", 1),
                         check_dir = tempfile("check_cran")) {
  pkgs <- revdep(pkg, recursive = recursive, ignore = ignore)
  res <- check_cran(pkgs, revdep_pkg = pkg, libpath = libpath,
    srcpath = srcpath, bioconductor = bioconductor, type = type,
    threads = threads, check_dir = check_dir)

  res$revdep_package <- pkg
  invisible(res)
}

cran_packages <- memoise::memoise(function() {
  local <- file.path(tempdir(), "packages.rds")
  download.file("http://cran.R-project.org/web/packages/packages.rds", local,
    mode = "wb", quiet = TRUE)
  on.exit(unlink(local))
  cp <- readRDS(local)
  rownames(cp) <- unname(cp[, 1])
  cp
})

bioc_packages <- memoise::memoise(function() {
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

