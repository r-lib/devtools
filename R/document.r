#' Use roxygen to make documentation.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param clean if \code{TRUE} will automatically clear all roxygen caches
#'   and delete current \file{man/} contents to ensure that you have the
#'   freshest version of the documentation.
#' @param roclets character vector of roclet names to apply to package
#' @param reload if \code{TRUE} uses \code{load_all} to reload the package
#'   prior to documenting.  This is important because \pkg{roxygen2} uses
#'   introspection on the code objects to determine how to document them.
#' @keywords programming
#' @export
#' @importFrom digest digest
document <- function(pkg = ".", clean = FALSE,
  roclets = c("collate", "namespace", "rd"), reload = TRUE) {

  require("roxygen2")
  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")

  man_path <- file.path(pkg$path, "man")
  if (!file.exists(man_path)) dir.create(man_path)

  if (clean) {
    if (packageVersion("roxygen2") < 3) {
      roxygen2::clear_caches()  
    }
    file.remove(dir(man_path, full.names = TRUE))
  }

  if (reload) {
    load_all(pkg, reset = clean)
  }
  
  if (packageVersion("roxygen2") < 3) {
    document_roxygen2(pkg, roclets)
  } else {
    document_roxygen3(pkg, roclets)
  }
  
  clear_topic_index(pkg)
  invisible()
}

document_roxygen2 <- function(pkg, roclets, reload = TRUE) {  
  # Integrate source and evaluated code
  env <- ns_env(pkg)
  env_hash <- suppressWarnings(digest(env))
  r_files <- find_code(pkg)
  parsed <- unlist(lapply(r_files, parse.file, env = env,
    env_hash = env_hash), recursive = FALSE)
  
  roclets <- paste(roclets, "_roclet", sep = "")
  for (roclet in roclets) {
    roc <- match.fun(roclet)()
    with_envvar(r_env_vars(),
      with_collate("C", {
        results <- roxygen2:::roc_process(roc, parsed, pkg$path)
        roxygen2:::roc_output(roc, results, pkg$path)
      })
    )
  }
}

document_roxygen3 <- function(pkg, roclets, reload = TRUE) {
  with_envvar(r_env_vars(), with_collate("C", 
    roxygenise(pkg$path, roclets = roclets, load_code = pkg_env)
  ))
}
