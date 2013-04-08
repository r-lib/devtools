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

#' @importFrom tools pkgVignettes
copy_vignettes <- function(pkg) {
  pkg <- as.package(pkg)

  doc_dir <- file.path(pkg$path, "inst", "doc")
  if (!file.exists(doc_dir)) {
    dir.create(doc_dir, recursive = TRUE, showWarnings = FALSE)
  }

  vigns <- pkgVignettes(dir = pkg$path, output = TRUE, source = TRUE)
  if (length(vigns$docs) == 0) return(invisible())

  out_mv <- c(vigns$outputs, unlist(vigns$sources, use.names = FALSE))
  out_cp <- vigns$docs

  message("Moving ", paste(basename(out_mv), collapse = ", "), " to inst/doc/")
  file.copy(out_mv, doc_dir)
  file.remove(out_mv)

  message("Copy ", paste(basename(out_cp), collapse = ", "), " to inst/doc/")
  file.copy(out_cp, doc_dir)

  # Copy extra files, if needed
  extra_files <- find_vignette_extras(pkg)
  if (length(extra_files) == 0) return(invisible())

  message("Copying extra files ", paste(basename(extra_files), collapse = ", "),
    " to inst/doc/")
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

  in_dir(vig_path, {
    allfiles <- dir(all.files = TRUE, full.names = TRUE, recursive = TRUE,
      include.dirs = TRUE)
  })

  inst <- rep(FALSE, length(allfiles))
  for (e in extras) {
    inst <- inst | grepl(e, allfiles, perl = TRUE, ignore.case = TRUE)
  }

  normalizePath(file.path(vig_path, allfiles[inst]))
}
