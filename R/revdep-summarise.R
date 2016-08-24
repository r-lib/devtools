#' @rdname revdep_check
#' @export
revdep_check_save_summary <- function(pkg = ".") {
  pkg <- as.package(pkg)

  md_all <- revdep_check_summary_md(pkg)
  writeLines(md_all, file.path(pkg$path, "revdep", "README.md"))

  md_bad <- revdep_check_summary_md(pkg, has_problem = TRUE)
  writeLines(md_bad, file.path(pkg$path, "revdep", "problems.md"))

}

revdep_check_summary_md <- function(pkg, has_problem = FALSE) {
  check_suggested("knitr")

  check <- readRDS(revdep_check_path(pkg))

  paste0(
    revdep_setup_md(check),
    "\n\n",
    revdep_check_results_md(check$results, has_problem)
  )
}

revdep_setup_md <- function(check) {
  paste0(
    "# Setup\n\n",
    revdep_platform_md(check$platform),
    "\n\n",
    revdep_packages_md(check$dependencies)
  )
}

revdep_platform_md <- function(platform) {
  plat_df <- data.frame(
    setting = names(platform),
    value = unlist(platform)
  )
  rownames(plat_df) <- NULL

  paste0(
    "## Platform\n\n",
    paste(knitr::kable(plat_df), collapse = "\n")
  )
}

revdep_packages_md <- function(dependencies) {
  paste0(
    "## Packages\n\n",
    paste(knitr::kable(dependencies), collapse = "\n")
  )
}

revdep_check_results_md <- function(results, has_problem) {
  if (has_problem) {
    problems <- vapply(results, has_problems, logical(1))
    results <- results[problems]
    msg <- "packages with problems"
  } else {
    msg <- "packages"
  }

  summaries <- vapply(results, format, character(1))

  paste0(
    "# Check results\n",
    paste0(length(summaries), " ", msg, "\n\n"),
    paste0(summaries, collapse = "\n")
  )
}

#' @export
format.revdep_check_result <- function(x, ...) {
  meta <- c(
    "Maintainer" = x$maintainer,
    "Bug reports" = x$bug_reports
  )
  meta_string <- paste(names(meta), ": ", meta, collapse = "  \n", sep = "")

  header <- paste0(
    "## ", x$package, " (", x$version, ")\n",
    meta_string,
    "\n"
  )

  summary <- summarise_check_results(x$results)
  if (length(unlist(x$results)) > 0) {
    checks <- paste0("\n```\n", format(x$results), "\n```\n")
  } else {
    checks <- ""
  }

  paste0(header, "\n", summary, "\n", checks)
}

#' @export
print.revdep_check_result <- function(x, ...) {
  cat(format(x, ...), "\n", sep = "")
}

#' @rdname revdep_check
#' @export
revdep_check_print_problems <- function(pkg = ".") {
  pkg <- as.package(pkg)

  summaries <- readRDS(revdep_check_path(pkg))$results

  problems <- vapply(summaries, function(x) first_problem(x$results), character(1))
  problems <- problems[!is.na(problems)]

  dep_fail <- grepl("checking package dependencies", problems, fixed = TRUE)
  inst_fail <- grepl("checking whether package .+ can be installed", problems)

  pkgs <- names(problems)
  if (any(dep_fail)) {
    bad <- paste(pkgs[dep_fail], collapse = ", ")
    cat("* Failed to install dependencies for: ", bad, "\n", sep = "")
  }
  if (any(inst_fail)) {
    bad <- paste(pkgs[inst_fail], collapse = ", ")
    cat("* Failed to install: ", bad, "\n", sep = "")
  }

  if (length(problems) > 0) {
    other <- problems[!inst_fail & !dep_fail]
    cat(paste0("* ", names(other), ": ", other, "\n"), sep = "")
  } else {
    cat("No ERRORs or WARNINGs found :)\n")
  }
}
