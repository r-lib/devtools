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
#' @param type Type of package to \code{update}.
#' @param object A \code{package_deps} object.
#' @param bioconductor Install Bioconductor dependencies if the package has a
#' BiocViews field in the DESCRIPTION.
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

  if (length(repos) == 0)
    repos <- character()

  repos[repos == "@CRAN@"] <- cran_mirror()

  if (missing(pkg)) {
    pkg <- as.package(".")$package
  }

  # It is important to not extract available_packages() to a variable,
  # for the case when pkg is empty (e.g., install(dependencies = FALSE) ).
  deps <- sort_ci(find_deps(pkg, available_packages(repos, type), top_dep = dependencies))

  # Remove base packages
  inst <- installed.packages()
  base <- unname(inst[inst[, "Priority"] %in% c("base", "recommended"), "Package"])
  deps <- setdiff(deps, base)

  # get remote types
  remote <- structure(lapply(deps, package2remote, repos = repos, type = type), class = "remotes")

  inst_ver <- vapply(deps, local_sha, character(1))
  cran_ver <- vapply(remote, remote_sha, character(1))

  cran_remote <- vapply(remote, inherits, logical(1), "cran_remote")
  diff <- compare_versions(inst_ver, cran_ver, cran_remote)

  res <- structure(
    data.frame(
      package = deps,
      installed = inst_ver,
      available = cran_ver,
      diff = diff,
      stringsAsFactors = FALSE
    ),
    class = c("package_deps", "data.frame")
  )
  res$remote <- remote

  res
}

#' @export
#' @rdname package_deps
dev_package_deps <- function(pkg = ".", dependencies = NA,
                             repos = getOption("repos"),
                             type = getOption("pkgType"),
                             bioconductor = TRUE) {
  pkg <- as.package(pkg)

  repos <- c(repos, parse_additional_repositories(pkg))

  dependencies <- tolower(standardise_dep(dependencies))
  dependencies <- intersect(dependencies, names(pkg))

  parsed <- lapply(pkg[tolower(dependencies)], parse_deps)
  deps <- unlist(lapply(parsed, `[[`, "name"), use.names = FALSE)

  if (isTRUE(bioconductor) && is_bioconductor(pkg)) {
    check_bioconductor()
    bioc_repos <- BiocInstaller::biocinstallRepos()

    missing_repos <- setdiff(names(bioc_repos), names(repos))

    if (length(missing_repos) > 0)
      repos[missing_repos] <- bioc_repos[missing_repos]
  }

  filter_duplicate_deps(
    package_deps(deps, repos = repos, type = type),

    # We set this cache in install() so we can run install_deps() twice without
    # having to re-query the remotes
    installing$remote_deps %||% remote_deps(pkg))
}

