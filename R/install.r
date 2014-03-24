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
#' @param build_vignettes if \code{TRUE}, will build vignettes. Normally it is
#'   \code{build} that's responsible for creating vignettes; this argument makes
#'   sure vignettes are built even if a build never happens (i.e. because
#'   \code{local = TRUE}.
#' @param keep_source If \code{TRUE} will keep the srcrefs from an installed
#'   package. This is useful for debugging (especially inside of RStudio).
#'   It defaults to the option \code{"keep.source.pkgs"}.
#' @param threads number of concurrent threads to use for installing
#'   dependencies.
#'   It defaults to the option \code{"Ncpus"} or \code{1} if unset.
#' @export
#' @family package installation
#' @seealso \code{\link{with_debug}} to install packages with debugging flags
#'   set.
#' @importFrom utils install.packages
install <- function(pkg = ".", reload = TRUE, quick = FALSE, local = TRUE,
                    args = getOption("devtools.install.args"), quiet = FALSE,
                    dependencies = NA, build_vignettes = !quick,
                    keep_source = getOption("keep.source.pkgs"),
                    threads = getOption("Ncpus", 1)) {

  pkg <- as.package(pkg)

  if (!quiet) message("Installing ", pkg$package)
  install_deps(pkg, dependencies = dependencies, threads = threads)

  # Build the package. Only build locally if it doesn't have vignettes
  has_vignettes <- length(pkgVignettes(dir = pkg$path)$doc > 0)
  if (local && !(has_vignettes && build_vignettes)) {
    built_path <- pkg$path
  } else {
    built_path <- build(pkg, tempdir(), vignettes = build_vignettes, quiet = quiet)
    on.exit(unlink(built_path))
  }

  opts <- c(
    paste("--library=", shQuote(.libPaths()[1]), sep = ""),
    if (keep_source) "--with-keep.source",
    "--install-tests"
  )
  if (quick) {
    opts <- c(opts, "--no-docs", "--no-multiarch", "--no-demo")
  }
  opts <- paste(paste(opts, collapse = " "), paste(args, collapse = " "))

  R(paste("CMD INSTALL ", shQuote(built_path), " ", opts, sep = ""),
    quiet = quiet)

  if (reload) reload(pkg, quiet = quiet)
  invisible(TRUE)
}

#' Install package dependencies
#'
#' @inheritParams install
#' @export
#' @examples
#' \dontrun{install_deps(".")}
install_deps <- function(pkg = ".", dependencies = NA,
                         threads = getOption("Ncpus", 1)) {
  pkg <- as.package(pkg)
  info <- pkg_deps(pkg, dependencies)

  # Packages that are not already installed or without required versions
  needs_install <- function(pkg, compare, version) {
    if (length(find.package(pkg, quiet = TRUE)) == 0) return(TRUE)
    if (is.na(compare)) return(FALSE)

    compare <- match.fun(compare)
    !compare(packageVersion(pkg), version)
  }
  needed <- Map(needs_install, info$name, info$compare, info$version)
  deps <- info$name[as.logical(needed)]
  if (length(deps) == 0) return(invisible())

  message("Installing dependencies for ", pkg$package, ":\n",
    paste(deps, collapse = ", "))
  install.packages(deps, dependencies = NA, Ncpus = threads)
  invisible(deps)
}

pkg_deps <- function(pkg = ".", dependencies = NA) {
  pkg <- as.package(pkg)

  deps <- if (identical(dependencies, NA)) {
    c("Depends", "Imports", "LinkingTo")
  } else if (isTRUE(dependencies)) {
    c("Depends", "Imports", "LinkingTo", "Suggests", "VignetteBuilder")
  } else if (identical(dependencies, FALSE)) {
    character(0)
  } else dependencies

  deps <- unlist(pkg[tolower(deps)], use.names = FALSE)

  parse_deps(paste(deps, collapse = ','))
}
