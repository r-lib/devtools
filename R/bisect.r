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
#' @seealso \code{\link{bisect_load_all}}
#' @seealso \code{\link{bisect_install}}
#' @seealso \code{\link{bisect_return_interactive}}
#' 
#' @param fun      The test function
#' @param on_error What to do if loading throws an error 
#'                  (default \code{NA}, or mark as skip)
#' @param msg  A message to print to the console when running the test
#' @export
bisect_runtest <- function(fun, on_error = NA, msg = "Running test...") {

  # Check that fun is a function -- easy to accidentally pass myfun()
  # instead of myfun.
  if (!is.function(fun)) {
    stop("'fun' is not a function. Make sure to pass 'myfunction' and not 'myfunction()'")
  }

  message(msg)

  error_fun <- function(e) {
    message(e)
    message("Error encountered in test.")
    return(on_error)
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


#' Like \code{load_all}, but for bisect tests.
#'
#' If the package fails to load, mark this commit as skip (by returning \code{NA}).
#'
#' @seealso \code{\link{bisect_install}}
#' @seealso \code{\link{bisect_runtest}}
#' @seealso \code{\link{bisect_return_interactive}}
#'
#' @param pkgdir   The directory to load from
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


#' Install a package from source, for bisect tests.
#'
#' If the installation fails, the default behavior is to mark this commit
#' as skip (by returning \code{NA}).
#'
#' This function is usually used together with \code{bisect_require}.
#'
#' @seealso \code{\link{bisect_require}}
#' @seealso \code{\link{bisect_load_all}}
#' @seealso \code{\link{bisect_runtest}}
#' @seealso \code{\link{bisect_return_interactive}}
#'
#' @param pkgdir  The directory to load from
#' @param on_fail What to do if installation fails (default NA, or mark as skip)
#' @export
bisect_install <- function(pkgdir = ".", on_fail = NA) {
  # install.packages always returns NULL. When it fails, it throws a warning, so
  # we'll catch it and return FALSE to indicate failure
  bisect_runtest(function() {
      tryCatch(install.packages(pkgdir, repos = NULL, type = 'source'),
               warning = function(w) { message(w); stop(); })
    },
    on_error = on_fail,
    msg = paste("Installing package in directory", pkgdir)
  )
}


#' Load a package like \code{require()}, for bisect tests.
#'
#' If the package fails to load, the default behavior is to mark this commit
#' as skip (by returning \code{NA}).
#'
#' This function is usually used together with \code{bisect_install}.
#'
#' @seealso \code{\link{bisect_install}}
#' @seealso \code{\link{bisect_load_all}}
#' @seealso \code{\link{bisect_runtest}}
#' @seealso \code{\link{bisect_return_interactive}}
#'
#' @param package Name of package
#' @param on_fail What to do if loading fails (default NA, or mark as skip)
#' @export
bisect_require <- function(package, on_fail = NA) {
  
  package <- as.character(substitute(package))

  # With require(), success returns TRUE and failure returns FALSE
  # but we need to pass different return values to bisect_runtest().
  # If success loading, do nothing (NULL); if failure, return on_fail
  bisect_runtest(function() {
      if (require(package, character.only = TRUE))
        return(NULL)
      else
        return(on_fail)
    },
    msg = paste("Loading package", package)
  )
}


#' Prompt the user for an interactive good/bad/skip response and return
#' the appropriate value (to be passed to \code{bisect_runtest}).
#'
#' @seealso \code{\link{bisect_runtest}}
#' @seealso \code{\link{bisect_load_all}}
#' @seealso \code{\link{bisect_install}}
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
