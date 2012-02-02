#' Run a test function for git bisect testing.
#'
#' If the function returns \code{TRUE}, quit and mark this
#' commit as good. If the function returns \code{FALSE}, quit and mark this
#' commit as bad. If the function returns \code{NA}, quit and mark this
#' commit as skip. If the function returns \code{NULL}, do nothing.
#'
#' It is also important to set \code{on_error}. This tells it what to
#' do when the test function throws an error. The default behavior is to
#' mark this commit as skip (\code{NA}). However, in some cases, it makes
#' sense to mark this commit as bad (\code{FALSE}) if an error is thrown.
#'
#' @seealso \code{\link{bisect_load_and_test}}
#' @seealso \code{\link{bisect_load_all}}
#' @seealso \code{\link{bisect_return_interactive}}
#' 
#' @param fun      The test function
#' @param on_error What to do if loading throws an error 
#'                  (default \code{NA}, or mark as skip)
#' @param msg  A message to print to the console when running the test
#' @export
bisect_runtest <- function(fun, on_error = NA, msg = "Running test...") {
  message(msg)

  if (is.na(on_error)) {
    error_fun <- function(e) {
      print(e)
      message("Error encountered in test.")
      return(NA)
    }
  } else if (on_error == TRUE) {
    error_fun <- function(e) {
      print(e)
      message("Error encountered in test.")
      return(TRUE)
    }
  } else if (on_error == FALSE) {
    error_fun <- function(e) {
      print(e)
      message("Error encountered in test.")
      return(FALSE)
    }
  }

  status <- tryCatch(fun(), error = error_fun)
  
  if (is.null(status)) {
    # Return NULL, but don't print
    invisible(NULL)
  } else if (is.na(status)) {
    mark_commit_skip()
  } else if (status == TRUE) {
    mark_commit_good()
  } else if (status == FALSE) {
    mark_commit_bad()
  }
}


#' Like \code{load_all}, but for bisect tests. If the package fails to
#' load, mark this commit as skip (by returning \code{NA}).
#'
#' @seealso \code{\link{bisect_load_and_test}}
#' @seealso \code{\link{bisect_runtest}}
#' @seealso \code{\link{bisect_return_interactive}}
#'
#' @param dir      The directory to load from
#' @param on_error What to do if loading throws an error 
#'                  (default NA, or mark as skip)
#' @export
bisect_load_all <- function(pkgdir = ".", on_error = NA) {
  bisect_runtest(function() {
      load_all(pkgdir)
    }, 
    on_error = on_error,
    msg = paste("Loading package in directory", pkgdir))
}


#' Prompt the user for an interactive good/bad/skip response and return
#' the appropriate value (to be passed to \code{bisect_runtest}).
#'
#' @seealso \code{\link{bisect_load_and_test}}
#' @seealso \code{\link{bisect_runtest}}
#' @seealso \code{\link{bisect_load_all}}
#'
#' @export
bisect_return_interactive <- function () {
  while (1) {
    message("Mark this commit [g]ood, [b]ad, or [s]kip? ", appendLF = FALSE)
    
    # Need to use "stdin" to get user input in a script -- stdin() doesn't work
    response <- scan("stdin", what = character(), n = 1, quiet = TRUE) 
    
    if (identical(tolower(response), "g")) {
      return(TRUE)
    } else if (identical(tolower(response), "b")) {
      return(FALSE)
    } else if (identical(tolower(response), "s")) {
      return(NA)
    } else {
      message(paste("Unknown response:", response))
    }
  }
}



#' Loads a source package from a directory and runs a test function.
#'
#' @seealso \code{\link{bisect_runtest}}
#' @seealso \code{\link{bisect_load_all}}
#' @seealso \code{\link{bisect_return_interactive}}
#'
#' @export
bisect_load_and_test <- function(fun, pkgdir = ".", on_load_error = NA, on_run_error = NA) {
  bisect_load_all(pkgdir = pkgdir, on_error = on_load_error)
  bisect_runtest(fun = fun, on_error = on_run_error)
}


# ===========================================================
# Functions to quit with return code for marking commits

mark_commit_good <- function() {
  message("Returning code: good (0)\n")
  quit(status = 0)
}

mark_commit_bad <- function() {
  message("Returning code: bad (1)\n")
  quit(status = 1)
}

mark_commit_skip <- function() {
  message("Returning code: skip (125)\n")
  quit(status = 125)
}
