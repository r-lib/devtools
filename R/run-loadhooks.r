#' Run user and package hooks.
#'
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param hook hook name: one of "load", "unload", "attach", or "detach"
#' @keywords internal
run_pkg_hook <- function(pkg, hook) {
  pkg <- as.package(pkg)

  trans <- c(
    "load"   = ".onLoad",
    "unload" = ".onUnload",
    "attach" = ".onAttach",
    "detach" = ".onDetach")
  hook <- match.arg(hook, names(trans))
  f_name <- trans[hook]

  metadata <- dev_meta(pkg$package)
  if (isTRUE(metadata[[f_name]])) return(FALSE)

  # Run hook function if defined, and not already run
  nsenv <- ns_env(pkg)
  if (!exists(f_name, nsenv, inherits = FALSE)) return(FALSE)

  if (hook %in% c("load", "attach")) {
    nsenv[[f_name]](dirname(pkg$path), pkg$package)
  } else {
    nsenv[[f_name]](dirname(pkg$path))
  }
  metadata[[f_name]] <- TRUE

  TRUE
}

#' @rdname run_pkg_hook
run_user_hook <- function(pkg, hook) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  trans <- c(
    "load"   = "onLoad",
    "unload" = "onUnload",
    "attach" = "attach",
    "detach" = "detach")
  hook <- match.arg(hook, names(trans))
  hook_name <- trans[hook]

  metadata <- dev_meta(pkg$package)
  if (isTRUE(metadata[[hook_name]])) return(FALSE)

  hooks <- getHook(packageEvent(pkg$package, hook_name))
  if (length(hooks) == 0) return(FALSE)

  for(fun in rev(hooks)) try(fun(pkg$package))
  metadata[[hook_name]] <- TRUE
  invisible(TRUE)
}

hook_warning <- function(pkg) {
  if (basename(pkg$path) == pkg$package) return()

  metadata <- dev_meta(pkg$package)
  if (isTRUE(metadata$hook_warning)) return()

  metadata$hook_warning <- TRUE
  warning(
    'Package path "', basename(pkg$path),
    '" does not match package name "', pkg$package, '". ',
    'This can result in problems when calling package hooks. ',
    'Please rename the directory to match the package name.',
    call. = FALSE)
}
