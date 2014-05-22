#' Add test skeleton.
#'
#' Add testing infrastructure to a package that does not already have it.
#' This will create \file{tests/testthat.R}, \file{tests/testthat/} and
#' add \pkg{testthat} to the suggested packages. This is called
#' automatically from \code{\link{test}} if needed.
#'
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information.
#' @export
add_test_infrastructure <- function(pkg = ".") {
  pkg <- as.package(pkg)

  check_testthat()
  if (uses_testthat(pkg)) {
    stop("Package already has testing infrastructure", call. = FALSE)
  }

  # Create tests/testthat and install file for R CMD CHECK
  dir.create(file.path(pkg$path, "tests", "testthat"),
    showWarnings = FALSE, recursive = TRUE)
  writeLines(render_template("testthat.R", list(name = pkg$package)),
    file.path(pkg$path, "tests", "testthat.R"))

  add_suggested_package(file.path(pkg$path, "DESCRIPTION"), "testthat")

  invisible(TRUE)
}

#' Add Rstudio project to a package.
#'
#' Does not modify \code{.Rbuildignore} as Rstudio will do that when
#' opened for the first time.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
add_rstudio_project <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, paste0(pkg$package, ".Rproj"))
  if (file.exists(path)) {
    stop(pkg$package, ".Rproj already exists", call. = FALSE)
  }
  message("Adding Rstudio project file to ", pkg$package)

  template_path <- system.file("templates/template.Rproj", package = "devtools")
  file.copy(template_path, path)

  add_build_ignore(pkg, ".travis.yml")

  invisible(TRUE)
}



add_suggested_package <- function(path, name) {
  desc <- as.list(read.dcf(path)[1, ])
  suggests <- desc$Suggests
  if (is.null(suggests)) {
    suggests <- name
    changed <- TRUE
  } else {
    if (!grepl(name, suggests)) {
      suggests <- paste0(suggests, ",\n  ", name)
      changed <- TRUE
    } else {
      changed <- FALSE
    }
  }
  if (changed) {
    desc$Suggests <- suggests
    write.dcf(desc, path, keep.white = names(desc))
  }
  invisible(changed)
}
