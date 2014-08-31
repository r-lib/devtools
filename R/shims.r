# Insert shim objects into a package's imports environment
#
# @param pkg A path or package object
insert_imports_shims <- function(pkg = ".") {
  pkg <- as.package(pkg)

  imp_env <- imports_env(pkg)
  imp_env$system.file <- shim_system.file
  imp_env$library.dynam.unload <- shim_library.dynam.unload
}

# Create a new environment as the parent of global, with devtools versions of
# help, ?, and system.file.
insert_global_shims <- function() {
  # If shims already present, just return
  if ("devtools_shims" %in% search()) return()

  e <- new.env()

  e$help <- shim_help
  e$`?` <- shim_question
  e$system.file <- shim_system.file

  attach(e, name = "devtools_shims", warn.conflicts = FALSE)
}

#' Replacement version of system.file
#'
#' This function is meant to intercept calls to \code{\link[base]{system.file}},
#' so that it behaves well with packages loaded by devtools. It is made
#' available when a package is loaded with \code{\link{load_all}}.
#'
#' When \code{system.file} is called from the R console (the global
#' envrironment), this function detects if the target package was loaded with
#' \code{\link{load_all}}, and if so, it uses a customized method of searching
#' for the file. This is necessary because the directory structure of a source
#' package is different from the directory structure of an installed package.
#'
#' When a package is loaded with \code{load_all}, this function is also inserted
#' into the package's imports environment, so that calls to \code{system.file}
#' from within the package namespace will use this modified version. If this
#' function were not inserted into the imports environment, then the package
#' would end up calling \code{base::system.file} instead.
#' @inheritParams base::system.file
#'
#' @usage # system.file(..., package = "base", lib.loc = NULL, mustWork = FALSE)
#' @rdname system.file
#' @name system.file
#' @usage system.file(..., package = "base", lib.loc = NULL, mustWork = FALSE)
shim_system.file <- function(..., package = "base", lib.loc = NULL,
                             mustWork = FALSE) {

  # If package wasn't loaded with devtools, pass through to base::system.file.
  # If package was loaded with devtools (the package loaded with load_all)
  # search for files a bit differently.
  if (!(package %in% dev_packages())) {
    base::system.file(..., package = package, lib.loc = lib.loc,
      mustWork = mustWork)

  } else {
    pkg_path <- find.package(package)

    # First look in inst/
    files_inst <- file.path(pkg_path, "inst", ...)
    present_inst <- file.exists(files_inst)

    # For any files that weren't present in inst/, look in the base path
    files_top <- file.path(pkg_path, ...)
    present_top <- file.exists(files_top)

    # Merge them together. Here are the different possible conditions, and the
    # desired result. NULL means to drop that element from the result.
    #
    # files_inst:   /inst/A  /inst/B  /inst/C  /inst/D
    # present_inst:    T        T        F        F
    # files_top:      /A       /B       /C       /D
    # present_top:     T        F        T        F
    # result:       /inst/A  /inst/B    /C       NULL
    #
    files <- files_top
    files[present_inst] <- files_inst[present_inst]
    # Drop cases where not present in either location
    files <- files[present_inst | present_top]
    if (length(files) > 0) {
      # Make sure backslahses are replaced with slashes on Windows
      normalizePath(files, winslash = "/")
    } else {
      ""
    }
    # Note that the behavior isn't exactly the same as base::system.file with an
    # installed package; in that case, C and D would not be installed and so
    # would not be found. Some other files (like DESCRIPTION, data/, etc) would
    # be installed. To fully duplicate R's package-building and installation
    # behavior would be complicated, so we'll just use this simple method.
  }
}

shim_library.dynam.unload <- function(chname, libpath,
                                      verbose = getOption("verbose"),
                                      file.ext = .Platform$dynlib.ext) {

  # If package was loaded by devtools, we need to unload the dll ourselves
  # because libpath works differently from installed packages.
  if (!is.null(dev_meta(chname))) {
    try({
      pkg <- as.package(libpath)
      unload_dll(pkg)
    })
    return()
  }

  # Should only reach this in the rare case that the devtools-loaded package is
  # trying to unload a different package's DLL.
  base::library.dynam.unload(chname, libpath, verbose, file.ext)
}
