# @param arg a vector of command arguments.
# @param env a named character vector.  Will be quoted
system_check <- function(cmd, args = character(), env = character()) {
  env[] <- shQuote(env)
  env <- paste(names(env), env, sep = "=")
  
  res <- system2(cmd, args = args, env = env)
  if (res != 0) {
    stop("Command failed (", res, ")", call. = FALSE)
  }    
  
  invisible(TRUE)
}

R <- function(options, path = tempdir()) {
  r_path <- file.path(R.home("bin"), "R")
  
  env <- c("LC_ALL" = "C", "R_LIBS" = paste(.libPaths(), collapse = ":"))
   
  in_dir(path, system_check(r_path, options, env))
}
