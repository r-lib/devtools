#' Load a compiled DLL
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
load_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)
  env <- ns_env(pkg)
  nsInfo <- parse_ns_file(pkg)

  # The code below taken directly from base::loadNamespace, except for
  # library.dynam2, which is a special version of library.dynam

  ## load any dynamic libraries
  dlls <- list()
  dynLibs <- nsInfo$dynlibs
  for (i in seq_along(dynLibs)) {
    lib <- dynLibs[i]
    # NOTE: replaced library.dynam with devtools replacement, library.dynam2
    dlls[[lib]]  <- library.dynam2(pkg, lib)
    assignNativeRoutines(dlls[[lib]], lib, env,
                         nsInfo$nativeRoutines[[lib]])

    ## If the DLL has a name as in useDynLib(alias = foo),
    ## then assign DLL reference to alias.  Check if
    ## names() is NULL to handle case that the nsInfo.rds
    ## file was created before the names were added to the
    ## dynlibs vector.
    if(!is.null(names(nsInfo$dynlibs))
       && names(nsInfo$dynlibs)[i] != "")
      assign(names(nsInfo$dynlibs)[i], dlls[[lib]], envir = env)
    setNamespaceInfo(env, "DLLs", dlls)
  }
  addNamespaceDynLibs(env, nsInfo$dynlibs)

  invisible(dlls)
}


# Return a list of currently loaded DLLs from the package
loaded_dlls <- function(pkg = ".") {
  pkg <- as.package(pkg)
  libs <- .dynLibs()
  matchidx <- vapply(libs, "[[", character(1), "name") == pkg$package
  libs[matchidx]
}

# This is a replacement for base::library.dynam, with a slightly different
# call interface. The original requires that the name of the package is the
# same as the directory name, which isn't always the case when loading with
# devtools. This version allows them to be different, and also searches in
# the src/ directory for the DLLs, instead of the libs/$R_ARCH/ directory.
library.dynam2 <- function(pkg = ".", lib = "") {
  pkg <- as.package(pkg)

  dllname <- paste(lib, .Platform$dynlib.ext, sep = "")
  dllfile <- file.path(pkg$path, "src", dllname)

  if (!file.exists(dllfile))
    return(invisible())

  # # The loading and registering of the dll is similar to how it's done
  # # in library.dynam.
  dllinfo <- dyn.load(dllfile)

  # Register dll info so it can be unloaded with library.dynam.unload
  .dynLibs(c(.dynLibs(), list(dllinfo)))

  return(dllinfo)
}


# This is taken directly from base::loadNamespace() in R 2.15.1
addNamespaceDynLibs <- function(ns, newlibs) {
  dynlibs <- getNamespaceInfo(ns, "dynlibs")
  setNamespaceInfo(ns, "dynlibs", c(dynlibs, newlibs))
}


# This is taken directly from base::loadNamespace in R 2.15.1
# The only change is the line used get the package name
assignNativeRoutines <- function(dll, lib, env, nativeRoutines) {
  package <- getPackageName(env)

  if(length(nativeRoutines) == 0L)
    return(NULL)

  if(nativeRoutines$useRegistration) {
    ## Use the registration information to register ALL the symbols
    fixes <- nativeRoutines$registrationFixes
    routines <- getDLLRegisteredRoutines.DLLInfo(dll, addNames = FALSE)
    lapply(routines,
      function(type) {
        lapply(type,
               function(sym) {
                   varName <- paste0(fixes[1L], sym$name, fixes[2L])
                   if(exists(varName, envir = env))
                     warning("failed to assign RegisteredNativeSymbol for ",
                             sym$name,
                             paste(" to", varName),
                             " since ", varName,
                             " is already defined in the ", package,
                             " namespace")
                   else
                     assign(varName, sym, envir = env)
               })
      })

   }

  symNames <- nativeRoutines$symbolNames
  if(length(symNames) == 0L)
    return(NULL)

  symbols <- getNativeSymbolInfo(symNames, dll, unlist = FALSE,
                                     withRegistrationInfo = TRUE)
  lapply(seq_along(symNames),
    function(i) {
      ## could vectorize this outside of the loop
      ## and assign to different variable to
      ## maintain the original names.
      varName <- names(symNames)[i]
      origVarName <- symNames[i]
      # DEVTOOLS: Following block commented out because it raises unneeded
      #           warnings with load_all(reset=FALSE).
      # if(exists(varName, envir = env))
      #    warning("failed to assign NativeSymbolInfo for ",
      #            origVarName,
      #            ifelse(origVarName != varName,
      #                       paste(" to", varName), ""),
      #            " since ", varName,
      #            " is already defined in the ", package,
      #            " namespace")
      # else
        assign(varName, symbols[[origVarName]],
               envir = env)

    })



  symbols
}
