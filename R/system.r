system_check <- function(cmd) {
  if (os() == "win") {
    shell(cmd, mustWork = TRUE)
  } else {
    res <- system(cmd)
    if (res != 0) {
      stop("Command failed (", res, ")", call. = FALSE)
    }    
  }
  
  invisible(TRUE)
}

R <- function(options, path = tempdir()) {
  r_path <- shQuote(file.path(R.home("bin"), "R"))
  options <- paste(options, collapse = " ")
  
  if (os() == "win") {
    lc <- "SET LC_ALL = C && "
  } else {
    lc <- "LC_ALL=C "
  }
   
  cmd <- paste(lc, r_path, " ", options, sep = "")
  in_dir(path, system_check(cmd))
}
