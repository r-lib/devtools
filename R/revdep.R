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
#' @param recursive If \code{TRUE} look for full set of recursive dependencies.
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
#' dependencies. Summarises the results with \code{revdep_check_summary()} and
#' see problems with \code{revdep_check_print_problems()}.
#'
#' Revdep checks are resumably - this is very helpful if somethings goes
#' wrong (like you run out of power or you lose your internet connection) in
#' the middle of a check. You can resume a partially completed check with
#' \code{revdep_check_resume()}, or blow away the cached result so you can
#' start afresh with \code{revdep_check_reset()}.
#'
#' @section Check process:
#' \enumerate{
#' \item Install \code{pkg} (in special library, see below).
#' \item Find all CRAN packages that depend on \code{pkg}.
#' \item Install those packages, along with their dependencies.
#' \item Run \code{R CMD check} on each package.
#' \item Uninstall \code{pkg} (so other reverse dependency checks don't
#'   use the development version instead of the CRAN version)
#' }
#'
#' @section Package library:
#' By default \code{revdep_check} uses a temporary library to store any packages
#' that are required by the packages being tested. This ensures that they don't
#' interfere with your default library, but means that if you restart R
#' between checks, you'll need to reinstall all the packages. If you're
#' doing reverse dependency checks frequently, I recommend that you create
#' a directory for these packages and set \code{options(devtools.revdep.libpath)}.
#'
#' @inheritParams revdep
#' @param pkg Path to package. Defaults to current directory.
#' @inheritParams check_cran
#' @param check_dir A temporary directory to hold the results of the package
#'   checks. This should not exist as after the revdep checks complete
#'   successfully this directory is blown away.
#' @seealso \code{\link{revdep_maintainers}()} to get a list of all revdep
#'   maintainers.
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
                         env_vars = NULL,
                         check_dir = NULL) {

  pkg <- as.package(pkg)
  if (file.exists(revdep_cache_path(pkg))) {
    stop("Cache file `revdep/.cache.rds` exists.\n",
      "Use `revdep_check_resume()` to resume\n",
      "Use `revdep_check_reset()` to start afresh.",
      call. = FALSE)
  }

  rule("Reverse dependency checks for ", pkg$package, pad = "=")

  if (is.null(check_dir)) {
    check_dir <- file.path(pkg$path, "revdep", "checks")
    message("Saving check results in `revdep/checks/`")
  }
  if (file.exists(check_dir)) {
    stop("`check_dir()` must not already exist: it is deleted after a successful run",
      call. = FALSE)
  }

  message("Computing reverse dependencies")
  revdeps <- revdep(pkg$package, recursive = recursive, ignore = ignore,
    bioconductor = bioconductor, dependencies = dependencies)

  # Save arguments and revdeps to a cache
  cache <- list(
    pkgs = revdeps,
    libpath = libpath,
    srcpath = srcpath,
    bioconductor = bioconductor,
    type = type,
    threads = threads,
    check_dir = check_dir,
    env_vars = env_vars
  )
  saveRDS(cache, revdep_cache_path(pkg))

  revdep_check_from_cache(pkg, cache)
}

#' @export
#' @rdname revdep_check
revdep_check_resume <- function(pkg = ".") {
  pkg <- as.package(pkg)

  cache_path <- revdep_cache_path(pkg)
  if (!file.exists(cache_path)) {
    message("Previous run completed successfully")
    return(invisible())
  }

  cache <- readRDS(cache_path)

  # Don't need to check packages that we've already checked.
  check_dirs <- dir(cache$check_dir, full.names = TRUE)
  completed <- file.exists(file.path(check_dirs, "COMPLETE"))

  completed_pkgs <- gsub("\\.Rcheck$", "", basename(check_dirs)[completed])
  cache$pkgs <- setdiff(cache$pkgs, completed_pkgs)

  revdep_check_from_cache(pkg, cache)
}

#' @rdname revdep_check
#' @export
revdep_check_reset <- function(pkg = ".") {
  pkg <- as.package(pkg)

  cache_path <- revdep_cache_path(pkg)
  if (!file.exists(cache_path)) {
    return(invisible(FALSE))
  }

  cache <- readRDS(cache_path)

  unlink(cache_path)
  unlink(cache$check_dir, recursive = TRUE)
  invisible(TRUE)
}

