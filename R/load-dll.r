#' Load a compiled DLL
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
onload_assign("load_dll",
  make_function(alist(pkg = "."),
    bquote({
      pkg <- as.package(pkg)
      env <- ns_env(pkg)
      nsInfo <- parse_ns_file(pkg)

      dlls <- list()
      dynLibs <- nsInfo$dynlibs

      ## The code below taken directly from base::loadNamespace
      ## https://github.com/wch/r-source/blob/tags/R-3-3-0/src/library/base/R/namespace.R#L466-L485
      ## except for the call to library.dynam2, which is a special version of
      ## library.dynam
      .(for_loop)
      addNamespaceDynLibs(env, nsInfo$dynlibs)

      invisible(dlls)
    },
    list(for_loop =
      modify_lang(
        f = function(x)
          if (is.call(x) && identical(x[1], quote(library.dynam()))) {
            quote(library.dynam2(pkg, lib))
          } else {
            x
          },

        extract_lang(
          f = function(x) {
            length(x) > 3 && identical(x[1:3], quote(for (i in seq_along(dynLibs)) NULL)[1:3])[[1]]
          },
          body(loadNamespace)
        )[[1]]
      )))))

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


# This is taken directly from base::loadNamespace()
# https://github.com/wch/r-source/blob/tags/R-3-3-0/src/library/base/R/namespace.R#L270-L273
onload_assign("addNamespaceDynLibs",
  eval(
    extract_lang(body(loadNamespace),
    function(x) length(x) > 2 && identical(x[1:2], quote(addNamespaceDynLibs <- NULL)[1:2]))[[c(1, 3)]])
)

# This is taken directly from base::loadNamespace
# https://github.com/wch/r-source/blob/tags/R-3-3-0/src/library/base/R/namespace.R#L287-L308
# The only change is the line used get the package name
onload_assign("assignNativeRoutines", {
  f <- eval(
    extract_lang(body(loadNamespace),
    function(x) length(x) > 2 && identical(x[1:2], quote(assignNativeRoutines <- NULL)[1:2]))[[c(1, 3)]])
  body(f) <- as.call(append(after = 1,
      as.list(body(f)),
      quote(package <- methods::getPackageName(env))))
  f
})
