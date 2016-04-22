#' Find all dependencies of a CRAN or dev package.
#'
#' Find all the dependencies of a package and determine whether they are ahead
#' or behind CRAN. A \code{print()} method identifies mismatches (if any)
#' between local and CRAN versions of each dependent package; an
#' \code{update()} method installs outdated or missing packages from CRAN.
#'
#' @param pkg A character vector of package names. If missing, defaults to
#'   the name of the package in the current directory.
#' @param dependencies Which dependencies do you want to check?
#'   Can be a character vector (selecting from "Depends", "Imports",
#'    "LinkingTo", "Suggests", or "Enhances"), or a logical vector.
#'
#'   \code{TRUE} is shorthand for "Depends", "Imports", "LinkingTo" and
#'   "Suggests". \code{NA} is shorthand for "Depends", "Imports" and "LinkingTo"
#'   and is the default. \code{FALSE} is shorthand for no dependencies (i.e.
#'   just check this package, not its dependencies).
#' @param quiet If \code{TRUE}, suppress output.
#' @param upgrade If \code{TRUE}, also upgrade any of out date dependencies.
#' @param repos A character vector giving repositories to use.
#' @param type Type of package to \code{update}.  If "both", will switch
#'   automatically to "binary" to avoid interactive prompts during package
#'   installation.
#'
#' @param object A \code{package_deps} object.
#' @param force_deps whether to force installation of dependencies even if their
#'   SHA1 reference hasn't changed from the currently installed version.
#' @param ... Additional arguments passed to \code{install_packages}.
#'
#' @return
#'
#' A \code{data.frame} with columns:
#'
#' \tabular{ll}{
#' \code{package} \tab The dependent package's name,\cr
#' \code{installed} \tab The currently installed version,\cr
#' \code{available} \tab The version available on CRAN,\cr
#' \code{diff} \tab An integer denoting whether the locally installed version
#'   of the package is newer (1), the same (0) or older (-1) than the version
#'   currently available on CRAN.\cr
#' }
#'
#' @export
#' @examples
#' \dontrun{
#' package_deps("devtools")
#' # Use update to update any out-of-date dependencies
#' update(package_deps("devtools"))
#' }
package_deps <- function(pkg, dependencies = NA, repos = getOption("repos"),
                         type = getOption("pkgType")) {
  if (identical(type, "both")) {
    type <- "binary"
  }

  if (length(repos) == 0)
    repos <- character()

  repos[repos == "@CRAN@"] <- "http://cran.rstudio.com"
  cran <- available_packages(repos, type)

  if (missing(pkg)) {
    pkg <- as.package(".")$package
  }
  deps <- sort(find_deps(pkg, cran, top_dep = dependencies))

  # Remove base packages
  inst <- installed.packages()
  base <- unname(inst[inst[, "Priority"] %in% c("base", "recommended"), "Package"])
  deps <- setdiff(deps, base)

  inst_ver <- unname(inst[, "Version"][match(deps, rownames(inst))])
  cran_ver <- unname(cran[, "Version"][match(deps, rownames(cran))])
  diff <- compare_versions(inst_ver, cran_ver)

  structure(
    data.frame(
      package = deps,
      installed = inst_ver,
      available = cran_ver,
      diff = diff,
      stringsAsFactors = FALSE
    ),
    class = c("package_deps", "data.frame"),
    repos = repos,
    type = type
  )
}

#' @export
#' @rdname package_deps
dev_package_deps <- function(pkg = ".", dependencies = NA,
                             repos = getOption("repos"),
                             type = getOption("pkgType"),
                             force_deps = FALSE,
                             quiet = FALSE) {
  pkg <- as.package(pkg)
  install_dev_remotes(pkg, force = force_deps, quiet = quiet)

  repos <- c(repos, parse_additional_repositories(pkg))

  dependencies <- tolower(standardise_dep(dependencies))
  dependencies <- intersect(dependencies, names(pkg))

  parsed <- lapply(pkg[tolower(dependencies)], parse_deps)
  deps <- unlist(lapply(parsed, `[[`, "name"), use.names = FALSE)

  if (is_bioconductor(pkg)) {
    check_suggested("BiocInstaller")
    bioc_repos <- BiocInstaller::biocinstallRepos()

    missing_repos <- setdiff(names(bioc_repos), names(repos))

    if (length(missing_repos) > 0)
      repos[missing_repos] <- bioc_repos[missing_repos]
  }

  package_deps(deps, repos = repos, type = type)
}

