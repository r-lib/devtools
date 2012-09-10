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
#' @param pkgs Vector of package names - note that unlike other \pkg{devtools}
#'   functions this is the name of a CRAN package, not a path.
#' @param libpath path to library to store dependencies packages - if you
#'   you're doing this a lot it's a good idea to pick a directory and stick
#'   with it so you don't have to download all the packages every time.
#' @param srcpath path to directory to store source versions of dependent
#'   packages - again, this saves a lot of time because you don't need to
#'   redownload the packages every time you run the package.
#' @param bioconductor include bioconductor packages in checking?
#' @param type binary package type of test
#' @param threads number of concurrent threads to use for checking.
#' @return invisible \code{TRUE} if successful and no ERRORs or WARNINGS,
#' @param ... other parameters passed onto \code{\link{download.packages}}
#' @importFrom tools package_dependencies
#' @importFrom parallel mclapply
#' @export
#' @examples
#' \dontrun{
#' dep <- revdep("ggplot2")
#' check_cran(dep, "~/documents/ggplot/ggplot-check")
#' # Or, equivalently:
#' revdep_check("ggplot2")
#' }
check_cran <- function(pkgs, libpath = file.path(tempdir(), "R-lib"),
  srcpath = libpath, bioconductor = FALSE, type = getOption("pkgType"),
  threads = 1, ...) {
  stopifnot(is.character(pkgs))
  if (length(pkgs) == 0) return()

  message("Checking ", length(pkgs), " CRAN packages")
  old <- options(warn = 1)
  on.exit(options(old))

  message("Determining available packages") # --------------------------------
  repos <- c(
    CRAN = "http://cran.r-project.org/", 
    omegahat = "http://www.omegahat.org/R"
  )
  if (bioconductor) {
    require("BiocInstaller")
    repos <- c(repos, biocinstallRepos())
  }
  available_src <- available_packages(repos, "source")
  available_bin <- available_packages(repos, type)

  # Create and use temporary library
  if (!file.exists(libpath)) dir.create(libpath)
  libpath <- normalizePath(libpath)
  .libPaths(c(libpath, .libPaths()))
  on.exit(.libPaths(setdiff(.libPaths(), libpath)))

  # Make sure existing dependencies are up to date ---------------------------
  old <- old.packages(libpath, repos = repos, type = type, 
    available = available_bin)
  if (!is.null(old)) {
    message("Updating ", nrow(old), " existing dependencies")
    install.packages(old[, "Package"], libpath, repos = repos, type = type,
      Ncpus = threads)
  }
  
  # Install missing dependencies
  deps <- unique(unlist(package_dependencies(pkgs, packages(), 
    which = "all")))
  to_install <- setdiff(deps, installed.packages()[, 1])
  known <- intersect(to_install, rownames(available_bin))
  unknown <- setdiff(to_install, rownames(available_bin))

  if (length(known) > 0) {
    message("Installing ", length(known), " missing binary dependencies")
    install.packages(known, lib = libpath, quiet = FALSE, repos = repos,
      Ncpus = threads)
  }
  if (length(unknown) > 0) {
    message("No binary packages available for dependenices: ", 
      paste(unknown, collapse = ", "))
  }
    
  # Download and check each package, parsing output as we go.
  tmp <- tempdir()
  check <- function(i) {
    url <- package_url(pkgs[i], repos, available = available_src)
    
    if (length(url$url) == 0) {
      message("Can't find package source. Skipping...")
      return(NULL)
    }
    local <- file.path(srcpath, url$name)
    
    if (!file.exists(local)) {
      message("Downloading ", pkgs[i])
      download.file(url$url, local, quiet = TRUE)
    }
    
    message("Checking ", i , ": ", pkgs[i])
    cmd <- paste("CMD check --as-cran --no-multiarch --no-manual --no-codoc ",
      local, sep = "")
    try(R(cmd, tmp, stdout = NULL), silent = TRUE)
    
    check_path <- file.path(tmp, gsub("_.*?$", ".Rcheck", url$name))
    results <- parse_check_results(check_path)
    if (length(results) > 0) cat(results, "\n")
    results
  }
  results <- mclapply(seq_along(pkgs), check, mc.preschedule = FALSE,
    mc.cores = threads)

  names(results) <- pkgs
  
  n_problems <- sum(vapply(results, length, integer(1)))
  if (n_problems > 0) {
    warning("Found ", n_problems, call. = FALSE)
  }

  # Collect the output
  collect_check_results(tmp)
  
  invisible(results)
}

available_packages <- memoise(function(repos, type) {
  suppressWarnings(available.packages(contrib.url(repos, type)))
})

package_url <- function(package, repos, available = available.packages(contrib.url(repos, "source"))) {
  
  ok <- (available[, "Package"] == package)
  ok <- ok & !is.na(ok)
  
  vers <- package_version(available[ok, "Version"])
  keep <- vers == max(vers)
  keep[duplicated(keep)] <- FALSE
  ok[ok][!keep] <- FALSE
  
  name <- paste(package, "_", available[ok, "Version"], ".tar.gz", sep = "")
  url <- file.path(available[ok, "Repository"], name)
  
  list(name = name, url = url)
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

# Collects all the results from running check_cran and puts in a
# directory results/ under the top level tempdir.
collect_check_results <- function(topdir = tempdir()) {
  # Directory for storing results
  rdir <- file.path(topdir, "results")
  if (!dir.exists(rdir))
    dir.create(rdir)

  checkdirs <- list.dirs(topdir, recursive=FALSE)
  checkdirs <- checkdirs[grepl("\\.Rcheck$", checkdirs)]
  # Make it a named vector so that the output of lapply below contains names
  names(checkdirs) <- sub("\\.Rcheck$", "", basename(checkdirs))

  # Copy over all the 00check.log and 00install.out files
  message("Copying check logs to ", rdir)
  checklogs <- file.path(checkdirs, "00check.log")
  checklogs_dest <- file.path(rdir, paste(names(checkdirs), "-check", sep=""))
  names(checklogs_dest) <- names(checkdirs)
  file.copy(checklogs, checklogs_dest, overwrite = TRUE)


  message("Copying install logs to ", rdir)
  installlogs <- file.path(checkdirs, "00install.out")
  installlogs_dest <- file.path(rdir, paste(names(checkdirs), "-install", sep=""))
  file.copy(installlogs, installlogs_dest, overwrite = TRUE)


  checkresults <- lapply(checkdirs, devtools:::parse_check_results)

  message("Writing warnings and error summary for each package to ", rdir)
  for (i in seq_along(checkresults)) {
    pkgname <- names(checkresults[i])
    result <- checkresults[[i]]

    if (!is.null(result) && nzchar(result)) {
      err_filename <- file.path(rdir, paste(pkgname, "-error", sep=""))
      err_out <- file(err_filename, "w")
      on.exit(close(err_out))

      cat(pkgname, result, file = err_out)
    }
  }


  summary_filename <- file.path(rdir, "00check-summary.txt")
  message("Creating summary of check warnings and errors in ", summary_filename)
  summary_out <- file(summary_filename, "w")
  on.exit(close(summary_out))

  for (i in seq_along(checkresults)) {
    pkgname <- names(checkresults[i])
    linetext <- paste(rep("=", 72 - nchar(pkgname)), collapse = "")
    cat(pkgname, linetext, "\n", checkresults[[i]], "\n\n\n", file = summary_out)
  }
}
