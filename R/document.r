#' Use roxygen (and doxygen) to document a package.
#'
#' This function is a wrapper for the \code{\link[roxygen2]{roxygenize}()}
#' function from the roxygen2 package. See the documentation and vignettes of
#' that package to learn how to use roxygen.
#' In addition, it also runs doxygen on source code if existing
#' The resulting documentation can be found in /inst/doxygen/
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param clean,reload Deprecated.
#' @inheritParams roxygen2::roxygenise
#' @seealso \code{\link[roxygen2]{roxygenize}},
#'   \code{browseVignettes("roxygen2")},
#'   doxumentinit
#' @export
document <- function(pkg = ".", clean = NULL, roclets = NULL, reload = TRUE,doxygen=file.exists(paste0(pkg,"/src"))) {
  if (!missing(clean)) {
    warning("Clean argument deprecated: roxygen2 now automatically cleans up",
      call. = FALSE)
  }

if(doxygen){
    doxyFileName<-"inst/doxygen/Doxyfile"
    if(!file.exists(doxyFileName)){
        doxumentinit()
    }
    system(paste("doxygen",doxyFileName))
}
  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")

  if (!is_loaded(pkg) || (is_loaded(pkg) && reload)) {
    load_all(pkg)
  }
  with_envvar(r_env_vars(),
    roxygen2::roxygenise(pkg$path, roclets = roclets, load_code = ns_env)
  )

  clear_topic_index(pkg)
  invisible()
}
