copy_vignettes <- function(pkg, keep_md) {
  pkg <- as.package(pkg)

  usethis_use_directory(pkg, "doc", ignore = TRUE)
  usethis_use_git_ignore(pkg, "/doc/")

  doc_dir <- path(pkg$path, "doc")

  vignettes <- tools::pkgVignettes(dir = pkg$path, output = TRUE, source = TRUE)
  if (length(vignettes$docs) == 0) {
    return(invisible())
  }

  md_outputs <- character()
  if (isTRUE(keep_md)) {
    md_outputs <- dir_ls(path = vignettes$dir, regexp = "[.]md$")
  }

  out_mv <- unique(c(
    md_outputs,
    vignettes$outputs,
    unlist(vignettes$sources, use.names = FALSE)
  ))
  out_cp <- vignettes$docs

  cli::cli_inform(c(i = "Moving {.file {path_file(out_mv)}} to {.path doc/}"))
  file_copy(out_mv, doc_dir, overwrite = TRUE)
  file_delete(out_mv)

  cli::cli_inform(c(i = "Copying {.file {path_file(out_cp)}} to {.path doc/}"))
  file_copy(out_cp, doc_dir, overwrite = TRUE)

  # Copy extra files, if needed
  extra_files <- find_vignette_extras(pkg)
  if (length(extra_files) == 0) {
    return(invisible())
  }

  cli::cli_inform(c(i = "Copying extra files {.file {path_file(extra_files)}} to {.path doc/}"))
  file_copy(extra_files, doc_dir)

  invisible()
}

find_vignette_extras <- function(pkg = ".") {
  pkg <- as.package(pkg)

  vig_path <- path(pkg$path, "vignettes")
  extras_file <- path(vig_path, ".install_extras")
  if (!file_exists(extras_file)) {
    return(character())
  }

  extras <- readLines(extras_file, warn = FALSE)

  if (length(extras) == 0) {
    return(character())
  }

  all_files <- path_rel(dir_ls(vig_path, all = TRUE), vig_path)

  re <- paste0(extras, collapse = "|")
  files <- grep(re, all_files, perl = TRUE, ignore.case = TRUE, value = TRUE)

  path_real(path(vig_path, files))
}
