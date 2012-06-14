# @param arg a vector of command arguments.
# @param env a named character vector.  Will be quoted
system_check <- function(cmd, args = character(), env = character(), ...) {
  with_env(env, {
    res <- system2(cmd, args = args, ...)
  })
  if (res != 0) {
    stop("Command failed (", res, ")", call. = FALSE)
  }
  
  invisible(TRUE)
}

R <- function(options, path = tempdir(), ...) {
  r_path <- file.path(R.home("bin"), "R")
  
  env <- c(
    "R_ENVIRON_USER" = tempfile(),
    "LC_ALL" = "C", 
    "R_LIBS" = paste(.libPaths(), collapse = .Platform$path.sep),
    "CYGWIN" = "nodosfilewarning")
   
  in_dir(path, system_check(r_path, options, env, ...))
}