## -2 = not installed, but available on CRAN
## -1 = installed, but out of date
##  0 = installed, most recent version
##  1 = installed, version ahead of CRAN
##  2 = package not on CRAN

UNINSTALLED <- -2L
BEHIND <- -1L
CURRENT <- 0L
AHEAD <- 1L
UNAVAILABLE <- 2L

compare_versions <- function(inst, cran) {
  stopifnot(length(inst) == length(cran))

  compare_var <- function(i, c) {
    if (is.na(c)) return(UNAVAILABLE)           # not on CRAN
    if (is.na(i)) return(UNINSTALLED)           # not installed, but on CRAN

    i <- package_version(i)
    c <- package_version(c)

    if (i < c) {
      BEHIND                               # out of date
    } else if (i > c) {
      AHEAD                                # ahead of CRAN
    } else {
      CURRENT                              # most recent CRAN version
    }
  }

  vapply(seq_along(inst),
    function(i) compare_var(inst[[i]], cran[[i]]),
    integer(1))
}

install_dev_remotes <- function(pkg, ..., quiet = FALSE) {
  pkg <- as.package(pkg)

  if (!has_dev_remotes(pkg)) {
    return()
  }

  types <- dev_remote_type(pkg[["remotes"]])

  lapply(types, function(type) type$fun(type$repository, ..., quiet = quiet))
}

# Parse the remotes field split into pieces and get install_ functions for each
# remote type
dev_remote_type <- function(remotes = "") {

  if (!nchar(remotes)) {
    return(NULL)
  }

  dev_packages <- trim_ws(unlist(strsplit(remotes, ",[[:space:]]*")))

  parse_one <- function(x) {
    pieces <- strsplit(x, "::", fixed = TRUE)[[1]]

    if (length(pieces) == 1) {
      type <- "github"
      repo <- pieces
    } else if (length(pieces) == 2) {
      type <- pieces[1]
      repo <- pieces[2]
    } else {
      stop("Malformed remote specification '", x, "'", call. = FALSE)
    }
    tryCatch(
      fun <- get(x = paste0("install_", tolower(type)),
        envir = asNamespace("devtools"),
        mode = "function",
        inherits = FALSE),
      error = function(e) {
        stop("Unknown remote type: ", type, call. = FALSE)
      })
    list(repository = repo, type = type, fun = fun)
  }

  lapply(dev_packages, parse_one)
}

has_dev_remotes <- function(pkg) {
  pkg <- as.package(pkg)

  !is.null(pkg[["remotes"]])
}


#' @export
print.package_deps <- function(x, show_ok = FALSE, ...) {
  class(x) <- "data.frame"

  ahead <- x$diff > CURRENT
  behind <- x$diff < CURRENT
  same_ver <- x$diff == CURRENT

  x$diff <- NULL
  x[] <- lapply(x, format)

  if (any(behind)) {
    cat("Needs update -----------------------------\n")
    print(x[behind, , drop = FALSE], row.names = FALSE, right = FALSE)
  }

  if (any(ahead)) {
    cat("Not on CRAN ----------------------------\n")
    print(x[ahead, , drop = FALSE], row.names = FALSE, right = FALSE)
  }

  if (show_ok && any(same_ver)) {
    cat("OK ---------------------------------------\n")
    print(x[same_ver, , drop = FALSE], row.names = FALSE, right = FALSE)
  }
}

