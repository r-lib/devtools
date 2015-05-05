#' Find all dependencies of a CRAN or dev package.
#'
#' Find all the dependencies of a package and determine whether they ahead
#' or behind cran. A \code{print()} method focusses on mismatches between local
#' and CRAN version; a \code{update()} method installs outdated or missing
#' packages from CRAN.
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
#' @param quiet If \code{TRUE}, supress output
#' @param repos A character vector giving repositories to use.
#' @param type Type of package to \code{update}.  If "both", will switch
#'   automatically to "binary" to avoid interactive prompts during package
#'   installation.
#' @param object,... Arguments ot
#' @return A data frame with additional.
#' @export
#' @examples
#' \dontrun{
#' package_deps("devtools")
#' # Use update to update any updated/
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
                             type = getOption("pkgType")) {
  pkg <- as.package(pkg)

  dependencies <- tolower(standardise_dep(dependencies))
  dependencies <- intersect(dependencies, names(pkg))

  parsed <- lapply(pkg[tolower(dependencies)], parse_deps)
  deps <- unlist(lapply(parsed, `[[`, "name"), use.names = FALSE)

  package_deps(deps, repos = repos, type = type)
}

compare_versions <- function(a, b) {
  stopifnot(length(a) == length(b))

  compare_var <- function(x, y) {
    if (is.na(y)) return(2L)
    if (is.na(x)) return(-2L)

    x <- package_version(x)
    y <- package_version(y)

    if (x < y) {
      -1L
    } else if (x > y) {
      1L
    } else {
      0L
    }
  }

  vapply(seq_along(a), function(i) compare_var(a[[i]], b[[i]]), integer(1))
}

#' @export
print.package_deps <- function(x, show_ok = FALSE, ...) {
  class(x) <- "data.frame"

  ahead <- x$diff > 0L
  behind <- x$diff < 0L
  same_ver <- x$diff == 0L

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
update.package_deps <- function(object, ..., quiet = FALSE) {
  ahead <- object$package[object$diff == 2L]
  if (length(ahead) > 0 && !quiet) {
    message("Skipping ", length(ahead), " packages not available: ",
      paste(ahead, collapse = ", "))
  }

  missing <- object$package[object$diff == 1L]
  if (length(missing) > 0 && !quiet) {
    message("Skipping ", length(missing), " packages ahead of CRAN: ",
      paste(missing, collapse = ", "))
  }

  behind <- object$package[object$diff < 0L]
  if (length(behind) > 0L)
    install_packages(behind, attr(object, "repos"), attr(object, "type"), ...)

}

install_packages <- function(pkgs, repos = getOption("repos"),
                             type = getOption("pkgType"), ...,
                             dependencies = FALSE, quiet = NULL) {
  if (identical(type, "both"))
    type <- "binary"
  if (is.null(quiet))
    quiet <- !identical(type, "source")

  message("Installing ", length(pkgs), " packages: ",
    paste(pkgs, collapse = ", "))
  utils::install.packages(pkgs, repos = repos, type = type, ...,
    dependencies = dependencies, quiet = quiet)
}

find_deps <- function(pkgs, available = available.packages(), top_dep = TRUE, rec_dep = NA) {
  if (length(pkgs) == 0 || identical(top_dep, FALSE))
    return(character())

  top_dep <- standardise_dep(top_dep)
  rec_dep <- standardise_dep(rec_dep)

  top <- tools::package_dependencies(pkgs, db = available, which = top_dep)
  top_flat <- unlist(top, use.names = FALSE)

  if (length(rec_dep) != 0 && length(top_flat) > 0) {
    rec <- tools::package_dependencies(top_flat, db = available, which = rec_dep,
      recursive = TRUE)
  } else {
    rec <- character()
  }

  unique(unlist(c(pkgs, top, rec), use.names = FALSE))
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
