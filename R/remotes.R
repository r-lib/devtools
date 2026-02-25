#' Deprecated package installation functions
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' These functions have been deprecated in favor of [pak](https://pak.r-lib.org/),
#' as that is what we now recommend for package installation. There are a few
#' functions which have no pak equivalent, where you can instead call the
#' old remotes functions directly.
#'
#' ## Migration guide
#'
#' | devtools function | Replacement |
#' |-------------------|-------------|
#' | `install_bioc("pkg")` | `pak::pak("bioc::pkg")` |
#' | `install_bitbucket("user/repo")` | `remotes::install_bitbucket("user/repo")` |
#' | `install_cran("pkg")` | `pak::pak("pkg")` |
#' | `install_dev("pkg")` | `remotes::install_dev("pkg")` |
#' | `install_git("url")` | `pak::pak("git::url")` |
#' | `install_github("user/repo")` | `pak::pak("user/repo")` |
#' | `install_gitlab("user/repo")` | `pak::pak("gitlab::user/repo")` |
#' | `install_local("path")` | `pak::pak("local::path")` |
#' | `install_svn("url")` | `remotes::install_svn("url")` |
#' | `install_url("url")` | `pak::pak("url::url")` |
#' | `install_version("pkg", "1.0.0")` | `pak::pak("pkg@1.0.0")` |
#' | `update_packages("pkg")` | `pak::pak("pkg")` |
#' | `dev_package_deps()` | `pak::local_dev_deps()` |
#' | `github_pull("123")` | `remotes::github_pull("123")` |
#' | `github_release()` | `remotes::github_release()` |
#'
#' @name install-deprecated
#' @keywords internal
NULL

#' @rdname install-deprecated
#' @export
install_bioc <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_bioc()",
    I('pak::pak("bioc::pkg")')
  )
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_bioc(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_bitbucket <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_bitbucket()",
    "remotes::install_bitbucket()"
  )
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_bitbucket(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_cran <- function(...) {
  lifecycle::deprecate_warn("2.5.0", "install_cran()", "pak::pak()")
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_cran(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_dev <- function(...) {
  lifecycle::deprecate_warn("2.5.0", "install_dev()", "remotes::install_dev()")
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_dev(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_git <- function(...) {
  lifecycle::deprecate_warn("2.5.0", "install_git()", I('pak::pak("git::url")'))
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_git(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_github <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_github()",
    I('pak::pak("user/repo")')
  )
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_github(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_gitlab <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_gitlab()",
    I('pak::pak("gitlab::user/repo")')
  )
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_gitlab(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_local <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_local()",
    I('pak::pak("local::path")')
  )
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_local(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_svn <- function(...) {
  lifecycle::deprecate_warn("2.5.0", "install_svn()", "remotes::install_svn()")
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_svn(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_url <- function(...) {
  lifecycle::deprecate_warn("2.5.0", "install_url()", I('pak::pak("url::url")'))
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_url(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
install_version <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "install_version()",
    I('pak::pak("pkg@version")')
  )
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::install_version(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
update_packages <- function(...) {
  lifecycle::deprecate_warn("2.5.0", "update_packages()", "pak::pak()")
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::update_packages(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
dev_package_deps <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "dev_package_deps()",
    "pak::local_dev_deps()"
  )
  check_installed("remotes")
  pkgbuild::with_build_tools(remotes::dev_package_deps(...), required = FALSE)
}

#' @rdname install-deprecated
#' @export
github_pull <- function(...) {
  lifecycle::deprecate_warn("2.5.0", "github_pull()", "remotes::github_pull()")
  check_installed("remotes")
  remotes::github_pull(...)
}

#' @rdname install-deprecated
#' @export
github_release <- function(...) {
  lifecycle::deprecate_warn(
    "2.5.0",
    "github_release()",
    "remotes::github_release()"
  )
  check_installed("remotes")
  remotes::github_release(...)
}
