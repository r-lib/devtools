system_check <- function(cmd) {
  res <- system(cmd)
  if (res != 0) {
    stop("Command failed (", res, ")", call. = FALSE)
  }
  invisible(TRUE)
}

R <- function(options) {
  r_path <- shQuote(file.path(R.home("bin"), "R"))
  system_check(paste(r_path, options))
  
}