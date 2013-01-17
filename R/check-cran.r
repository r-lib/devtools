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
  on.exit(options(old), add = TRUE)

  message("Determining available packages") # --------------------------------
  repos <- c(
    CRAN = "http://cran.rstudio.com/",
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

  # Add the temoporary library and remove on exit
  libpaths_orig <- set_libpaths(c(libpath, .libPaths()))
  on.exit(.libPaths(libpaths_orig), add = TRUE)

  # Make sure existing dependencies are up to date ---------------------------
  old <- old.packages(libpath, repos = repos, type = type,
    available = available_bin)
  if (!is.null(old)) {
    message("Updating ", nrow(old), " existing dependencies: ",
      paste(old[, "Package"], collapse = ", "))
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
    message("Installing ", length(known), " missing dependencies: ",
      paste(known, collapse = ", "))
    install.packages(known, lib = libpath, quiet = FALSE, repos = repos,
      Ncpus = threads)
  }
  if (length(unknown) > 0) {
    message("No binary packages available for dependenices: ",
      paste(unknown, collapse = ", "))
  }

  # Create directory for storing results.
  check_dir <- tempfile("check_cran")
  dir.create(check_dir)

  # Download and check each package, parsing output as we go.
  check_pkg <- function(i) {
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
    check_args <- "--no-multiarch --no-manual --no-codoc"
    try(check_r_cmd(local, cran = TRUE, check_version = FALSE,
      force_suggests = FALSE, args = check_args, check_dir = check_dir,
      quiet = TRUE), silent = TRUE)

    check_path <- file.path(check_dir, gsub("_.*?$", ".Rcheck", url$name))
    results <- parse_check_results(check_path)
    if (length(results) > 0) cat(results, "\n")
    results
  }

  if (getRversion() <= '2.15.2' && threads >= length(pkgs)) {
    threads <- length(pkgs) - 1
    message("Reducing number of threads to ", threads,
      " (number of packages to check minus one) due to a bug in mclapply in",
      " R <= 2.15.2")
  }

  results <- mclapply(seq_along(pkgs), check_pkg, mc.preschedule = FALSE,
    mc.cores = threads)

  names(results) <- pkgs

  n_problems <- sum(vapply(results, length, integer(1)))
  if (n_problems > 0) {
    warning("Found ", n_problems, call. = FALSE)
  }

  # Collect the output
  collect_check_results(check_dir)

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

# Collects all the results from running check_cran and puts in a
# directory results/ under the top level tempdir.
collect_check_results <- function(topdir) {
  # Directory for storing results
  rdir <- file.path(topdir, "results")
  if (dir.exists(rdir)) {
    # Remove existing results
    unlink(dir(normalizePath(rdir), include.dirs = TRUE), recursive = TRUE)
  } else {
    dir.create(rdir)
  }

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


  checkresults <- lapply(checkdirs, parse_check_results)

  message("Writing warnings and error summary for each package to ", rdir)
  for (i in seq_along(checkresults)) {
    pkgname <- names(checkresults[i])
    result <- checkresults[[i]]

    if (!is.null(result) && nzchar(result)) {
      err_filename <- file.path(rdir, paste(pkgname, "-error", sep=""))
      err_out <- file(err_filename, "w")

      cat(pkgname, result, file = err_out)
      close(err_out)
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
