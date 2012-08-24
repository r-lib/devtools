#' Load a compiled DLL
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
load_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)

  dllfile <- dll_name(pkg)
  if (!file.exists(dllfile))
    return(invisible())

  # The loading and registering of the dll is similar to how it's done
  # in library.dynam.
  dllinfo <- dyn.load(dllfile)

  # Register dll info so it can be unloaded with library.dynam.unload
  .dynLibs(c(.dynLibs(), list(dllinfo)))

  invisible(dllfile)
}
