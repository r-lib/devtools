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
#'   that you don't have installed. If omitted, defaults to the name of the
#'   current package.
#' @param ignore A character vector of package names to ignore. These packages
#'   will not appear in returned vector. This is used in
#'   \code{\link{revdep_check}} to avoid packages with installation problems
#'   or extremely long check times.
#' @param dependencies A character vector listing the types of dependencies
#'   to follow.
#' @param bioconductor If \code{TRUE} also look for dependencies amongst
#'   bioconductor packages.
#' @param recursive If \code{TRUE} look for full set of recusive dependencies.
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
revdep <- function(pkg,
                   dependencies = c("Depends", "Imports", "Suggests", "LinkingTo"),
                   recursive = FALSE, ignore = NULL,
                   bioconductor = FALSE) {
  if (missing(pkg)) pkg <- as.package(".")$package

  all <- if (bioconductor) packages() else cran_packages()

  deps <- tools::dependsOnPkgs(pkg, dependencies, recursive, installed = all)
  deps <- setdiff(deps, ignore)
  sort(deps)
}

#' @rdname revdep
#' @export
revdep_maintainers <- function(pkg = ".") {
  if (missing(pkg)) pkg <- as.package(".")$package

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
#' Use \code{revdep_check()} to run \code{\link{check_cran}()} on all downstream
#' dependencies. Summarises the results with \code{revdep_check_summary} and
#' save logs with \code{revdep_check_save_logs}.
#'
#' @section Check process:
#' \enumerate{
#' \item Install \code{pkg} (in special library, see below).
#' \item Find all CRAN packges that dependent on \code{pkg}.
#' \item Install those packages, along with their dependencies.
#' \item Run \code{R CMD check} on each package.
#' \item Uninstall \code{pkg} (so other reverse dependency checks don't
#'   use the development version instead of the CRAN version)
#' }
#'
#' @section Package library:
#' By default \code{revdep_check} uses temporary library to store any packages
#' that are required by the packages being tested. This ensures that they don't
#' interfere with your default library, but means that if you restart R
#' between checks, you'll need to reinstall all the packages. If you're
#' doing reverse dependency checks frequently, I recommend that you create
#' a directory for these packages and set \code{option(devtools.libpath)}.
#'
#' @inheritParams revdep
#' @param pkg Path to package. Defaults to current directory.
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
#' res <- revdep_check("ggplot2")
#' revdep_check_summary(res)
#' revdep_check_save_logs(res)
#' }
revdep_check <- function(pkg = ".", recursive = FALSE, ignore = NULL,
                         dependencies = c("Depends", "Imports", "Suggests", "LinkingTo"),
                         libpath = getOption("devtools.revdep.libpath"),
                         srcpath = libpath, bioconductor = FALSE,
                         type = getOption("pkgType"),
                         threads = getOption("Ncpus", 1),
                         check_dir = tempfile("check_cran")) {
  pkg <- as.package(pkg)
  rule("Reverse dependency checks for ", pkg$package, pad = "=")

  if (!file.exists(libpath))
    dir.create(libpath)
  if (!file.exists(srcpath))
    dir.create(srcpath)

  message("Installing ", pkg$package)
  with_libpaths(libpath, install(pkg, reload = FALSE, quiet = TRUE))
  on.exit(remove.packages(pkg$package, libpath), add = TRUE)

  message("Finding reverse dependencies")
  pkgs <- revdep(pkg$package, recursive = recursive, ignore = ignore,
    bioconductor = bioconductor, dependencies = dependencies)
  check_cran(pkgs, revdep_pkg = pkg$package, libpath = libpath,
    srcpath = srcpath, bioconductor = bioconductor, type = type,
    threads = threads, check_dir = check_dir)

  list(check_dir = check_dir, libpath = libpath, pkg = pkg, deps = pkgs)
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