#' @export
#' @rdname package_deps
#' @importFrom stats update
update.package_deps <- function(object, ..., quiet = FALSE, upgrade = TRUE) {
  unavailable <- object$package[object$diff == UNAVAILABLE]
  if (length(unavailable) > 0 && !quiet) {
    message(sprintf(ngettext(length(unavailable),
      "Skipping %d unavailable package: %s",
      "Skipping %d unavailable packages: %s"
    ), length(unavailable), paste(unavailable, collapse = ", ")))
  }

  ahead <- object$package[object$diff == AHEAD]
  if (length(ahead) > 0 && !quiet) {
    message(sprintf(ngettext(length(ahead),
      "Skipping %d package ahead of CRAN: %s",
      "Skipping %d packages ahead of CRAN: %s"
    ), length(ahead), paste(ahead, collapse = ", ")))
  }

  if (upgrade) {
    behind <- object$package[object$diff < CURRENT]
  } else {
    behind <- object$package[is.na(object$installed)]
  }
  if (length(behind) > 0L) {
    install_packages(behind, repos = attr(object, "repos"),
      type = attr(object, "type"), quiet = quiet, ...)
  }

}

install_packages <- function(pkgs, repos = getOption("repos"),
                             type = getOption("pkgType"), ...,
                             dependencies = FALSE, quiet = NULL) {
  if (identical(type, "both"))
    type <- "binary"
  if (is.null(quiet))
    quiet <- !identical(type, "source")

    message(sprintf(ngettext(length(pkgs),
      "Installing %d package: %s",
      "Installing %d packages: %s"
    ), length(pkgs), paste(pkgs, collapse = ", ")))

  # if type is 'source' and on windows add Rtools to the path this assumes
  # setup_rtools() has already run and set the rtools path
  if (type == "source" && !is.null(get_rtools_path())) {
    old <- add_path(get_rtools_path(), 0)
    on.exit(set_path(old))
  }
  utils::install.packages(pkgs, repos = repos, type = type,
    dependencies = dependencies, quiet = quiet)
}

find_deps <- function(pkgs, available = available.packages(), top_dep = TRUE,
                      rec_dep = NA, include_pkgs = TRUE) {
  if (length(pkgs) == 0 || identical(top_dep, FALSE))
    return(character())

  top_dep <- standardise_dep(top_dep)
  rec_dep <- standardise_dep(rec_dep)

  top <- tools::package_dependencies(pkgs, db = available, which = top_dep)
  top_flat <- unlist(top, use.names = FALSE)

  if (length(rec_dep) != 0 && length(top_flat) > 0) {
    rec <- tools::package_dependencies(top_flat, db = available, which = rec_dep,
      recursive = TRUE)
    rec_flat <- unlist(rec, use.names = FALSE)
  } else {
    rec_flat <- character()
  }

  unique(c(if (include_pkgs) pkgs, top_flat, rec_flat))
}

standardise_dep <- function(x) {
  if (identical(x, NA)) {
    c("Depends", "Imports", "LinkingTo")
  } else if (isTRUE(x)) {
    c("Depends", "Imports", "LinkingTo", "Suggests")
  } else if (identical(x, FALSE)) {
    character(0)
  } else if (is.character(x)) {
    x
  } else {
    stop("Dependencies must be a boolean or a character vector", call. = FALSE)
  }
}

#' Update packages that are missing or out-of-date.
#'
#' Works similarly to \code{install.packages()} but doesn't install packages
#' that are already installed, and also upgrades out dated dependencies.
#'
#' @param pkgs Character vector of packages to update.
#' @inheritParams package_deps
#' @seealso \code{\link{package_deps}} to see which packages are out of date/
#'   missing.
#' @export
#' @examples
#' \dontrun{
#' update_packages("ggplot2")
#' update_packages(c("plyr", "ggplot2"))
#' }
update_packages <- function(pkgs, dependencies = NA,
                            repos = getOption("repos"),
                            type = getOption("pkgType")) {
  pkgs <- package_deps(pkgs, repos = repos, type = type)
  update(pkgs)
}

has_additional_repositories <- function(pkg) {
  pkg <- as.package(pkg)

  "additional_repositories" %in% names(pkg)
}

parse_additional_repositories <- function(pkg) {
  pkg <- as.package(pkg)

  if (has_additional_repositories(pkg)) {
    strsplit(pkg[["additional_repositories"]], "[,[:space:]]+")[[1]]
  }
}
