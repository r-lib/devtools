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

  package <- vapply(remote, remote_package_name, character(1))
  installed <- vapply(package, local_sha, character(1))
  available <- vapply(remote, remote_sha, character(1))
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

#' @export
`[.remotes` <- function(x,i,...) {
  r <- NextMethod("[")
  mostattributes(r) <- attributes(x)
  r
}
