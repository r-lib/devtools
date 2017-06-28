#' Install a local development package.
#'
#' Uses \code{R CMD INSTALL} to install the package. Will also try to install
#' dependencies of the package from CRAN, if they're not already installed.
#'
#' By default, installation takes place using the current package directory.
#' If you have compiled code, this means that artefacts of compilation will be
#' created in the \code{src/} directory. If you want to avoid this, you can
#' use \code{local = FALSE} to first build a package bundle and then install
#' it from a temporary directory. This is slower, but keeps the source
#' directory pristine.
#'
#' If the package is loaded, it will be reloaded after installation. This is
#' not always completely possible, see \code{\link{reload}} for caveats.
#'
#' To install a package in a non-default library, use \code{\link[withr]{with_libpaths}}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reload if \code{TRUE} (the default), will automatically reload the
#'   package after installing.
#' @param quick if \code{TRUE} skips docs, multiple-architectures,
#'   demos, and vignettes, to make installation as fast as possible.
#' @param local if \code{FALSE} \code{\link{build}}s the package first:
#'   this ensures that the installation is completely clean, and prevents any
#'   binary artefacts (like \file{.o}, \code{.so}) from appearing in your local
#'   package directory, but is considerably slower, because every compile has
#'   to start from scratch.
#' @param args An optional character vector of additional command line
#'   arguments to be passed to \code{R CMD install}. This defaults to the
#'   value of the option \code{"devtools.install.args"}.
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @param dependencies \code{logical} indicating to also install uninstalled
#'   packages which this \code{pkg} depends on/links to/suggests. See
#'   argument \code{dependencies} of \code{\link{install.packages}}.
#' @param upgrade_dependencies If \code{TRUE}, the default, will also update
#'   any out of date dependencies.
#' @param build_vignettes if \code{TRUE}, will build vignettes. Normally it is
#'   \code{build} that's responsible for creating vignettes; this argument makes
#'   sure vignettes are built even if a build never happens (i.e. because
#'   \code{local = TRUE}).
#' @param keep_source If \code{TRUE} will keep the srcrefs from an installed
#'   package. This is useful for debugging (especially inside of RStudio).
#'   It defaults to the option \code{"keep.source.pkgs"}.
#' @param threads number of concurrent threads to use for installing
#'   dependencies.
#'   It defaults to the option \code{"Ncpus"} or \code{1} if unset.
#' @param force_deps whether to force installation of dependencies even if their
#'   SHA1 reference hasn't changed from the currently installed version.
#' @param metadata Named list of metadata entries to be added to the
#'   \code{DESCRIPTION} after installation.
#' @param out_dir Directory to store installation output in case of failure.
#' @param skip_if_log_exists If the \code{out_dir} is defined and contains
#'   a file named \code{package.out}, no installation is attempted.
#' @param ... additional arguments passed to \code{\link{install.packages}}
#'   when installing dependencies. \code{pkg} is installed with
#'   \code{R CMD INSTALL}.
#' @export
#' @family package installation
#' @seealso \code{\link{with_debug}} to install packages with debugging flags
#'   set.
install <-
  function(pkg = ".", reload = TRUE, quick = FALSE, local = TRUE,
           args = getOption("devtools.install.args"), quiet = FALSE,
           dependencies = NA, upgrade_dependencies = TRUE,
           build_vignettes = FALSE,
           keep_source = getOption("keep.source.pkgs"),
           threads = getOption("Ncpus", 1),
           force_deps = FALSE,
           metadata = remote_metadata(as.package(pkg)),
           out_dir = NULL,
           skip_if_log_exists = FALSE,
           ...) {

  pkg <- as.package(pkg)

  # Forcing all of the promises for the current namespace now will avoid lazy-load
  # errors when the new package is installed overtop the old one.
  # https://stat.ethz.ch/pipermail/r-devel/2015-December/072150.html
  if (is_loaded(pkg)) {
    eapply(pkgload::ns_env(pkg), force, all.names = TRUE)
  }

  root_install <- is.null(installing$packages)
  if (root_install) {
    on.exit(installing$packages <- NULL, add = TRUE)
  }

  if (pkg$package %in% installing$packages) {
    if (!quiet) {
      message("Skipping ", pkg$package, ", it is already being installed.")
    }
    return(invisible(FALSE))
  }

  if (!is.null(out_dir)) {
    out_file <- file.path(out_dir, paste0(pkg$package, ".out"))
    if (skip_if_log_exists && file.exists(out_file)) {
      message("Skipping ", pkg$package, ", installation failed before, see log in ", out_file)
      return(invisible(FALSE))
    }
  } else {
    out_file <- NULL
  }

  installing$packages <- c(installing$packages, pkg$package)
  if (!quiet) {
    message("Installing ", pkg$package)
  }

  # If building vignettes, make sure we have all suggested packages too.
  if (build_vignettes && missing(dependencies)) {
    dependencies <- standardise_dep(TRUE)
  } else {
    dependencies <- standardise_dep(dependencies)
  }

  initial_deps <- dependencies[dependencies != "Suggests"]
  final_deps <- dependencies[dependencies == "Suggests"]

  # cache the Remote: dependencies here so we don't have to query them each
  # time we call install_deps
  installing$remote_deps <- remote_deps(pkg)
  on.exit(installing$remote_deps <- NULL, add = TRUE)

  install_deps(pkg, dependencies = initial_deps, upgrade = upgrade_dependencies,
    threads = threads, force_deps = force_deps, quiet = quiet, ...,
    out_dir = out_dir, skip_if_log_exists = skip_if_log_exists)

  # Build the package. Only build locally if it doesn't have vignettes
  has_vignettes <- length(tools::pkgVignettes(dir = pkg$path)$docs > 0)
  if (local && !(has_vignettes && build_vignettes)) {
    built_path <- pkg$path
  } else {
    built_path <- pkgbuild::build(
      pkg$path,
      tempdir(),
      vignettes = build_vignettes,
      quiet = quiet
    )
    on.exit(unlink(built_path), add = TRUE)
  }

  opts <- c(
    paste("--library=", .libPaths()[1], sep = ""),
    if (keep_source) "--with-keep.source",
    "--install-tests"
  )
  if (quick) {
    opts <- c(opts, "--no-docs", "--no-multiarch", "--no-demo")
  }
  opts <- c(opts, args)

  built_path <- normalizePath(built_path, winslash = "/")

  pkgbuild::rcmd_build_tools(
    "INSTALL",
    c(built_path, opts),
    echo = !quiet,
    show = !quiet,
    fail_on_status = TRUE,
    required = FALSE
  )

  install_deps(pkg, dependencies = final_deps, upgrade = upgrade_dependencies,
    threads = threads, force_deps = force_deps, quiet = quiet, ...,
    out_dir = out_dir, skip_if_log_exists = skip_if_log_exists)

  if (length(metadata) > 0) {
    add_metadata(pkgload::inst(pkg$package), metadata)
  }

  if (reload) {
    reload(pkg, quiet = quiet)
  }
  invisible(TRUE)
}

