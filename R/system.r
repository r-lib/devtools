# @param arg a vector of command arguments.
# @param env a named character vector.  Will be quoted
system_check <- function(cmd, args = character(), env = character(),
                         quiet = FALSE, ...) {
  full <- paste(shQuote(cmd), " ", paste(args, collapse = ", "), sep = "")

  if (!quiet) {
    message(wrap_command(full))
    message()
  }

  result <- suppressWarnings(with_env(env,
    system(full, intern = quiet, ignore.stderr = quiet, ...)
  ))

  if (quiet) {
    status <- attr(result, "status") %||% 0
  } else {
    status <- result
  }

  if (!identical(as.character(status), "0")) {
    stop("Command failed (", status, ")", call. = FALSE)
  }

  invisible(TRUE)
}

# R("-e 'str(as.list(Sys.getenv()))' --slave")
R <- function(options, path = tempdir(), env_vars = NULL, ...) {
  options <- paste("--vanilla", options)
  r_path <- file.path(R.home("bin"), "R")

  env <- c(
    "LC_ALL" = "C",
    "R_LIBS" = paste(.libPaths(), collapse = .Platform$path.sep),
    "CYGWIN" = "nodosfilewarning",
    "R_TESTS" = "",
    "NOT_CRAN" = "true",
    "TAR" = auto_tar(),
    env_vars)
    # When R CMD check runs tests, it sets R_TESTS. When the tests
    # themeselves run R CMD xxxx, as is the case with the tests in
    # devtools, having R_TESTS set causes errors because it confuses
    # the R subprocesses. Unsetting it here avoids those problems.

  # If rtools has been detected, add it to the path only when running R...
  if (!is.null(get_rtools_path())) {
    old <- add_path(get_rtools_path(), 0)
    on.exit(set_path(old))
  }

  in_dir(path, system_check(r_path, options, env, ...))
}

# Determine the best setting for the TAR environmental variable
# This is needed for R <= 2.15.2 to use internal tar. Later versions don't need
# this workaround, and they use R_BUILD_TAR instead of TAR, so this has no
# effect on them.
auto_tar <- function() {
  tar <- Sys.getenv("TAR", unset = NA)
  if (!is.na(tar)) return(tar)

  windows <- .Platform$OS.type == "windows"
  no_rtools <- is.null(get_rtools_path())
  if (windows && no_rtools) "internal" else ""
}

RCMD <- function(cmd, options, path = tempdir(), env_vars = NULL, ...) {
  options <- paste(options, collapse = " ")
  R(paste("CMD", cmd, options), path = path, env_vars = env_vars, ...)
}

wrap_command <- function(x) {
  lines <- strwrap(x, getOption("width") - 2, exdent = 2)
  continue <- c(rep(" \\", length(lines) - 1), "")
  paste(lines, continue, collapse = "\n")
}
