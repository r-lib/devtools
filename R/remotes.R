#' @importFrom ellipsis check_dots_used
with_ellipsis <- function(fun) {
  b <- body(fun)

  f <- function(...) {
    ellipsis::check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

    !! b
  }
  f <- rlang::expr_interp(f)

  body(fun) <- body(f)
  fun
}

with_pkgbuild_build_tools <- function(fun) {
  b <- body(fun)
  pkgbuild_call <- as.call(c(call("::", as.symbol("pkgbuild"), as.symbol("with_build_tools")), b, list(required = FALSE)))

  body(fun) <- pkgbuild_call
  fun
}

#' Functions re-exported from the remotes package
#'

#' These functions are re-exported from the remotes package. They differ only
#' that the ones in devtools use the [ellipsis::check_dots_used] feature to ensure all dotted
#' arguments are used.
#'
#' Follow the links below to see the documentation.
#' [remotes::install_bioc()], [remotes::install_bitbucket()], [remotes::install_cran()], [remotes::install_dev()],
#' [remotes::install_git()], [remotes::install_github()], [remotes::install_gitlab()], [remotes::install_local()],
#' [remotes::install_svn()], [remotes::install_url()], [remotes::install_version()], [remotes::update_packages()],
#' [remotes::dev_package_deps()].
#'
#' @importFrom remotes install_bioc
#' @name remote-reexports
#' @keywords internal
#' @export
install_bioc <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_bioc))

#' @importFrom remotes install_bitbucket
#' @rdname remote-reexports
#' @export
install_bitbucket <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_bitbucket))

#' @importFrom remotes install_cran
#' @rdname remote-reexports
#' @export
install_cran <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_cran))

#' @importFrom remotes install_dev
#' @rdname remote-reexports
#' @export
install_dev <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_dev))

#' @importFrom remotes install_git
#' @rdname remote-reexports
#' @export
install_git <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_git))

#' @importFrom remotes install_github
#' @rdname remote-reexports
#' @export
install_github <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_github))

#' @importFrom remotes github_pull
#' @rdname reexports
#' @export
remotes::github_pull

#' @importFrom remotes github_release
#' @rdname reexports
#' @export
remotes::github_release

#' @importFrom remotes install_gitlab
#' @rdname remote-reexports
#' @export
install_gitlab <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_gitlab))

#' @importFrom remotes install_local
#' @rdname remote-reexports
#' @export
install_local <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_local))

#' @importFrom remotes install_svn
#' @rdname remote-reexports
#' @export
install_svn <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_svn))

#' @importFrom remotes install_url
#' @rdname remote-reexports
#' @export
install_url <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_url))

#' @importFrom remotes install_version
#' @rdname remote-reexports
#' @export
install_version <- with_pkgbuild_build_tools(with_ellipsis(remotes::install_version))

#' @importFrom remotes update_packages
#' @rdname remote-reexports
#' @export
update_packages <- with_pkgbuild_build_tools(with_ellipsis(remotes::update_packages))

#' @importFrom remotes dev_package_deps
#' @rdname remote-reexports
#' @export
dev_package_deps <- with_pkgbuild_build_tools(remotes::dev_package_deps)
