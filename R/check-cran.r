#' Check a package from CRAN.
#'
#' This is useful for automatically checking that dependencies of your 
#' packages work.
#'
#' The downloaded package and check directory are only removed if the check is
#' successful - this allows you to inspect the results to figure out what
#' went wrong.
#'
#' This function does not clean up after itself, but does work in a
#' session-specific temporary directory, so all files will be removed
#' when your current R session ends.
#'
#' @param pkg Package name - note that unlike other \pkg{devtools} functions
#'   this is the name of a CRAN package, not a path.
#' @param libpath path to library to store dependencies packages - if you
#'   you're doing this a lot it's a good idea to pick a directory and stick
#'   with it so you don't have to download all the packages every time.
#' @return invisible \code{TRUE} if successful and no ERRORs or WARNINGS,
#' @param ... other parameters passed onto \code{\link{download.packages}}
#' @export
check_cran <- function(pkgs, libpath = file.path(tempdir(), "R-lib"), ...) {
  stopifnot(is.character(pkgs))
  if (length(pkgs) == 0) return()
  message("Checking CRAN packages: ", paste(pkgs, collapse = ", "))
  
  repos <- c(CRAN = "http://cran.r-project.org/", 
             BioC = "http://www.bioconductor.org/packages/devel/bioc")
  tmp <- tempdir()

  # Create and use temporary library
  if (!file.exists(libpath)) dir.create(libpath)
  libpath <- normalizePath(libpath)
  .libPaths(c(libpath, .libPaths()))
  on.exit(.libPaths(setdiff(.libPaths(), libpath)))

  # Make sure existing dependencies are up to date
  message("Check existing dependencies up to date")
  update.packages(libpath, ask = FALSE, quiet = TRUE)
  
  # Install missing dependencies
  deps <- unique(unlist(package_dependencies(pkgs, packages(), 
    which = "all")))
  to_install <- setdiff(deps, installed.packages()[, 1])
  if (length(to_install) > 0) {
    message("Installing ", length(to_install), " missing dependencies")
    install.packages(to_install, lib = libpath, quiet = TRUE, repos = repos)    
  }
    
  # Download source packages
  message("Downloading ", length(pkgs), " source packages for checking")
  downloaded <- download.packages(pkgs, tmp, repos = repos, 
    type = "source") #, quiet = TRUE)
  out_path <- downloaded[, 2]
  check_path <- gsub("_.*?$", ".Rcheck", out_path)
  
  # Check each package, parsing output as we go.
  check <- function(i) {
    message("Checking ", pkgs[i])
    cmd <- paste("CMD check --as-cran --no-multiarch --no-manual --no-codoc ",
      out_path[i], sep = "")
    try(R(cmd, tmp, stdout = NULL), silent = TRUE)
    
    results <- parse_check_results(check_path[i])
    if (length(results) > 0) cat(results, "\n")
    results
  }
  results <- lapply(seq_along(pkgs), check)
  names(results) <- pkgs
  
  n_problems <- sum(vapply(results, length, integer(1)))
  if (n_problems > 0) {
    warning("Found ", n_problems, call. = FALSE)
  }
  
  invisible(results)
}

parse_check_results <- function(path) {
  check_path <- file.path(path, "00check.log")
  
  check_log <- paste(readLines(check_path), collapse = "\n")
  pieces <- strsplit(check_log, "\n\\* ")[[1]]
  problems <- grepl("... (WARN|ERROR)", pieces)
  cran_version <- grepl("CRAN incoming feasibility", pieces)

  messages <- pieces[problems & !cran_version]
  if (length(messages)) {
    paste("* ", messages, collapse = "\n")
  }
}
