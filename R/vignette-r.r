#  Modified from src/library/tools/R/build.R
#
#  Copyright (C) 1995-2013 The R Core Team
#  Copyright (C) 2013 Hadley Wickham
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/

copy_vignettes <- function(pkg, keep_md) {
  pkg <- as.package(pkg)

  usethis_use_directory(pkg, "doc", ignore = TRUE)
  usethis_use_git_ignore(pkg, "doc")

  doc_dir <- file.path(pkg$path, "doc")

  vigns <- tools::pkgVignettes(dir = pkg$path, output = TRUE, source = TRUE)
  if (length(vigns$docs) == 0) return(invisible())

  md_outputs <- character()
  if (isTRUE(keep_md)) {
    md_outputs <- list.files(path = vigns$dir, pattern = "[.]md$", full.names = TRUE)
  }

  out_mv <- c(md_outputs, vigns$outputs, unique(unlist(vigns$sources, use.names = FALSE)))
  out_cp <- vigns$docs

  message("Moving ", paste(basename(out_mv), collapse = ", "), " to doc/")
  file.copy(out_mv, doc_dir, overwrite = TRUE)
  file.remove(out_mv)

  message("Copying ", paste(basename(out_cp), collapse = ", "), " to doc/")
  file.copy(out_cp, doc_dir, overwrite = TRUE)

  # Copy extra files, if needed
  extra_files <- find_vignette_extras(pkg)
  if (length(extra_files) == 0) return(invisible())

  message(
    "Copying extra files ", paste(basename(extra_files), collapse = ", "),
    " to doc/"
  )
  file.copy(extra_files, doc_dir, recursive = TRUE)

  invisible()
}

find_vignette_extras <- function(pkg = ".") {
  pkg <- as.package(pkg)

  vig_path <- file.path(pkg$path, "vignettes")
  extras_file <- file.path(vig_path, ".install_extras")
  if (!file.exists(extras_file)) return(character())
  extras <- readLines(extras_file, warn = FALSE)
  if (length(extras) == 0) return(character())

  withr::with_dir(vig_path, {
    allfiles <- dir(
      all.files = TRUE, full.names = TRUE, recursive = TRUE,
      include.dirs = TRUE
    )
  })

  inst <- rep(FALSE, length(allfiles))
  for (e in extras) {
    inst <- inst | grepl(e, allfiles, perl = TRUE, ignore.case = TRUE)
  }

  normalizePath(file.path(vig_path, allfiles[inst]))
}
