#' Run a system command and check if it succeeds.
#'
#' @param cmd Command to run. Will be quoted by \code{\link{shQuote}()}.
#' @param args A character vector of arguments.
#' @param env_vars A named character vector of environment variables.
#' @param path Path in which to execute the command
#' @param quiet If \code{FALSE}, the command to be run will be echoed.
#' @param throw If \code{TRUE}, will throw an error if the command fails
#'   (i.e. the return value is not 0).
#' @param ... additional arguments passed to \code{\link[base]{system}}
#' @keywords internal
#' @export
#' @return (Invisibly) the return value of the function.
system_check <- function(cmd, args = character(), env_vars = character(),
                         path = ".", quiet = FALSE, throw = TRUE,
                         ...) {
  full <- paste(shQuote(cmd), " ", paste(args, collapse = " "), sep = "")

  if (!quiet) {
    message(wrap_command(full))
    message()
  }

  result <- suppressWarnings(withr::with_dir(path, withr::with_envvar(env_vars,
    system(full, intern = quiet, ignore.stderr = quiet, ...)
  )))

  if (quiet) {
    status <- attr(result, "status") %||% 0L
  } else {
    status <- result
  }

  ok <- identical(as.character(status), "0")
  if (throw && !ok) {
    stop("Command failed (", status, ")", call. = FALSE)
  }

  invisible(status)
}

#' Run a system command and capture the output.
#'
#' @inheritParams system_check
#' @return command output if the command succeeds, an error will be thrown if
#' the command fails.
#' @keywords internal
#' @export
system_output <- function(cmd, args = character(), env_vars = character(),
                          path = ".", quiet = FALSE, ...) {
  full <- paste(shQuote(cmd), " ", paste(args, collapse = " "), sep = "")

  if (!quiet) {
    message(wrap_command(full), "\n")
  }

  result <- withCallingHandlers(withr::with_dir(path,
      withr::with_envvar(env_vars,
        system(full, intern = TRUE, ignore.stderr = quiet, ...)
        )), warning = function(w) stop(w))

  result
}

wrap_command <- function(x) {
  lines <- strwrap(x, getOption("width") - 2, exdent = 2)
  continue <- c(rep(" \\", length(lines) - 1), "")
  paste(lines, continue, collapse = "\n")
}