filter_duplicate_deps <- function(cran_deps, remote_deps, dependencies) {
  deps <- rbind(cran_deps, remote_deps)

  # Only keep the remotes that are specified in the cran_deps
  # Keep only the Non-CRAN remotes if there are duplicates as we want to install
  # the development version rather than the CRAN version. The remotes will
  # always be specified after the CRAN dependencies, so using fromLast will
  # filter out the CRAN dependencies.
  deps[!duplicated(deps$package, fromLast = TRUE), ]
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

compare_versions <- function(inst, remote, is_cran) {
  stopifnot(length(inst) == length(remote) && length(inst) == length(is_cran))

  compare_var <- function(i, c, cran) {
    if (!cran) {
      if (identical(i, c)) {
        return(CURRENT)
      } else {
        return(BEHIND)
      }
    }
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
    function(i) compare_var(inst[[i]], remote[[i]], is_cran[[i]]),
    integer(1))
}

parse_one_remote <- function(x) {
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
  fun <- tryCatch(get(paste0(tolower(type), "_remote"),
      envir = asNamespace("devtools"), mode = "function", inherits = FALSE),
    error = function(e) stop("Unknown remote type: ", type, call. = FALSE))

  fun(repo)
}

split_remotes <- function(x) {
  trim_ws(unlist(strsplit(x, ",[[:space:]]*")))
}

remote_deps <- function(pkg) {
  pkg <- as.package(pkg)

  if (!has_dev_remotes(pkg)) {
    return(NULL)
  }

  dev_packages <- split_remotes(pkg[["remotes"]])
  remote <- lapply(dev_packages, parse_one_remote)

  package <- vapply(remote, remote_package_name, character(1), USE.NAMES = FALSE)
  installed <- vapply(package, local_sha, character(1), USE.NAMES = FALSE)
  available <- vapply(remote, remote_sha, character(1), USE.NAMES = FALSE)
  diff <- installed == available
  diff <- ifelse(!is.na(diff) & diff, CURRENT, BEHIND)

  res <- structure(
    data.frame(
      package = package,
      installed = installed,
      available = available,
      diff = diff,
      stringsAsFactors = FALSE
      ),
    class = c("package_deps", "data.frame"))
  res$remote <- structure(remote, class = "remotes")

  res
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
  non_cran <- !vapply(object$remote, inherits, logical(1), "cran_remote")
  unavailable <- object$diff == UNAVAILABLE & non_cran
  if (any(unavailable)) {
    if (upgrade) {
      install_remotes(object$remote[unavailable], ..., quiet = quiet)
    } else if (!quiet) {
      message(sprintf(ngettext(sum(unavailable),
            "Skipping %d unavailable package: %s",
            "Skipping %d unavailable packages: %s"
            ), sum(unavailable), paste(object$package[unavailable], collapse = ", ")))
    }
  }

  ahead <- object$diff == AHEAD & non_cran
  if (any(ahead)) {
    if (upgrade) {
      install_remotes(object$remote[ahead], ..., quiet = quiet)
    } else if (!quiet) {
      message(sprintf(ngettext(sum(ahead),
            "Skipping %d package ahead of CRAN: %s",
            "Skipping %d packages ahead of CRAN: %s"
            ), sum(ahead), paste(object$package[ahead], collapse = ", ")))
    }
  }

  if (upgrade) {
    behind <- object$diff < CURRENT
  } else {
    behind <- is.na(object$installed)
  }

  install_remotes(object$remote[behind], ..., quiet = quiet)
}

install_packages <- function(pkgs, repos = getOption("repos"),
                             type = getOption("pkgType"), ...,
                             dependencies = FALSE, quiet = NULL) {
  if (is.null(quiet))
    quiet <- !identical(type, "source")

    message(sprintf(ngettext(length(pkgs),
      "Installing %d package: %s",
      "Installing %d packages: %s"
    ), length(pkgs), paste(pkgs, collapse = ", ")))

  pkgbuild::with_build_tools(
    withr::with_options("install.packages.compile.from.source" = "never",
      utils::install.packages(pkgs, repos = repos, type = type,
        dependencies = dependencies, quiet = quiet
      )
    ),
    required = FALSE
  )
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
#' @param pkgs Character vector of packages to update. IF \code{TRUE} all
#'   installed packages are updated. If \code{NULL} user is prompted to
#'   confirm update of all installed packages.
#' @inheritParams package_deps
#' @seealso \code{\link{package_deps}} to see which packages are out of date/
#'   missing.
#' @export
#' @examples
#' \dontrun{
#' update_packages("ggplot2")
#' update_packages(c("plyr", "ggplot2"))
#' }
update_packages <- function(pkgs = NULL, dependencies = NA,
                            repos = getOption("repos"),
                            type = getOption("pkgType")) {

  if (isTRUE(pkgs)) {
    pkgs <- installed.packages()[, "Package"]
  }
  else if (is.null(pkgs)) {
    if (!yesno("Are you sure you want to update all installed packages?")) {
      pkgs <- installed.packages()[, "Package"]
    } else {
      return(invisible())
    }
  }

  pkgs <- package_deps(pkgs,
    dependencies = dependencies,
    repos = repos,
    type = type)

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

#' @export
`[.remotes` <- function(x,i,...) {
  r <- NextMethod("[")
  mostattributes(r) <- attributes(x)
  r
}
