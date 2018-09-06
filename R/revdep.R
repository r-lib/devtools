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
#' }
revdep <- function(pkg,
                   dependencies = c("Depends", "Imports", "Suggests", "LinkingTo"),
                   recursive = FALSE, ignore = NULL,
                   bioconductor = FALSE) {
  if (missing(pkg)) pkg <- as.package(".")$package

  all <- if (bioconductor) packages() else cran_packages()

  deps <- tools::dependsOnPkgs(pkg, dependencies, recursive, installed = all)
  deps <- setdiff(deps, ignore)
  sort_ci(deps)
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

#' @details
#' Instead of the revdep functions in devtools a better alternative is
#' \sQuote{revdepcheck::revdep_check()}.
#' @rdname devtools-deprecated
#' @export
revdep_check <- function(pkg = ".", recursive = FALSE, ignore = NULL,
                         dependencies = c("Depends", "Imports", "Suggests", "LinkingTo"),
                         skip = character(),
                         libpath = getOption("devtools.revdep.libpath"),
                         srcpath = libpath, bioconductor = FALSE,
                         type = getOption("pkgType"),
                         threads = getOption("Ncpus", 1),
                         env_vars = NULL,
                         check_dir = NULL,
                         install_dir = NULL,
                         quiet_check = TRUE) {
  .Deprecated("revdepcheck::revdep_check()", package = "devtools")

  pkg <- as.package(pkg)

  revdep_path <- file.path(pkg$path, "revdep")
  if (!file.exists(revdep_path)) {
    dir.create(revdep_path)
  }

  if (file.exists(revdep_cache_path(pkg))) {
    stop("Cache file `revdep/.cache.rds` exists.\n",
      "Use `revdep_check_resume()` to resume\n",
      "Use `revdep_check_reset()` to start afresh.",
      call. = FALSE
    )
  }

  cat_rule(
    left = "Reverse dependency checks",
    right = pkg$package,
    line = 2
  )

  if (is.null(check_dir)) {
    check_dir <- file.path(pkg$path, "revdep", "checks")
    message("Saving check results in `revdep/checks/`")
  }
  if (dir.exists(check_dir) && length(dir(check_dir, all.files = TRUE, no.. = TRUE)) > 0) {
    stop("`check_dir()` must not already exist: it is deleted after a successful run",
      call. = FALSE
    )
  }

  if (is.null(install_dir)) {
    install_dir <- file.path(pkg$path, "revdep", "install")
    message("Saving install results in `revdep/install/`")
  }

  message("Computing reverse dependencies... ")
  revdeps <- revdep(pkg$package,
    recursive = recursive, ignore = ignore,
    bioconductor = bioconductor, dependencies = dependencies
  )

  # Save arguments and revdeps to a cache
  cache <- list(
    pkgs = revdeps,
    skip = skip,
    libpath = libpath,
    srcpath = srcpath,
    bioconductor = bioconductor,
    type = type,
    threads = threads,
    check_dir = check_dir,
    install_dir = install_dir,
    env_vars = env_vars,
    quiet_check = quiet_check
  )
  saveRDS(cache, revdep_cache_path(pkg))

  revdep_check_from_cache(pkg, cache)
}

#' @rdname devtools-deprecated
#' @export
revdep_check_resume <- function(pkg = ".", ...) {
  .Deprecated("revdepcheck::revdep_check()", package = "devtools")
  pkg <- as.package(pkg)

  cache_path <- revdep_cache_path(pkg)
  if (!file.exists(cache_path)) {
    message("Previous run completed successfully")
    return(invisible())
  }

  cache <- readRDS(cache_path)
  cache <- utils::modifyList(cache, list(...))

  # Don't need to check packages that we've already checked.
  check_dirs <- dir(cache$check_dir, full.names = TRUE)
  completed <- file.exists(file.path(check_dirs, "COMPLETE"))

  completed_pkgs <- gsub("\\.Rcheck$", "", basename(check_dirs)[completed])
  cache$pkgs <- setdiff(cache$pkgs, completed_pkgs)

  revdep_check_from_cache(pkg, cache)
}

#' @rdname devtools-deprecated
#' @export
revdep_check_reset <- function(pkg = ".") {
  .Deprecated("revdepcheck::revdep_reset()", package = "devtools")
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
  # Install all dependencies for this package into revdep library --------------
  if (!file.exists(cache$libpath)) {
    dir.create(cache$libpath, recursive = TRUE, showWarnings = FALSE)
  }
  message(
    "Installing dependencies for ", pkg$package, " to ", cache$libpath
  )

  # For installing from GitHub, if git2r is not installed in the cache$libpath
  requireNamespace("git2r", quietly = TRUE)

  withr::with_libpaths(cache$libpath, {
    install_deps(pkg, reload = FALSE, quiet = TRUE, dependencies = TRUE)
  })

  # Always install this package into temporary library, to allow parallel ------
  # revdep checks --------------------------------------------------------------
  temp_libpath <- tempfile("revdep")
  dir.create(temp_libpath)
  on.exit(unlink(temp_libpath, recursive = TRUE), add = TRUE)

  message(
    "Installing ", pkg$package, " ", pkg$version, " to ", temp_libpath
  )
  withr::with_libpaths(c(temp_libpath, cache$libpath), {
    install(pkg, reload = FALSE, quiet = TRUE, dependencies = FALSE)
  })

  cache$env_vars <- c(
    NOT_CRAN = "false",
    RGL_USE_NULL = "true",
    DISPLAY = "",
    cache$env_vars
  )
  show_env_vars(cache$env_vars)

  # Use combination of temporary path (with own package) and cached libpath
  # (for everything else) as check path
  cache$check_libpath <- c(temp_libpath, cache$libpath)

  # Append temporary path to libpath to avoid duplicate installation of this
  # package
  cache$libpath <- c(cache$libpath, temp_libpath)

  if (length(cache$skip) > 0) {
    message("Skipping: ", comma(cache$skip))
    cache$pkgs <- setdiff(cache$pkgs, cache$skip)
  }
  cache$skip <- NULL

  do.call(check_cran, cache)

  cat_rule("Saving check results to `revdep/checks.rds`")
  revdep_check_save(pkg, cache$revdeps, cache$check_dir, cache$libpath)

  # Delete cache and check_dir on successful run
  cat_rule("Cleaning up")
  revdep_check_reset(pkg)
  unlink(revdep_cache_path(pkg))
  unlink(cache$check_dir, recursive = TRUE)

  invisible()
}


revdep_check_save <- function(pkg, revdeps, check_path, lib_path) {
  check_suggested("sessioninfo")

  platform <- sessioninfo::platform_info()

  # Revdep results
  results <- lapply(check_dirs(check_path), parse_package_check)

  # Find all dependencies
  deps <- pkg[c("imports", "depends", "linkingto", "suggests")]
  pkgs <- unlist(lapply(deps, function(x) parse_deps(x)$name), use.names = FALSE)
  pkgs <- c(pkg$package, unique(pkgs))
  pkgs <- intersect(pkgs, dir(lib_path))
  dependencies <- sessioninfo::package_info(pkgs, libpath = lib_path)

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
      check_time = parse_check_time(file.path(path, "check-time.txt")),
      results = parse_check_results(file.path(path, "00check.log"))
    ),
    class = "revdep_check_result"
  )
}

revdep_check_path <- function(pkg) {
  file.path(pkg$path, "revdep", "checks.rds")
}

revdep_cache_path <- function(pkg) {
  revdep_cache_path_raw(pkg$path)
}

revdep_cache_path_raw <- function(path) {
  file.path(path, "revdep", ".cache.rds")
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
      mode = "wb", quiet = TRUE
    )
    on.exit(unlink(local))
    cp <- readRDS(local)
    rownames(cp) <- unname(cp[, 1])
    cp
  },
  ~memoise::timeout(30 * 60)
)

bioc_packages <- memoise::memoise(
  function(views = paste(BiocManager::repositories()[["BioCsoft"]], "VIEWS", sep = "/")) {
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
