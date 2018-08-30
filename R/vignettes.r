#' Build package vignettes.
#'
#' Builds package vignettes using the same algorithm that \code{R CMD build}
#' does. This means including non-Sweave vignettes, using makefiles (if
#' present), and copying over extra files. The files are copied in the 'doc'
#' directory and an vignette index is created in 'Meta/vignette.rds', as they
#' would be in a built package. 'doc' and 'Meta' are added to
#' \code{.Rbuildignore}, so will not be included in the built package. These
#' files can be checked into version control, so they can be viewed with
#' \code{browseVignettes()} and \code{vignette()} if the package has been
#' loaded with \code{load_all()} without needing to re-build them locally.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param quiet If \code{TRUE}, suppresses most output. Set to \code{FALSE}
#'   if you need to debug.
#' @param install If \code{TRUE}, install the package before building
#'   vignettes.
#' @param keep_md If \code{TRUE}, move md intermediates as well as rendered
#'   outputs. Most useful when using the `keep_md` YAML option for Rmarkdown
#'   outputs. See
#'   \url{https://bookdown.org/yihui/rmarkdown/html-document.html#keeping-markdown}.
#' @inheritParams tools::buildVignettes
#' @inheritParams remotes::install_deps
#' @keywords programming
#' @seealso \code{\link{clean_vignettes}} to remove the pdfs in
#'   \file{doc} created from vignettes
#' @export
#' @seealso \code{\link{clean_vignettes}} to remove build tex/pdf files.
build_vignettes <- function(pkg = ".",
                            dependencies = "VignetteBuilder",
                            clean = TRUE,
                            upgrade = TRUE,
                            quiet = TRUE,
                            install = TRUE,
                            keep_md = TRUE
                            ) {
  pkg <- as.package(pkg)
  vigns <- tools::pkgVignettes(dir = pkg$path)
  if (length(vigns$docs) == 0) return()

  install_deps(pkg$path, dependencies, upgrade = upgrade)

  message("Building ", pkg$package, " vignettes")

  if (isTRUE(install)) {
    build <- function(pkg_path, clean, quiet, upgrade) {
      withr::with_temp_libpaths(action = "prefix", {
        devtools::install(pkg_path, upgrade_dependencies = upgrade, reload = FALSE, quiet = quiet)
        tools::buildVignettes(dir = pkg_path, clean = clean, tangle = TRUE, quiet = quiet)
                            })
    }
  } else {
    build <- function(pkg_path, clean, quiet, upgrade) {
      tools::buildVignettes(dir = pkg_path, clean = clean, tangle = TRUE, quiet = quiet)
    }
  }

  callr::r(
    build,
    args = list(pkg_path = pkg$path, clean = clean, upgrade = upgrade, quiet = quiet),
    show = TRUE,
    spinner = FALSE)

  # We need to re-run pkgVignettes now that they are built to get the output
  # files as well
  vigns <- tools::pkgVignettes(dir = pkg$path, source = TRUE, output = TRUE)

  copy_vignettes(pkg, keep_md)

  create_vignette_index(pkg, vigns)

  invisible(TRUE)
}

create_vignette_index <- function(pkg, vigns) {

  usethis_use_directory(pkg, "Meta", ignore = TRUE)
  usethis_use_git_ignore(pkg, "Meta")

  message("Building vignette index")

  vignette_index <- ("tools" %:::% ".build_vignette_index")(vigns)

  vignette_index_path <- file.path(pkg$path, "Meta", "vignette.rds")

  saveRDS(vignette_index, vignette_index_path, version = 2L)
}

#' Clean built vignettes.
#'
#' This uses a fairly rudimentary algorithm where any files in \file{doc}
#' with a name that exists in \file{vignettes} are removed.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
clean_vignettes <- function(pkg = ".") {
  pkg <- as.package(pkg)
  vigns <- tools::pkgVignettes(dir = pkg$path)
  if (basename(vigns$dir) != "vignettes") return()

  message("Cleaning built vignettes and index from ", pkg$package)

  doc_path <- file.path(pkg$path, "doc")

  vig_candidates <- dir(doc_path, full.names = TRUE)
  vig_rm <- vig_candidates[file_name(vig_candidates) %in% file_name(vigns$docs)]

  extra_candidates <- file.path(doc_path, basename(find_vignette_extras(pkg)))
  extra_rm <- extra_candidates[file.exists(extra_candidates)]

  vig_index_path <- file.path(pkg$path, "Meta", "vignette.rds")
  vig_index_rm <- if (file.exists(vig_index_path)) vig_index_path

  to_remove <- c(vig_rm, extra_rm, vig_index_rm)
  if (length(to_remove) > 0) {
    message("Removing ", paste(basename(to_remove), collapse = ", "))
    file.remove(to_remove)
  }

  invisible(TRUE)
}

ext_variations <- function(path, valid_ext) {
  unique(c(outer(file_name(path), valid_ext, FUN = paste, sep = ".")))
}

file_name <- function(x) {
  if (length(x) == 0) return(NULL)
  tools::file_path_sans_ext(basename(x))
}
