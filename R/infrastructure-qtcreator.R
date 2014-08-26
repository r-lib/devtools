#' @section \code{use_qtcreator}:
#' Adds an associated \code{.pro} file to the project, which QtCreator uses
#' to identify dependencies. With this, QtCreator will be able to provide
#' indexing and autocompletion support for C/C++ files within the `src/`
#' directory of a project. Packages within the \code{LinkingTo:} field containing
#' \code{include} directories are added and used for autocompletion support as well.
#' @export
#' @name infrastructure
#' @rdname infrastructure
#' @aliases add_rstudio_project
use_qtcreator <- function(pkg = ".") {
  pkg <- as.package(pkg)

  ## Path to the .pro file
  .pro.path <- file.path(pkg$path, paste0(basename(pkg$path), ".pro"))

  # Clobber the old .pro file if it exists
  if (file.exists(.pro.path)) unlink(.pro.path)

  ## Create QtCreator .pro file

  # Generate a generic header
  header <- qtcreator_header()

  # Get include paths for R as well as packages in LinkingTo
  linkingToPkgs <- pkg_linking_to(pkg)
  pkgIncludePaths <- Vectorize(system.file)("include", package = linkingToPkgs)

  notFound <- pkgIncludePaths == ""
  if (any(notFound)) {
    warning("The following packages specified in LinkingTo: were not found:\n- ",
            paste(shQuote(linkingToPkgs[notFound](), collapse = ", ")))
    pkgIncludePaths <- pkgIncludePaths[pkgIncludePaths != ""]
  }

  includepath <- c(
    R = R.home("include"),
    pkgIncludePaths,
    "$$PWD/inst/include"
  )

  ## Header globs
  headers <- c(
    "src/*.h",
    "src/*.hpp"
  )

  ## Source globs
  sources <- c(
    "src/*.c",
    "src/*.cpp"
  )

  ## Wrap it all up
  content <- c(
    header,
    "",
    "## R includes (call devtools::use_qtcreator() to update)",
    paste("INCLUDEPATH +=", includepath),
    "",
    paste("HEADERS +=", headers),
    "",
    paste("SOURCES +=", sources)
  )

  message("Adding QtCreator project file to ", pkg$package)
  cat(content, file = .pro.path, sep = "\n")

  add_build_ignore(pkg, "*.pro")
  add_build_ignore(pkg, "*.pro.user")

  if (file.exists(file.path(pkg$path, ".gitignore"))) {
    add_git_ignore(pkg, "*.pro.user")
  }

  invisible(TRUE)
}

qtcreator_header <- function() {
  c(
    "TEMPLATE = app",
    "CONFIG += console",
    "CONFIG -= app_bundle",
    "CONFIG -= qt"
  )
}
