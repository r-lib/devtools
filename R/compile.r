#' Compile a .dll/.so from source
#'
#' Support for compiling C, C++, and Fotran code is experimental, and
#' will probably only work for simple cases where the code is to be
#' compiled into a single DLL. It will work with Makevars files, but
#' not with Makefiles.
#'
#' \code{compile_dll} will compile \code{.c}, \code{.cpp}, and \code{.f}
#' files, and save the resulting DLL file in the same directory as the
#' source code, \code{/src/}. Depending on the platform, the DLL file
#' will have the extension \code{.dll} or \code{.so}.
#'
#' Invisibly returns the names of the DLL.
#'
#' @note If this is used to compile code that uses Rcpp, you may need to
#'   add the following line to your \code{Makevars} file so that it
#'   knows where to find the Rcpp headers:
#'   \code{PKG_CPPFLAGS=`$(R_HOME)/bin/Rscript -e 'Rcpp:::CxxFlags()'`}
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{clean_dll}} to delete the compiled files.
#' @export
compile_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)

  # Check source dir exists
  srcdir <- file.path(pkg$path, "src")
  if (!dir.exists(srcdir))
    return(invisible())

  # Check that there are source files to compile
  srcfiles <- dir(srcdir, pattern = "\\.(c|cpp|f)$")
  if (length(srcfiles) == 0)
    return(invisible())

  # Compile Rcpp attributes if necessary
  compile_rcpp_attributes(pkg)
  
  # Setup build environment then restore it when done
  restore <- setup_build_environment(c(pkg$package, pkg$linkingto))
  on.exit(restore_build_environment(restore))
  
  # Compile the DLL
  srcfiles <- paste(srcfiles, collapse = " ")
  R(paste("CMD SHLIB", "-o", basename(dll_name(pkg)), srcfiles),
    path = srcdir)

  invisible(dll_name(pkg))
}

#' Remove compiled objects from /src/ directory
#'
#' Invisibly returns the names of the deleted files.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{compile_dll}}
#' @export
clean_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)

  # Clean out the /src/ directory
  files <- dir(file.path(pkg$path, "src"),
    pattern = "\\.(o|sl|so|dylib|a|dll|def)$",
    full.names = TRUE)
  unlink(files)

  invisible(files)
}

# Returns the full path and name of the DLL file
dll_name <- function(pkg = ".") {
  pkg <- as.package(pkg)

  name <- paste(pkg$package, .Platform$dynlib.ext, sep = "")

  file.path(pkg$path, "src", name)
}


# Setup the build environment based on the specified dependencies. Returns an
# opaque object that can be passed to restore_build_environment to reverse 
# whatever changes that were made
setup_build_environment <- function(packages) {
  
  # discover dependencies
  linkingToPackages <- character()
  buildEnv <- list()
  for (package in packages) {
    
    # add a LinkingTo for this package
    linkingToPackages <- unique(c(linkingToPackages, package))
    
    # see if the package exports a plugin
    plugin <- get_inline_plugin(package)
    if (!is.null(plugin)) {
      
      # get the plugin settings 
      settings <- plugin()
      
      # merge environment variables
      pluginEnv <- settings$env
      for (name in names(pluginEnv)) {
        # if it doesn't exist already just set it
        if (is.null(buildEnv[[name]])) {
          buildEnv[[name]] <- pluginEnv[[name]]
        }
        # if it's not identical then append
        else if (!identical(buildEnv[[name]],
          pluginEnv[[name]])) {
          buildEnv[[name]] <- paste(buildEnv[[name]], 
            pluginEnv[[name]]);
        }
        else {
          # it already exists and it's the same value, this 
          # likely means it's a flag-type variable so we 
          # do nothing rather than appending it
        }   
      }
      
      # capture any LinkingTo elements defined by the plugin
      linkingToPackages <- unique(c(linkingToPackages, settings$LinkingTo))
    }
  }
  
  # set cxxFlags based on the LinkingTo dependencies (and also respect
  # any PKG_CXXFLAGS set by the plugin)
  pkgCxxFlags <- pkg_cxx_flags(linkingToPackages)
  buildEnv$PKG_CXXFLAGS <- paste(buildEnv$PKG_CXXFLAGS, pkgCxxFlags)  
  buildEnv$CLINK_CPPFLAGS <- buildEnv$PKG_CXXFLAGS
  
  # add cygwin message muffler
  buildEnv$CYGWIN = "nodosfilewarning"
  
  # create restore list
  restore <- list()
  for (name in names(buildEnv))
    restore[[name]] <- Sys.getenv(name, unset = NA)
  
  # set environment variables
  do.call(Sys.setenv, buildEnv)

  # return restore list
  return (restore)
}

restore_build_environment <- function(restore) {
  # variables to reset
  setVars <- restore[!is.na(restore)]
  if (length(setVars))
    do.call(Sys.setenv, setVars)
  
  # variables to remove
  removeVars <- names(restore[is.na(restore)])
  if (length(removeVars))
    Sys.unsetenv(removeVars)
}


# Get the inline plugin for the specified package (return NULL if none found)
get_inline_plugin <- function(package) {
  tryCatch(get("inlineCxxPlugin", asNamespace(package)),
    error = function(e) NULL) 
}

# Build PKG_CXXFLAGS by from include directories of LinkingTo packages
pkg_cxx_flags <- function(linkingToPackages) {
  pkgCxxFlags <- NULL
  for (package in linkingToPackages) {
    packagePath <- find.package(package, NULL, quiet=TRUE)
    pkgCxxFlags <- paste(pkgCxxFlags, 
      paste0('-I"', packagePath, '/include"'), 
      collapse=" ")
  }
  return (pkgCxxFlags)
}
