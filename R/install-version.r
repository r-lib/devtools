#' Install specified version of a CRAN package.
#'
#' If you are installing an package that contains compiled code, you will
#' need to have an R development environment installed.  You can check
#' if you do by running \code{\link[pkgbuild]{has_build_tools}}.
#'
#' @export
#' @family package installation
#' @param package package name
#' @param version If the specified version is NULL or the same as the most
#'   recent version of the package, this function simply calls
#'   \code{\link{install}}. Otherwise, it looks at the list of
#'   archived source tarballs and tries to install an older version instead.
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @inheritParams utils::install.packages
#' @author Jeremy Stephens
install_version <- function(package, version = NULL, repos = getOption("repos"), type = getOption("pkgType"), ...) {
  if (length(package) < 1) return()
  if (length(package) > 1)
    stop("install_version() must be called with a single 'package' argument - multiple packages given")

  ## returns TRUE if version 'to.check' satisfies version criteria 'criteria'
  satisfies <- function(to.check, criteria) {
    to.check <- package_version(to.check)
    result <- apply(criteria, 1, function(r) {
      if(is.na(r['compare'])) TRUE
      else get(r['compare'], mode='function')(to.check, r['version'])
    })
    all(result)
  }

  install_version_deps <- function(deps) {
    ## TODO How to exclude 'base', 'stats', etc.?
    for (dep in unique(deps$package)) {
      lines <- subset(deps, package==dep)
      if (!have(dep, lines))
        install_version(dep, paste(lines$compare, lines$version), repos, type, ...)
    }
  }

  have <- function(pkg, criteria) {
    v <- suppressWarnings(packageDescription(pkg, fields = "Version"))
    if (is.na(v)) return(FALSE)
    satisfies(v, criteria)
  }

  numeric_ver <- .standard_regexps()$valid_numeric_version
  package_ver <- .standard_regexps()$valid_package_version

  spec <- if(is.null(version) || is.na(version)) package else
    ifelse(grepl(paste0("^", numeric_ver, "$"), version),
           paste0(package, "(== ", version, ")"),
           paste0(package, "(", version, ")"))

  required <- parse_deps(paste(spec, collapse=", "))


  ## TODO should we do for(r in repos) { for (t in c('published','archive')) {...}}, or
  ## for (t in c('published','archive')) { for(r in repos) {...}} ? Right now it's the latter.  It
  ## only comes up if required version is satisfied by both an early repo in archive/ and a late repo

  ## First search for currently-published package
  for (repo in repos) {
    contriburl <- contrib.url(repo, type)
    available <- available.packages(contriburl)

    if (package %in% row.names(available) && satisfies(available[package, 'Version'], required)) {
      deps <- parse_deps(available[package, 'Dependencies'])
      install_version_deps(deps)
      return(install.packages(package, repos = repos, contriburl = contriburl, type = type, ...))
    }
  }

  ## Next search for archived package
  for (repo in repos) {
    info <- package_find_repo(package, repo)

    package.path <- NULL
    if (is.null(version)) {
      package.path <- info$path[NROW(info)] # Grab the latest one
    } else {
      for (i in seq_len(nrow(info))) {
        r <- info[i,]
        archive.version <- sub(paste0(".+/.+_(", package_ver, ")\\.tar\\.gz$"), "\\1", r$path)
        if (satisfies(archive.version, required)) {
          package.path <- r$path
          break
        }
      }
    }
    if (!is.null(package.path)) {
      bundle <- remote_download(url_remote(file.path(r$repo, "/src/contrib/Archive/", package.path)))
      on.exit(unlink(bundle), add = TRUE)

      source <- source_pkg(bundle)
      on.exit(unlink(source, recursive = TRUE), add = TRUE)

      pkg <- as.package(source)
      dep_list <- pkg[tolower(standardise_dep(TRUE))]
      deps <- do.call("rbind", unname(compact(lapply(dep_list, parse_deps))))
      install_version_deps(deps)

      return(install_local(source, ...))
    }
  }

  stop(sprintf("Couldn't find appropriate version of '%s' package", package))
}

read_archive <- function(repo) {
  tryCatch({
    con <- gzcon(url(sprintf("%s/src/contrib/Meta/archive.rds", repo), "rb"))
    on.exit(close(con))
    readRDS(con)
  },
  warning = function(e) { list() },
  error = function(e) { list() })
}

package_find_repo <- function(package, repos) {
  archive_info <- function(repo) {
    if (length(repos) > 1)
      message("Trying ", repo)

    archive <- read_archive(repo)

    info <- archive[[package]]
    if (!is.null(info)) {
      info$repo <- repo
      info$path <- rownames(info)
      info
    }
  }

  res <- do.call(rbind.data.frame,
    c(lapply(repos, archive_info), list(make.row.names = FALSE)))

  if (NROW(res) == 0) {
    stop(sprintf("couldn't find package '%s'", package))
  }

  # order by the path (which contains the version) and then by modified time.
  # This needs to be done in case the same package is available from multiple
  # repositories.
  res[order(res$path, res$mtime), ]
}
