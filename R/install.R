#' Install a local development package
#'
#' @description
#' Uses `R CMD INSTALL` to install the package, after installing needed
#' dependencies with [pak::local_install_deps()].
#'
#' To install to a non-default library, use [withr::with_libpaths()].
#'
#' @template devtools
#' @param reload if `TRUE` (the default), will automatically attempt to reload
#'   the package after installing. Reloading is not always completely possible
#'   so see [pkgload::unregister()] for caveats.
#' @param quick if `TRUE`, skips some optional steps (e.g. help
#'   pre-rendering and multi-arch builds) to make installation as fast
#'   as possible.
#' @param build if `TRUE` (the default), [pkgbuild::build()]s the package
#'   first. This ensures that the installation is completely clean, and
#'   prevents any binary artefacts (like \file{.o}, `.so`) from appearing
#'   in your local package directory, but is considerably slower, because
#'   every compile has to start from scratch.
#'
#'   One downside of installing from a built tarball is that the package is
#'   installed from a temporary location. This means that any source references
#'   will point to dangling locations and debuggers won't have direct access to
#'   the source for step-debugging. For development purposes, `build = FALSE` is
#'   often the better choice.
#'
#'   If `FALSE`, the package is installed directly from its source
#'   directory. This is faster and can be favorable for preserving source
#'   references for debugging (see `keep_source`).
#' @param args An optional character vector of additional command line
#'   arguments to be passed to `R CMD INSTALL`. This defaults to the
#'   value of the option `"devtools.install.args"`.
#' @param build_vignettes if `TRUE`, will build vignettes. Normally it is
#'   `build` that's responsible for creating vignettes; this argument makes
#'   sure vignettes are built even if a build never happens (i.e. because
#'   `build = FALSE`).
#' @param keep_source If `TRUE` will keep the srcrefs from an installed
#'   package. This is useful for debugging (especially inside of RStudio or
#'   Positron). Defaults to `getOption("keep.source.pkgs") || !build`,
#'   since srcrefs are most useful when the package is installed from its
#'   source directory, i.e. when `build = FALSE`.
#' @param quiet If `TRUE`, suppress output.
#' @param force `r lifecycle::badge("deprecated")` No longer used.
#' @family package installation
#' @inheritParams pak::local_install_deps
#' @seealso [with_debug()] to install packages with debugging flags set.
#' @export
install <- function(
  pkg = ".",
  reload = TRUE,
  quick = FALSE,
  build = !quick,
  args = getOption("devtools.install.args"),
  quiet = FALSE,
  dependencies = NA,
  upgrade = FALSE,
  build_vignettes = FALSE,
  keep_source = getOption("keep.source.pkgs") || !build,
  force = deprecated()
) {
  if (!is.logical(upgrade) || length(upgrade) != 1) {
    cli::cli_abort("{.arg upgrade} must be a single TRUE, FALSE, or NA")
  }
  if (lifecycle::is_present(force)) {
    lifecycle::deprecate_warn("2.5.0", "install(force)")
  }

  pkg <- as.package(pkg)

  # Forcing all of the promises for the current namespace now will avoid lazy-load
  # errors when the new package is installed overtop the old one.
  # https://stat.ethz.ch/pipermail/r-devel/2015-December/072150.html
  if (reload && is_loaded(pkg)) {
    eapply(pkgload::ns_env(pkg$package), base::force, all.names = TRUE)
  }

  # Install dependencies
  local({
    if (quiet) {
      withr::local_output_sink(withr::local_tempfile())
      withr::local_message_sink(withr::local_tempfile())
    } else {
      cli::cat_rule(
        paste0("Installing dependencies of ", pkg$package),
        col = "cyan"
      )
    }
    pak::local_install_deps(
      pkg$path,
      upgrade = upgrade,
      dependencies = dependencies || isTRUE(build_vignettes)
    )
  })

  if (isTRUE(build_vignettes)) {
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

  if (!quiet) {
    cli::cat_rule(paste0("Installing ", pkg$package), col = "cyan")
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
}

#' Install package dependencies if needed
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' These functions are deprecated. Better alternatives:
#' * `pak::local_install_deps()` instead of `install_deps()`
#' * `pak::local_install_dev_deps()` instead of `install_dev_deps()`
#'
#' @inherit remotes::install_deps
#' @inheritParams install
#' @param ... Additional arguments passed to [remotes::install_deps()].
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
  install(pkg, upgrade = FALSE, reload = FALSE, quick = TRUE, quiet = quiet)
}
