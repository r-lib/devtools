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
#' @export
session_info <- function() {
  structure(
    list(
      platform = platform_info(),
      packages = package_info()
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

package_info <- function(include_base = FALSE) {
  attached_pkg <- grep("^package:", search(), value = TRUE)
  attached_pkg <- sub("^package:", "", attached_pkg)
  loaded_pkg <- setdiff(loadedNamespaces(), attached_pkg)
  attached <- rep(c(TRUE, FALSE), c(length(loaded_pkg), length(attached_pkg)))

  pkgs <- data.frame(
    package = c(loaded_pkg, attached_pkg),
    `*` = ifelse(attached, "", "*"),
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
  pkgs$version <- vapply(pkgs$package,
    function(x) as.character(packageVersion(x)),
    character(1)
  )

  if (!include_base) {
    base <- vapply(pkgs$package, pkg_is_base, logical(1))
    pkgs <- pkgs[!base, , drop = FALSE]
  }

  pkgs$date <- vapply(pkgs$package, pkg_date, character(1))
  pkgs$source <- vapply(pkgs$package, pkg_source, character(1))

  pkgs <- pkgs[order(pkgs$package), ]
  rownames(pkgs) <- NULL
  class(pkgs) <- c("packages_info", "data.frame")
  pkgs[, c("package", "*", "version", "date", "source")]
}

#' @export
print.packages_info <- function(x, ...) {
  print.data.frame(x, right = FALSE, row.names = FALSE)
}

pkg_is_base <- function(pkg) {
  desc <- packageDescription(pkg)
  !is.null(desc$Priority) && desc$Priority == "base"
}

pkg_date <- function(pkg) {
  desc <- packageDescription(pkg)

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

pkg_source <- function(pkg) {
  desc <- packageDescription(pkg)

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
