
package_deps <- function(pkg, dependencies = NA, repos = getOption("repos"),
                         type = getOption("pkgType")) {
  cran <- available_packages(repos, type)

  if (missing(pkg)) {
    pkg <- as.package(".")$package
  }
  deps <- sort(find_deps(pkg, cran))

  # Remove base packages
  inst <- installed.packages()
  base <- unname(inst[inst[, "Priority"] %in% c("base", "recommended"), "Package"])
  deps <- setdiff(deps, base)

  inst_ver <- unname(inst[, "Version"][match(deps, rownames(inst))])
  cran_ver <- unname(cran[, "Version"][match(deps, rownames(cran))])
  diff <- compare_versions(inst_ver, cran_ver)

  structure(data.frame(
    package = deps,
    installed = inst_ver,
    available = cran_ver,
    diff = diff,
    stringsAsFactors = FALSE
  ), class = c("package_deps", "data.frame"))
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

find_deps <- function(pkgs, available, top_dep = TRUE, rec_dep = NA) {
  top_dep <- standardise_dep(top_dep)
  rec_dep <- standardise_dep(rec_dep)

  top <- tools::package_dependencies(pkgs, db = available, which = top_dep)
  top_flat <- unlist(top, use.names = FALSE)

  rec <- tools::package_dependencies(top_flat, db = available, which = rec_dep,
    recursive = TRUE)

  unique(unlist(c(top, rec), use.names = FALSE))
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