revdep_check_from_cache <- function(pkg, cache) {
  # Install this package into revdep library -----------------------------------
  if (!file.exists(cache$libpath)) {
    dir.create(cache$libpath, recursive = TRUE, showWarnings = FALSE)
  }
  message(
    "Installing ", pkg$package, " ", pkg$version,
    " and dependencies to ", cache$libpath
  )
  withr::with_libpaths(cache$libpath, action = "prefix", {
    install(pkg, reload = FALSE, quiet = TRUE, dependencies = TRUE)
  })
  on.exit(remove.packages(pkg$package, cache$libpath), add = TRUE)

  cache$env_vars <- c(
    NOT_CRAN = "false",
    RGL_USE_NULL = "true",
    DISPLAY = "",
    cache$env_vars
  )
  show_env_vars(cache$env_vars)

  do.call(check_cran, cache)

  rule("Saving check results to `revdep/check.rds`")
  revdep_check_save(pkg, cache$revdeps, cache$check_dir, cache$libpath)

  # Delete cache and check_dir on successful run
  rule("Cleaning up")
  revdep_check_reset(pkg)
  unlink(revdep_cache_path(pkg))
  unlink(cache$check_dir, recursive = TRUE)

  invisible()
}


revdep_check_save <- function(pkg, revdeps, check_path, lib_path) {
  platform <- platform_info()

  # Revdep results
  results <- lapply(check_dirs(check_path), parse_package_check)

  # Find all dependencies
  deps <- pkg[c("imports", "depends", "linkingto", "suggests")]
  pkgs <- unlist(lapply(deps, function(x) parse_deps(x)$name), use.names = FALSE)
  pkgs <- c(pkg$package, unique(pkgs))
  pkgs <- intersect(pkgs, dir(lib_path))
  dependencies <- package_info(pkgs, libpath = lib_path)

  out <- list(
    revdeps = revdeps,
    platform = platform,
    dependencies = dependencies,
    results = results
  )
  saveRDS(out, revdep_check_path(pkg))
}

parse_package_check <- function(path) {
  pkgname <- gsub("\\.Rcheck$", "", basename(path))
  desc <- read_dcf(file.path(path, "00_pkg_src", pkgname, "DESCRIPTION"))

  structure(
    list(
      maintainer = desc$Maintainer,
      bug_reports = desc$BugReports,
      package = desc$Package,
      version = desc$Version,
      results = parse_check_results(file.path(path, "00check.log"))
    ),
    class = "revdep_check_result"
  )
}

revdep_check_path <- function(pkg) {
  file.path(pkg$path, "revdep", "checks.rds")
}

revdep_cache_path <- function(pkg) {
  file.path(pkg$path, "revdep", ".cache.rds")
}

check_dirs <- function(path) {
  checkdirs <- list.dirs(path, recursive = FALSE, full.names = TRUE)
  checkdirs <- checkdirs[grepl("\\.Rcheck$", checkdirs)]
  names(checkdirs) <- sub("\\.Rcheck$", "", basename(checkdirs))

  has_src <- file.exists(file.path(checkdirs, "00_pkg_src", names(checkdirs)))
  checkdirs[has_src]
}


# Package caches ----------------------------------------------------------

cran_packages <- memoise::memoise(
  function() {
    local <- file.path(tempdir(), "packages.rds")
    utils::download.file("http://cran.R-project.org/web/packages/packages.rds", local,
      mode = "wb", quiet = TRUE)
    on.exit(unlink(local))
    cp <- readRDS(local)
    rownames(cp) <- unname(cp[, 1])
    cp
  },
  ~memoise::timeout(30 * 60)
)

bioc_packages <- memoise::memoise(
  function(views = paste(BiocInstaller::biocinstallRepos()[["BioCsoft"]], "VIEWS", sep = "/")) {
    con <- url(views)
    on.exit(close(con))
    bioc <- read.dcf(con)
    rownames(bioc) <- bioc[, 1]
    bioc
  },
  ~memoise::timeout(30 * 60)
)

packages <- function() {
  cran <- cran_packages()
  bioc <- bioc_packages()
  cols <- intersect(colnames(cran), colnames(bioc))
  rbind(cran[, cols], bioc[, cols])
}
