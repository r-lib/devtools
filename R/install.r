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
#' @param local if \code{TRUE} does not build the package first, instead
#'   installing from the local package directory. This may result in build
#'   artefacts in your package directory, but is considerably faster, and does
#'   not require a recompile every time you run it.
#' @param args An optional character vector of additional command line
#'   arguments to bew passed to \code{R CMD install}. This defaults to the
#'   value of the option \code{"devtools.install.args"}.
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @param dependencies \code{logical} indicating to also install uninstalled
#'   packages which this \code{pkg} depends on/links to/suggests. See
#'   argument \code{dependencies} of \code{\link{install.packages}}.
#' @export
#' @family package installation
#' @seealso \code{\link{with_debug}} to install packages with debugging flags
#'   set.
#' @importFrom utils install.packages
install <- function(pkg = ".", reload = TRUE, quick = FALSE, local = TRUE,
                    args = getOption("devtools.install.args"), quiet = FALSE,
                    dependencies = NA) {

  pkg <- as.package(pkg)

  if (!quiet) message("Installing ", pkg$package)
  install_deps(pkg, dependencies = dependencies)

  # Build the package. If quick, don't build vignettes
  if (local) {
    built_path <- pkg$path
  } else {
    built_path <- build(pkg, tempdir(), vignettes = !quick, quiet = quiet)
    on.exit(unlink(built_path))
  }

  opts <- c(
    paste("--library=", shQuote(.libPaths()[1]), sep = ""),
    "--with-keep.source", "--install-tests")
  if (quick) {
    opts <- c(opts, "--no-docs", "--no-multiarch", "--no-demo")
  }
  opts <- paste(paste(opts, collapse = " "), paste(args, collapse = " "))

  R(paste("CMD INSTALL ", shQuote(built_path), " ", opts, sep = ""),
    quiet = quiet)

  if (reload) reload(pkg, quiet = quiet)
  invisible(TRUE)
}

install_deps <- function(pkg = ".", dependencies = NA) {
  pkg <- as.package(pkg)
  deps <- c(parse_deps(pkg$depends)$name, parse_deps(pkg$imports)$name,
    parse_deps(pkg$linkingto)$name)

  # Remove packages that are already installed
  not.installed <- function(x) length(find.package(x, quiet = TRUE)) == 0
  deps <- Filter(not.installed, deps)

  if (length(deps) == 0) return(invisible())

  message("Installing dependencies for ", pkg$package, ":\n",
    paste(deps, collapse = ", "))
  install.packages(deps, dependencies = dependencies)
  invisible(deps)
}

