
check_deps <- function(pkg = ".", repos = getOption("repos"),
                       type = getOption("pkgType")) {
  pkg <- as.package(pkg)

  cran <- available_packages(repos, type)
  deps <- sort(find_deps(pkg$package, cran))

  # Install if out of date or not already installed
  inst <- installed.packages()
  inst_ver <- setNames(inst[, "Version"], inst[, "Package"])
  cran_ver <- setNames(cran[, "Version"], cran[, "Package"])

  # Remove base packages
  base <- unname(inst[inst[, "Priority"] %in% c("base", "recommended"), "Package"])
  deps <- setdiff(deps, base)

  # Needs install
  old <- old.packages(repos = repos, type = type, available = cran)
  to_install <- sort(union(
    intersect(deps, old),
    setdiff(deps, inst)
  ))

  structure(data.frame(
    package = deps,
    installed = unname(inst_ver[deps]),
    available = unname(cran_ver[deps]),
    needed = deps %in% to_install,
    stringsAsFactors = FALSE
  ), class = c("package_deps", "data.frame"))
}

print.package_deps <- function(x, show_ok = TRUE, ...) {
  class(x) <- "data.frame"

  same_ver <- x$installed == x$available
  same_ver[is.na(same_ver)] <- FALSE

  behind <- !same_ver & x$needed
  ahead <- !same_ver & !x$needed

  x[] <- lapply(x, format)
  x$needed <- NULL

  cat("Needs update -----------------------------\n")
  print(x[behind, , drop = FALSE], row.names = FALSE, right = FALSE)
  cat("Ahead of CRAN ----------------------------\n")
  print(x[ahead, , drop = FALSE], row.names = FALSE, right = FALSE)

  if (show_ok) {
    cat("OK ---------------------------------------\n")
    print(x[same_ver, , drop = FALSE], row.names = FALSE, right = FALSE)
  }
}

find_deps <- function(pkgs, available,
                      top_dep = c("Depends", "Imports", "LinkingTo", "Suggests"),
                      rec_dep = c("Depends", "Imports")) {
  top <- tools::package_dependencies(pkgs, db = available, which = top_dep)
  rec <- tools::package_dependencies(top, db = available, which = rec_dep,
    recursive = TRUE)

  unique(unlist(c(top, rec)))
}
