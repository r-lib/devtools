#' Build package vignettes.
#'
#' Builds package vignettes using the same algorithm that `R CMD build`
#' does. This means including non-Sweave vignettes, using makefiles (if
#' present), and copying over extra files. The files are copied in the 'doc'
#' directory and an vignette index is created in 'Meta/vignette.rds', as they
#' would be in a built package. 'doc' and 'Meta' are added to
#' `.Rbuildignore`, so will not be included in the built package. These
#' files can be checked into version control, so they can be viewed with
#' `browseVignettes()` and `vignette()` if the package has been
#' loaded with `load_all()` without needing to re-build them locally.
#'
#' @template devtools
#' @param quiet If `TRUE`, suppresses most output. Set to `FALSE`
#'   if you need to debug.
#' @param install If `TRUE`, install the package before building
#'   vignettes.
#' @param keep_md If `TRUE`, move md intermediates as well as rendered
#'   outputs. Most useful when using the `keep_md` YAML option for Rmarkdown
#'   outputs. See
#'   <https://bookdown.org/yihui/rmarkdown/html-document.html#keeping-markdown>.
#' @inheritParams tools::buildVignettes
#' @inheritParams remotes::install_deps
#' @importFrom stats update
#' @keywords programming
#' @seealso [clean_vignettes()] to remove the pdfs in
#'   \file{doc} created from vignettes
#' @export
#' @seealso [clean_vignettes()] to remove build tex/pdf files.
build_vignettes <- function(pkg = ".",
                            dependencies = "VignetteBuilder",
                            clean = TRUE,
                            upgrade = "never",
                            quiet = FALSE,
                            install = TRUE,
                            keep_md = TRUE) {
  pkg <- as.package(pkg)
  save_all()

  vigns <- tools::pkgVignettes(dir = pkg$path)
  if (length(vigns$docs) == 0) return()

  deps <- remotes::dev_package_deps(pkg$path, dependencies)
  update(deps, upgrade = upgrade)

  if (isTRUE(install)) {
    local_install(pkg, quiet = TRUE)
  }

  cli::cli_inform(c(i = "Building vignettes for {.pkg {pkg$package}}"))
  callr::r(
    function(...) tools::buildVignettes(...),
    args = list(
      dir = pkg$path,
      clean = clean,
      tangle = TRUE,
      quiet = quiet
    ),
    show = !quiet,
    spinner = FALSE
  )

  # We need to re-run pkgVignettes now that they are built to get the output
  # files as well
  cli::cli_inform(c(i = "Copying vignettes"))
  vigns <- tools::pkgVignettes(dir = pkg$path, source = TRUE, output = TRUE)
  copy_vignettes(pkg, keep_md)
  create_vignette_index(pkg, vigns)

  invisible(TRUE)
}

create_vignette_index <- function(pkg, vigns) {
  cli::cli_inform(c(i = "Building vignette index"))

  usethis_use_directory(pkg, "Meta", ignore = TRUE)
  usethis_use_git_ignore(pkg, "/Meta/")

  vignette_index <- ("tools" %:::% ".build_vignette_index")(vigns)
  vignette_index_path <- path(pkg$path, "Meta", "vignette.rds")

  saveRDS(vignette_index, vignette_index_path, version = 2L)
}

#' Clean built vignettes.
#'
#' This uses a fairly rudimentary algorithm where any files in \file{doc}
#' with a name that exists in \file{vignettes} are removed.
#'
#' @template devtools
#' @export
clean_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  vigns <- tools::pkgVignettes(dir = pkg$path)
  if (path_file(vigns$dir) != "vignettes") return()

  cli::cli_inform(c(i = "Cleaning built vignettes and index from {.pkg {pkg$package}}"))

  doc_path <- path(pkg$path, "doc")

  vig_candidates <- if (dir_exists(doc_path)) dir_ls(doc_path) else character()
  vig_rm <- vig_candidates[file_name(vig_candidates) %in% file_name(vigns$docs)]

  extra_candidates <- path(doc_path, path_file(find_vignette_extras(pkg)))
  extra_rm <- extra_candidates[file_exists(extra_candidates)]

  meta_path <- path(pkg$path, "Meta")
  vig_index_path <- path(meta_path, "vignette.rds")
  vig_index_rm <- if (file_exists(vig_index_path)) vig_index_path

  to_remove <- c(vig_rm, extra_rm, vig_index_rm)
  if (length(to_remove) > 0) {
    cli::cli_inform(c(x = "Removing {.file {path_file(to_remove)}}"))
    file_delete(to_remove)
  }

  lapply(c(doc_path, meta_path), dir_delete_if_empty)

  invisible(TRUE)
}

dir_delete_if_empty <- function(x) {
  if (dir_exists(x) && rlang::is_empty(dir_ls(x))) {
    dir_delete(x)
    cli::cli_inform(c(x = "Removing {.file {path_file(x)}}"))
  }
}

file_name <- function(x) {
  if (length(x) == 0) return(NULL)
  path_ext_remove(path_file(x))
}
