#' Return a vector of names of attached packages
#' @export
#' @keywords internal
#' @return A data frame with columns package and path, giving the name of
#'   each package and the path it was loaded from.
loaded_packages <- function() {

  attached <- data.frame(
    package = search(),
    path = searchpaths(),
    stringsAsFactors = FALSE
  )
  packages <- attached[grepl("^package:", attached$package), , drop = FALSE]
  rownames(packages) <- NULL

  packages$package <- sub("^package:", "", packages$package)
  packages
}

#' Return a vector of names of packages loaded by devtools
#' @export
#' @keywords internal
dev_packages <- function() {
  packages <- vapply(loadedNamespaces(),
    function(x) !is.null(dev_meta(x)), logical(1))

  names(packages)[packages]
}

#' Print session information
#'
#' This is \code{\link{sessionInfo}()} re-written from scratch to both exclude
#' data that's rarely useful (e.g., the full collate string or base packages
#' loaded) and include stuff you'd like to know (e.g., where a package was
#' installed from).
#'
#' @param pkgs Either a vector of package names or NULL. If \code{NULL},
#'   displays all loaded packages. If a character vector, also, includes
#'   all dependencies of the package.
#' @param include_base Include base packages in summary? By default this is
#'   false since base packages should always match the R version.
#' @export
#' @examples
#' session_info()
#' session_info("devtools")
session_info <- function(pkgs = NULL, include_base = FALSE) {
  if (is.null(pkgs)) {
    pkgs <- loadedNamespaces()
  } else {
    pkgs <- find_deps(pkgs, installed.packages(), top_dep = NA)
  }

  structure(
    list(
      platform = platform_info(),
      packages = package_info(pkgs, include_base = include_base)
    ),
    class = "session_info"
  )
}

#' @export
print.session_info <- function(x, ...) {
  rule("Session info")
  print(x$platform)
  cat("\n")
  rule("Packages")
  print(x$packages)
}

platform_info <- function() {
  if (rstudioapi::isAvailable()) {
    ver <- rstudioapi::getVersion()
    ui <- paste0("RStudio (", ver, ")")
  } else {
    ui <- .Platform$GUI
  }

  structure(list(
    version = R.version.string,
    system = version$system,
    ui = ui,
    language = Sys.getenv("LANGUAGE", "(EN)"),
    collate = Sys.getlocale("LC_COLLATE"),
    tz = Sys.timezone()
  ), class = "platform_info")

}

#' @export
print.platform_info <- function(x, ...) {
  df <- data.frame(setting = names(x), value = unlist(x), stringsAsFactors = FALSE)
  print(df, right = FALSE, row.names = FALSE)
}

package_info <- function(pkgs = loadedNamespaces(), include_base = FALSE,
                         libpath = NULL) {
  if (!include_base) {
    base <- vapply(pkgs, pkg_is_base, logical(1))
    pkgs <- pkgs[!base]
  }
  pkgs <- sort(pkgs)
  attached <- pkgs %in% sub("^package:", "", search())

  desc <- lapply(pkgs, packageDescription, lib.loc = libpath)
  version <- vapply(desc, function(x) x$Version, character(1))
  date <- vapply(desc, pkg_date, character(1))
  source <- vapply(desc, pkg_source, character(1))

  pkgs_df <- data.frame(
    package = pkgs,
    `*` = ifelse(attached, "*", ""),
    version = version,
    date = date,
    source = source,
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
  rownames(pkgs_df) <- NULL
  class(pkgs_df) <- c("packages_info", "data.frame")

  pkgs_df
}

#' @export
print.packages_info <- function(x, ...) {
  print.data.frame(x, right = FALSE, row.names = FALSE)
}

pkg_is_base <- function(pkg) {
  desc <- packageDescription(pkg)
  !is.null(desc$Priority) && desc$Priority == "base"
}

pkg_date <- function(desc) {
  if (!is.null(desc$`Date/Publication`)) {
    date <- desc$`Date/Publication`
  } else if (!is.null(desc$Built)) {
    built <- strsplit(desc$Built, "; ")[[1]]
    date <- built[3]
  } else {
    date <- NA_character_
  }

  as.character(as.Date(strptime(date, "%Y-%m-%d")))
}

pkg_source <- function(desc) {
  if (!is.null(desc$GithubSHA1)) {
    str <- paste0("Github (",
                  desc$GithubUsername, "/",
                  desc$GithubRepo, "@",
                  substr(desc$GithubSHA1, 1, 7), ")")
  } else if (!is.null(desc$RemoteType)) {
    str <- paste0(desc$RemoteType, " (",
      desc$RemoteUsername, "/",
      desc$RemoteRepo, "@",
      substr(desc$RemoteSha, 1, 7), ")")

  } else if (!is.null(desc$Repository)) {
    repo <- desc$Repository

    if (!is.null(desc$Built)) {
      built <- strsplit(desc$Built, "; ")[[1]]
      ver <- sub("$R ", "", built[1])

      repo <- paste0(repo, " (", ver, ")")
    }

    repo

  } else if (!is.null(desc$biocViews)) {
    "Bioconductor"
  } else {
    "local"
  }
}
