system_check <- function(cmd) {
  res <- system(cmd)
  if (res != 0) {
    stop("Command failed (", res, ")", call. = FALSE)
  }
  invisible(TRUE)
}