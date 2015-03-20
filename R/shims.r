the <- new.env(parent=emptyenv())

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
    the$shims$system.file$orig_value(..., package = package, lib.loc = lib.loc,
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
  the$shims$library.dynam.unload$orig_value(chname, libpath, verbose, file.ext)
}

#' create a shim object for a given function which contains the original
#' function definition as well as the replacement.
#' @useDynLib devtools duplicate_
shim <- function(name, env, new) {
  env <- asNamespace(env)
  target_value <- get(name, envir = env, mode = "function")
  structure(list(
    env = env, name = as.name(name),
    orig_value = .Call(duplicate_, target_value),
    target_value = target_value,
    new_value = new), class = "shim")
}

# replace a given shim object created by \code{shim}
#' @useDynLib devtools reassign_function
set_shim <- function(shim) {
  .Call(reassign_function, shim$name, shim$env, shim$target_value, shim$new_value)
}

# restore a given shim object created by \code{shim} to its original value
#' @useDynLib devtools reassign_function
reset_shim <- function(shim) {
  .Call(reassign_function, shim$name, shim$env, shim$target_value, shim$orig_value)
}

# replace existing function with devtools versions of
# help, ?, system.file and library.dynam.unload.
insert_global_shims <- function() {
  if (is.null(the$shims)) {
    the$shims <- list(
      system.file = shim("system.file", "base", shim_system.file),
      "?" = shim("?", "utils", shim_question),
      "help" = shim("help", "utils", shim_help),
      library.dynam.unload = shim("library.dynam.unload", "base", shim_library.dynam.unload)
    )

    lapply(the$shims, set_shim)
  }
  invisible()
}

# restore all of the global shims to their original values
remove_global_shims <- function() {
  lapply(the$shims, reset_shim)
  invisible()
}
