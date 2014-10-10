#' Check a package from CRAN.
#'
#' This is useful for automatically checking that dependencies of your
#' packages work.
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
#'   It defaults to the option \code{"Ncpus"} or \code{1} if unset.
#' @param check_dir the directory in which the package is checked
#' @param revdep_pkg Optional name of a package for which this check is
#'   checking the reverse dependencies of. This is normally passed in from
#'   \code{\link{revdep_check}}, and is used only for logging.
#' @return invisible \code{TRUE} if successful and no ERRORs or WARNINGS,
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
  threads = getOption("Ncpus", 1), check_dir = tempfile("check_cran"),
  revdep_pkg = NULL) {

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
    repos <- c(repos, BiocInstaller::biocinstallRepos())
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
  deps <- unique(unlist(tools::package_dependencies(pkgs, packages(),
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
  if (!file.exists(check_dir)) dir.create(check_dir)

  # Download and check each package, parsing output as we go.
  check_pkg <- function(i) {
    url <- package_url(pkgs[i], repos, available = available_src)

    if (length(url$url) == 0) {
      message("Can't find package source for ", i, ": ", pkgs[i],
        ". Skipping...")
      return(NULL)
    }
    local <- file.path(srcpath, url$name)

    if (!file.exists(local)) {
      message("Downloading ", pkgs[i])
      download.file(url$url, local, quiet = TRUE)
    }

    message("Checking ", i , ": ", pkgs[i])
    start_time <- Sys.time()
    check_args <- "--no-multiarch --no-manual --no-codoc"
    try(check_r_cmd(local, cran = TRUE, check_version = FALSE,
      force_suggests = FALSE, args = check_args, check_dir = check_dir,
      quiet = TRUE), silent = TRUE)

    check_path <- file.path(check_dir, gsub("_.*?$", ".Rcheck", url$name))
    results <- parse_check_results(check_path)
    if (length(results) > 0) cat(results, "\n")

    elapsed_time <- as.numeric(Sys.time() - start_time, units = "secs")
    message("Finished checking ", i , ": ", pkgs[i], " (",
      round(elapsed_time, 1), " seconds)")
    writeLines(sprintf("%d  %s  %.1f", i, pkgs[i], elapsed_time),
      file.path(check_path, "check-time.txt"))

    results
  }

  results <- parallel::mclapply(seq_along(pkgs), check_pkg,
    mc.preschedule = FALSE, mc.cores = threads)

  names(results) <- pkgs

  n_problems <- sum(vapply(results, length, integer(1)))
  if (n_problems > 0) {
    warning("Found ", n_problems, call. = FALSE)
  }

  # Collect the output
  collect_check_results(check_dir, revdep_pkg)

  invisible(list(path = check_dir, results = results))
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
collect_check_results <- function(topdir, revdep_pkg) {
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

  sink(summary_out)
  if (!is.null(revdep_pkg)) {
    sha <- packageDescription(revdep_pkg)$RemoteSha
    if (!is.null(sha)) sha <- paste0("Commit ", sha, "\n")

    cat("=========================================================================\n",
        "Reverse dependency check for ", revdep_pkg, " ",
        as.character(packageVersion(revdep_pkg)), "\n",
        sha,
        "=========================================================================\n",
        sep = "")
  }
  print(session_info())
  cat("\n")
  sink()

  for (i in seq_along(checkresults)) {
    pkgname <- names(checkresults[i])
    linetext <- paste(rep("=", 72 - nchar(pkgname)), collapse = "")
    cat(pkgname, linetext, "\n", checkresults[[i]], "\n\n\n", file = summary_out)
  }


  message("Collecting check times in 00check-times.txt")
  checktimes <- file.path(checkdirs, "check-time.txt")
  checktimes_dest <- file.path(rdir, "00check-times.txt")
  for (i in seq_along(checktimes)) {
    linetext <- readLines(checktimes[i])
    cat(linetext, sep = "\n", file = checktimes_dest, append = TRUE)
  }
}
