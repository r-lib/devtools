#' Install a package.
#'
#' Uses \code{R CMD INSTALL} to install the package. Will also try to install
#' dependencies of the package from CRAN, if they're not already installed.
#'
#' Installation takes place on a copy of the package produced by 
#' \code{R CMD build} to avoid modifying the local directory in any way.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reload if \code{TRUE} (the default), will automatically reload the 
#'   package after installing.
#' @export
#' @importFrom utils install.packages
install <- function(pkg = NULL, reload = TRUE) {
  pkg <- as.package(pkg)
  message("Installing ", pkg$package)
  install_deps(pkg)  
  
  built_path <- build(pkg, tempdir())
  on.exit(unlink(built_path))    

  install.packages(built_path, repos = NULL, type = "source")

  if (reload) reload(pkg)
  invisible(TRUE)
}

install_deps <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  deps <- c(parse_deps(pkg$depends), parse_deps(pkg$imports), 
    parse_deps(pkg$linkingto))
  
  # Remove packages that are already installed
  not.installed <- function(x) length(find.package(x, quiet = TRUE)) == 0
  deps <- Filter(not.installed, deps)
  
  if (length(deps) == 0) return(invisible())
  
  message("Installing dependencies for ", pkg$package, ":\n", 
    paste(deps, collapse = ", "))
  install.packages(deps)
  invisible(deps)
}

#' Attempts to install a package directly from github.
#'
#' @param username Github username
#' @param repo Repo name
#' @param branch Desired branch - defaults to \code{"master"}
#' @export
#' @importFrom RCurl getBinaryURL
#' @examples
#' \dontrun{
#' install_github("roxygen")
#' }
install_github <- function(repo, username = "hadley", branch = "master") {
  
  message("Installing ", repo, " from ", username)
  name <- paste(username, "-", repo, sep = "")
  url <- paste("https://github.com/", username, "/", repo, sep = "")

  # Download and unzip repo zip
  zip_url <- paste("https://nodeload.github.com/", username, "/", repo,
    "/zipball/", branch, sep = "")
  src <- file.path(tempdir(), paste(name, ".zip", sep = ""))
  
  content <- getBinaryURL(zip_url, .opts = list(
    followlocation = TRUE, ssl.verifypeer = FALSE))
  writeBin(content, src)
  on.exit(unlink(src), add = TRUE)
  
  pkg_name <- basename(as.character(unzip(src, list = TRUE)$Name[1]))
  out_path <- file.path(tempdir(), pkg_name)
  unzip(src, exdir = tempdir())
  on.exit(unlink(out_path), add = TRUE)
  
  # Check it's an R package
  if (!file.exists(file.path(out_path, "DESCRIPTION"))) {
    stop("Does not appear to be an R package", call. = FALSE)
  }
  
  # Install
  install(out_path)
}

#' Install specified version of a CRAN package.
#'
#' If you are installing an package that contains compiled code, you will 
#' need to have an R development environment installed.  You can check
#' if you do by running \code{\link{has_devel}}.
#'
#' @export
#' @param package package name
#' @param version If the specified version is NULL or the same as the most
#'   recent version of the package, this function simply calls
#'   \code{\link{install.packages}}. Otherwise, it looks at the list of
#'   archived source tarballs and tries to install an older version instead.
#' @inheritParams utils::install.packages
#' @author Jeremy Stephens
install_version <- function(package, version = NULL, repos = getOption("repos"), type = getOption("pkgType")) {
  
  contriburl <- contrib.url(repos, type)
  available <- available.packages(contriburl)
  
  if (!is.null(version)) {
    version <- numeric_version(version)
  }
  
  if (package %in% row.names(available)) {
    current.version <- available[package, 'Version']
    if (is.null(version) || version == current.version) {
      return(install.packages(package, repos = repos, contriburl = contriburl,
        type = type))
    }
  }

  con <- gzcon(url(sprintf("%s/src/contrib/Archive.rds", repos), "rb"))
  on.exit(close(con))
  archive <- readRDS(con)

  info <- archive[[package]]
  if (is.null(info)) {
    stop(sprintf("couldn't find package '%s'", package))
  }

  if (is.null(version)) {
    # Grab the latest one: only happens if pulled from CRAN
    package.path <- info[length(info)]
  } else {
    package.path <- paste(package, "/", package, "_", version, ".tar.gz", sep="")
    if (!(package.path %in% info)) {
      stop(sprintf("version '%s' is invalid for package '%s'", package,
        version))
    }
  }
  package.url <- sprintf("%s/src/contrib/Archive/%s", repos, package.path)
  local.path <- file.path(tempdir(), basename(package.path))

  if (download.file(package.url, local.path) != 0) {
    stop("couldn't download file: ", package.url)
  }
  on.exit(unlink(local.path), add = TRUE)
  
  install.packages(local.path, repos = NULL, type = "source")
}
