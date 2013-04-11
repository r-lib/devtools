#' Load complete package.
#'
#' \code{load_all} loads a package. It roughly simulates what happens
#' when a package is installed and loaded with \code{\link{library}}.
#'
#' To unload and reload a package, use \code{reset=TRUE}.
#' When reloading a package, A, that another package, B, depends on,
#' \code{load_all} might not be able to cleanly unload and reload A.
#' If this causes problems, try using unloading package B with
#' \code{\link{unload}} before using \code{load_all} on A.
#'
#' Support for packages with compiled C/C++/Fortran code in the
#' \code{/src/} directory is experimental. See \code{\link{compile_dll}}
#' for more information about compiling code.
#'
#' The namespace environment \code{<namespace:pkgname>}, is a child of
#' the imports environment, which has the name attribute
#' \code{imports:pkgname}. It is in turn is a child of
#' \code{<namespace:base>}, which is a child of the global environment.
#' (There is also a copy of the base namespace that is a child of the empty
#' environment.)
#'
#' The package environment \code{<package:pkgname>} is an ancestor of the
#' global environment. Normally when loading a package, the objects
#' listed as exports in the NAMESPACE file are copied from the namespace
#' to the package environment. However, \code{load_all} by default will
#' copy all objects (not just the ones listed as exports) to the package
#' environment. This is useful during development because it makes all
#' objects easy to access.
#'
#' To export only the objects listed as exports, use
#' \code{export_all=FALSE}. This more closely simulates behavior when
#' loading an installed package with \code{\link{library}}, and can be
#' useful for checking for missing exports.
#'
#' \code{load_all} also inserts shim functions into the imports environment
#' of the laded package. It presently adds a replacement version of
#' \code{system.file} which returns different paths from
#' \code{base::system.file}. This is needed because installed and uninstalled
#' package sources have different directory structures. Note that this is not
#' a perfect replacement for \code{base::system.file}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information. If the \code{DESCRIPTION}
#'   file does not exist, it is created using \code{\link{create_description}}.
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
#' @param recompile force a recompile of DLL from source code, if present.
#' @param export_all If \code{TRUE} (the default), export all objects.
#'   If \code{FALSE}, export only the objects that are listed as exports
#'   in the NAMESPACE file.
#' @param quiet if \code{TRUE} suppresses output from this function.
#'
#' @seealso \code{\link{unload}}
#' @seealso \code{\link{compile_dll}}
#' @seealso \code{\link{clean_dll}}
#' @keywords programming
#' @examples
#' \dontrun{
#' # Load the package in the current directory
#' load_all("./")
#'
#' # Running again loads changed files
#' load_all("./")
#'
#' # With reset=TRUE, unload and reload the package for a clean start
#' load_all("./", TRUE)
#'
#' # With export_all=FALSE, only objects listed as exports in NAMESPACE
#' # are exported
#' load_all("./", export_all = FALSE)
#' }
#' @export
load_all <- function(pkg = ".", reset = FALSE, recompile = FALSE,
  export_all = TRUE, quiet = FALSE) {

  if (!is.package(pkg)) {
    create_description(pkg)
    pkg <- as.package(pkg)
  }

  if (!quiet) message("Loading ", pkg$package)

  # Reloading devtools is a special case. Normally, objects in the
  # namespace become inaccessible if the namespace is unloaded before the
  # the object has been accessed. This is kind of a hack - using as.list
  # on the namespace accesses each object, making the objects accessible
  # later, after the namespace is unloaded.
  if (pkg$package == "devtools") {
    as.list(ns_env(pkg))
  }

  # Check description file is ok
  check <- tools:::.check_package_description(
    file.path(pkg$path, "DESCRIPTION"))
  if (length(check) > 0) {
    msg <- capture.output(tools:::print.check_package_description(check))
    message("Invalid DESCRIPTION:\n", paste(msg, collapse = "\n"))
  }

  # If installed version of package loaded, unload it
  if (is_loaded(pkg) && is.null(dev_meta(pkg$package))) {
    unload(pkg)
  }

  # Unload dlls
  unload_dll(pkg)

  if (reset) {
    clear_cache()
    if (is_loaded(pkg)) unload(pkg)
  }

  if (recompile) clean_dll(pkg)

  # Compile dll if it exists
  compile_dll(pkg, quiet = quiet)


  # Set up the namespace environment ----------------------------------
  # This mimics the procedure in loadNamespace

  if (!is_loaded(pkg)) create_ns_env(pkg)

  out <- list(env = ns_env(pkg))

  # Load dependencies
  load_depends(pkg)
  load_imports(pkg)
  # Add shim objects
  insert_shims(pkg)

  out$data <- load_data(pkg)
  out$code <- load_code(pkg)
  register_s3(pkg)
  out$dll <- load_dll(pkg)

  run_onload(pkg)

  # Invoke namespace load actions
  run_ns_load_actions(pkg)

  # Set up the exports in the namespace metadata (this must happen after
  # the objects are loaded)
  setup_ns_exports(pkg, export_all)

  # Set up the package environment ------------------------------------
  # Create the package environment if needed
  if (!is_attached(pkg)) attach_ns(pkg)

  # Copy over objects from the namespace environment
  export_ns(pkg)

  run_onattach(pkg)

  invisible(out)
}


#' Create a default DESCRIPTION file for a package.
#'
#' @details
#' To set the default author and licenses, set \code{options}
#' \code{devtool.author} and \code{devtool.license}.  I use
#' \code{options(devtools.author = '"Hadley Wickham <h.wickham@@gmail.com> [aut,cre]"',
#'   devtools.license = "GPL-3")}.
#' @param path path to package root directory
#' @param extra a named list of extra options to add to \file{DESCRIPTION}
#' @param quiet if \code{TRUE}, suppresses output from this function.
#' @export
#' @importFrom whisker whisker.render
create_description <- function(path, extra = getOption("devtools.desc"),
                               quiet = FALSE) {
  path <- find_package(path, FALSE)
  desc_path <- file.path(path, "DESCRIPTION")

  if (file.exists(desc_path)) return(FALSE)
  template <- readLines(system.file("templates", "DESCRIPTION",
    package = "devtools"))
  out <- whisker.render(template, description_vals(path, extra))

  if (!quiet) {
    message("No DESCRIPTION found. Creating default:\n" ,
      paste(out, collapse = "\n"))
  }

  writeLines(out, desc_path)

  TRUE
}

description_vals <- function(path, extra = NULL) {
  list(
    name = basename(path),
    author = getOption("devtools.desc.author"),
    r_version = as.character(getRversion()),
    license = getOption("devtools.desc.license"),
    suggests = paste(getOption("devtools.desc.suggests"), collapse = ","),
    extra = if (length(extra) > 0)
      paste0(names(extra), ": ", unlist(extra), collapse = "\n")
  )
}
