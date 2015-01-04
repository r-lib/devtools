#' @export
#' @param res Result of \code{revdep_check}
#' @param log_dir Directory in which to save logs
#' @rdname revdep_check
revdep_check_save_logs <- function(res, log_dir = "revdep") {
  stopifnot(file.exists(log_dir))

  save_one <- function(pkg, path) {
    out <- file.path(log_dir, pkg)
    dir.create(out, showWarnings = FALSE)

    logs <- check_logs(path)
    new_dirs <- setdiff(unique(dirname(logs)), ".")
    if (length(new_dirs) > 0) {
      lapply(file.path(out, new_dirs), dir.create, recursive = TRUE, showWarnings = FALSE)
    }

    file.copy(file.path(path, logs), file.path(out, logs))

    desc <- check_description(path)
    write_dcf(file.path(out, "DESCRIPTION"), desc[c("Package", "Version", "Maintainer")])
  }

  pkgs <- check_dirs(res$check_dir)
  Map(save_one, names(pkgs), pkgs)
  invisible()
}

#' @rdname revdep_check
#' @export
revdep_check_save_summary <- function(res, log_dir = "revdep") {
  writeLines(revdep_check_summary(res), file.path(log_dir, "summary.md"))
}

#' @rdname revdep_check
#' @export
revdep_check_summary <- function(res) {
  plat <- platform_info()
  plat_df <- data.frame(setting = names(plat), value = unlist(plat))
  rownames(plat_df) <- NULL

  # Find all dependencies
  deps <- res$pkg[c("imports", "depends", "linkingto", "suggests")]
  pkgs <- unlist(lapply(deps, function(x) parse_deps(x)$name), use.names = FALSE)
  pkgs <- c(res$pkg$package, sort(unique(pkgs)))
  pkgs <- intersect(pkgs, dir(res$libpath))
  pkg_df <- package_info(pkgs, libpath = res$libpath)

  checks <- check_dirs(res$check_dir)
  summaries <- vapply(checks, check_summary_package, character(1))

  paste0(
    "# Setup\n\n",
    "## Platform\n\n",
    paste(knitr::kable(plat_df), collapse = "\n"),
    "\n\n",
    "## Packages\n\n",
    paste(knitr::kable(pkg_df), collapse = "\n"),
    "\n\n",
    "# Check results\n",
    paste0(length(checks), " checked out of ", length(res$deps), " dependencies \n\n"),
    paste0(summaries, collapse = "\n")
  )
}

check_summary_package <- function(path) {
  pkg <- check_description(path)

  meta <- c(
    "Maintainer" = pkg$Maintainer,
    "Bug reports" = pkg$BugReports
  )
  meta_string <- paste(names(meta), ": ", meta, collapse = "  \n", sep = "")

  header <- paste0(
    "## ", pkg$Package, " (", pkg$Version, ")\n",
    meta_string,
    "\n"
  )

  failures <- check_failures(path)
  if (length(failures) == 0) {
    status <- "__OK__\n"
  } else {
    status <- paste0(
      "```\n",
      failures, "\n",
      "```\n", collapse = "")
  }

  time <- paste0("Completed in ", check_time(path), "s\n")

  paste0(header, "\n", status)
}

indent <- function(x, spaces = 4) {
  ind <- paste(rep(" ", spaces), collapse = "")
  paste0(ind, gsub("\n", paste0("\n", ind), x, fixed = TRUE))
}

check_dirs <- function(path) {
  checkdirs <- list.dirs(path, recursive = FALSE, full.names = TRUE)
  checkdirs <- checkdirs[grepl("\\.Rcheck$", checkdirs)]
  names(checkdirs) <- sub("\\.Rcheck$", "", basename(checkdirs))

  has_src <- file.exists(file.path(checkdirs, "00_pkg_src", names(checkdirs)))
  checkdirs[has_src]
}

check_description <- function(path) {
  pkgname <- gsub("\\.Rcheck$", "", basename(path))
  read_dcf(file.path(path, "00_pkg_src", pkgname, "DESCRIPTION"))
}

check_time <- function(path) {
  checktimes <- file.path(path, "check-time.txt")
  scan(checktimes, list(1L, "", 1), quiet = TRUE)[[3]]
}

check_logs <- function(path) {
  paths <- dir(path, recursive = TRUE)
  paths[grepl("(fail|out|log)$", paths)]
}

check_failures <- function(path, error = TRUE, warning = TRUE, note = TRUE) {
  check_dir <- file.path(path, "00check.log")
  check_log <- paste(readLines(check_dir), collapse = "\n")

  # Strip off trailing NOTE and WARNING messages
  check_log <- gsub("^NOTE: There was .*\n$", "", check_log)
  check_log <- gsub("^WARNING: There was .*\n$", "", check_log)

  pieces <- strsplit(check_log, "\n\\* ")[[1]]

  is_error <- grepl("... ERROR", pieces)
  is_warn  <- grepl("... WARN", pieces)
  is_note  <- grepl("... NOTE", pieces)
  is_problem <- (error & is_error) | (warning & is_warn) | (note & is_note)

  problems <- grepl("... (WARN|ERROR|NOTE)", pieces)
  cran_version <- grepl("CRAN incoming feasibility", pieces)

  pieces[is_problem & !cran_version]
}
