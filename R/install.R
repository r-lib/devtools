#' Install a local development package.
#'
#' Uses `R CMD INSTALL` to install the package. Will also try to install
#' dependencies of the package from CRAN, if they're not already installed.
#'
#' If `quick = TRUE`, installation takes place using the current package
#' directory. If you have compiled code, this means that artefacts of
#' compilation will be created in the `src/` directory. If you want to avoid
#' this, you can use `build = TRUE` to first build a package bundle and then
#' install it from a temporary directory. This is slower, but keeps the source
#' directory pristine.
#'
#' If the package is loaded, it will be reloaded after installation. This is
#' not always completely possible, see [reload()] for caveats.
#'
#' To install a package in a non-default library, use [withr::with_libpaths()].
#'
#' @template devtools
#' @inheritParams remotes::install_local
#' @param reload if `TRUE` (the default), will automatically reload the
#'   package after installing.
#' @param quick if `TRUE` skips docs, multiple-architectures,
#'   demos, and vignettes, to make installation as fast as possible.
#' @param build if `TRUE` [pkgbuild::build()]s the package first:
#'   this ensures that the installation is completely clean, and prevents any
#'   binary artefacts (like \file{.o}, `.so`) from appearing in your local
#'   package directory, but is considerably slower, because every compile has
#'   to start from scratch.
#'
#'   One downside of installing from a built tarball is that the package is
#'   installed from a temporary location. This means that any source references,
#'   at R level or C/C++ level, will point to dangling locations. The debuggers
#'   will not be able to find the sources for step-debugging. If you're
#'   installing the package for development, consider setting `build` to
#'   `FALSE`.
#' @param args An optional character vector of additional command line
#'   arguments to be passed to `R CMD INSTALL`. This defaults to the
#'   value of the option `"devtools.install.args"`.
#' @param build_vignettes if `TRUE`, will build vignettes. Normally it is
#'   `build` that's responsible for creating vignettes; this argument makes
#'   sure vignettes are built even if a build never happens (i.e. because
#'   `build = FALSE`).
#' @param keep_source If `TRUE` will keep the srcrefs from an installed
#'   package. This is useful for debugging (especially inside of RStudio).
#'   It defaults to the option `"keep.source.pkgs"`.
#' @param ... additional arguments passed to [remotes::install_deps()]
#'   when installing dependencies.
#' @family package installation
#' @seealso [update_packages()] to update installed packages from the
#' source location and [with_debug()] to install packages with
#' debugging flags set.
#' @export
install <-
  function(
    pkg = ".",
    reload = TRUE,
    quick = FALSE,
    build = !quick,
    args = getOption("devtools.install.args"),
    quiet = FALSE,
    dependencies = NA,
    upgrade = "default",
    build_vignettes = FALSE,
    keep_source = getOption("keep.source.pkgs"),
    force = FALSE,
    ...
  ) {
    pkg <- as.package(pkg)

    # Forcing all of the promises for the current namespace now will avoid lazy-load
    # errors when the new package is installed overtop the old one.
    # https://stat.ethz.ch/pipermail/r-devel/2015-December/072150.html
    if (reload && is_loaded(pkg)) {
      eapply(pkgload::ns_env(pkg$package), force, all.names = TRUE)
    }

    if (isTRUE(build_vignettes)) {
      # we likely need all Suggested dependencies if building vignettes
      dependencies <- TRUE
      build_opts <- c("--no-resave-data", "--no-manual")
    } else {
      build_opts <- c("--no-resave-data", "--no-manual", "--no-build-vignettes")
    }

    opts <- c(
      if (keep_source) "--with-keep.source",
      "--install-tests"
    )
    if (quick) {
      opts <- c(opts, "--no-docs", "--no-multiarch", "--no-demo")
    }
    opts <- c(opts, args)

    check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

    remotes::install_deps(
      pkg$path,
      build = build,
      build_opts = build_opts,
      INSTALL_opts = opts,
      dependencies = dependencies,
      quiet = quiet,
      force = force,
      upgrade = upgrade,
      ...
    )

    if (build) {
      install_path <- pkgbuild::build(
        pkg$path,
        dest_path = tempdir(),
        args = build_opts,
        quiet = quiet
      )
      on.exit(file_delete(install_path), add = TRUE)
    } else {
      install_path <- pkg$path
    }

    was_loaded <- is_loaded(pkg)
    was_attached <- is_attached(pkg)

    if (reload && was_loaded) {
      pkgload::unregister(pkg$package)
    }

    pkgbuild::with_build_tools(
      required = FALSE,
      callr::rcmd(
        "INSTALL",
        c(install_path, opts),
        echo = !quiet,
        show = !quiet,
        spinner = FALSE,
        stderr = "2>&1",
        fail_on_status = TRUE
      )
    )

    if (reload && was_loaded) {
      if (was_attached) {
        require(pkg$package, quietly = TRUE, character.only = TRUE)
      } else {
        requireNamespace(pkg$package, quietly = TRUE)
      }
    }

    invisible(TRUE)
  }

#' Install package dependencies if needed
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' These functions are deprecated. Please use `pak::local_install_deps()`
#' instead of `install_deps()` and `pak::local_install_dev_deps()` instead of
#' `install_dev_deps()`.
#'
#' @inheritParams install
#' @inherit remotes::install_deps
#' @export
install_deps <- function(
  pkg = ".",
  dependencies = NA,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  upgrade = c("default", "ask", "always", "never"),
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", " --no-build-vignettes"),
  ...
) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_deps()",
    "pak::local_install_deps()"
  )
  pkg <- as.package(pkg)

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  remotes::install_deps(
    pkg$path,
    dependencies = dependencies,
    repos = repos,
    type = type,
    upgrade = upgrade,
    quiet = quiet,
    build = build,
    build_opts = build_opts,
    ...
  )
}

#' @rdname install_deps
#' @export
install_dev_deps <- function(
  pkg = ".",
  dependencies = TRUE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  upgrade = c("default", "ask", "always", "never"),
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", " --no-build-vignettes"),
  ...
) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_dev_deps()",
    "pak::local_install_dev_deps()"
  )
  remotes::update_packages("roxygen2")

  pkg <- as.package(pkg)

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  remotes::install_deps(
    pkg$path,
    dependencies = dependencies,
    repos = repos,
    type = type,
    upgrade = upgrade,
    quiet = quiet,
    build = build,
    build_opts = build_opts,
    ...
  )
}

local_install <- function(pkg = ".", quiet = TRUE, env = parent.frame()) {
  pkg <- as.package(pkg)

  cli::cli_inform(c(i = "Installing {.pkg {pkg$package}} in temporary library"))
  withr::local_temp_libpaths(.local_envir = env)
  install(pkg, upgrade = "never", reload = FALSE, quick = TRUE, quiet = quiet)
}
