#' Find all dependencies of a package.
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
#' @param type Type of package to \code{update}.
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

compare_versions <- function(a, b) {
  stopifnot(length(a) == length(b))

  compare_var <- function(x, y) {
    if (is.na(x)) return(-2L)
    if (is.na(y)) return(2L)

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
  same_ver <- x$xidff == 0L

  x$diff <- NULL
  x[] <- lapply(x, format)

  if (any(behind)) {
    cat("Needs update -----------------------------\n")
    print(x[behind, , drop = FALSE], row.names = FALSE, right = FALSE)
  }

  if (any(ahead)) {
    cat("Ahead of CRAN ----------------------------\n")
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
    message("Skipping ", length(ahead), " dependencies ahead of CRAN: ",
      paste(ahead, collapse = ", "))
  }

  missing <- object$package[object$diff == 1L]
  if (length(missing) > 0 && !quiet) {
    message("Skipping ", length(missing), " dependencies ahead not on CRAN: ",
      paste(missing, collapse = ", "))
  }

  behind <- object$package[object$diff < 0L]
  if (length(behind) > 0L) {
    if (!quiet)
      message("Installing ", length(behind), " missing dependencies")
    install_packages(behind, attr(object, "repos"), attr(object, "type"),
      quiet = quiet)
  }

}

install_packages <- function(pkgs, repos, type, quiet = FALSE) {
  for (pkg in pkgs) {
    if (!quiet)
      message("Installing ", pkg)
    utils::install.packages(pkg, quiet = TRUE, repos = repos, type = type,
      dependencies = FALSE)
  }
  invisible()
}

find_deps <- function(pkgs, available = available.packages(), top_dep = TRUE, rec_dep = NA) {
  if (identical(top_dep, FALSE))
    return(pkgs)

  top_dep <- standardise_dep(top_dep)
  rec_dep <- standardise_dep(rec_dep)

  top <- tools::package_dependencies(pkgs, db = available, which = top_dep)
  top_flat <- unlist(top, use.names = FALSE)

  rec <- tools::package_dependencies(top_flat, db = available, which = rec_dep,
    recursive = TRUE)

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