# A environment to hold which packages are being installed so packages with
# circular dependencies can be skipped the second time.
installing <- new.env(parent = emptyenv())

#' Install package dependencies if needed.
#'
#' \code{install_deps} is used by \code{install_*} to make sure you have
#' all the dependencies for a package. \code{install_dev_deps()} is useful
#' if you have a source version of the package and want to be able to
#' develop with it: it installs all dependencies of the package, and it
#' also installs roxygen2.
#'
#' @inheritParams install
#' @inheritParams package_deps
#' @param ... additional arguments passed to \code{\link{install.packages}}.
#' @export
#' @examples
#' \dontrun{install_deps(".")}
install_deps <- function(pkg = ".", dependencies = NA,
                         threads = getOption("Ncpus", 1),
                         repos = getOption("repos"),
                         type = getOption("pkgType"),
                         ...,
                         upgrade = TRUE,
                         quiet = FALSE,
                         force_deps = FALSE) {

  pkg <- dev_package_deps(pkg, repos = repos, dependencies = dependencies,
    type = type)
  update(pkg, ..., repos = repos, Ncpus = threads, quiet = quiet, upgrade = upgrade)
  invisible()
}

#' @rdname install_deps
#' @export
install_dev_deps <- function(pkg = ".", ...) {
  update_packages("roxygen2")
  install_deps(pkg, ..., dependencies = TRUE, upgrade = FALSE,
    bioc_packages = TRUE)
}
