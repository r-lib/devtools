load_depends <- function(pkg = ".") {
  pkg <- as.package(pkg)

  # Get data frame of dependency names and versions
  deps <- parse_deps(pkg$depends)
  if (is.null(deps) || nrow(deps) == 0) return(invisible())

  mapply(check_dep_version, deps$name, deps$version, deps$compare)
  lapply(deps$name, require, character.only = TRUE)

  invisible(deps)
}
