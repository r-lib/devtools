system_check <- function(cmd) {
  res <- system(cmd)
  if (res != 0) {
    stop("Command failed (", res, ")", call. = FALSE)
  }
  invisible(TRUE)
}

R <- function(options, path = tempdir()) {
  r_path <- shQuote(file.path(R.home("bin"), "R"))
  options <- paste(options, collapse = " ")
  in_dir(path, system_check(paste("LC_ALL=C", r_path, options)))
}
