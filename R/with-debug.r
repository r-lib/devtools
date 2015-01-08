#' Temporarily set debugging compilation flags.
#'
#' @param code to execute.
#' @param CFLAGS flags for compiling C code
#' @param CXXFLAGS flags for compiling C++ code
#' @param FFLAGS flags for compiling Fortran code.
#' @param FCFLAGS flags for Fortran 9x code.
#' @inheritParams with_envvar
#' @inheritParams compiler_flags
#' @family debugging flags
#' @export
#' @examples
#' flags <- names(compiler_flags(TRUE))
#' with_debug(Sys.getenv(flags))
#'
#' \dontrun{
#' install("mypkg")
#' with_debug(install("mypkg"))
#' }
with_debug <- function(code, CFLAGS = NULL, CXXFLAGS = NULL,
                       FFLAGS = NULL, FCFLAGS = NULL, debug = TRUE,
                       action = "replace") {

  defaults <- compiler_flags(debug = debug)
  flags <- c(
    CFLAGS = CFLAGS, CXXFLAGS = CXXFLAGS,
    FFLAGS = FFLAGS, FCFLAGS = FCFLAGS
  )

  flags <- unlist(modifyList(as.list(defaults), as.list(flags)))

  with_envvar(flags, code, action = action)
}

#' Default compiler flags used by devtools.
#'
#' These default flags enforce good coding practice by ensuring that
#' \env{CFLAGS} and \env{CXXFLAGS} are set to \code{-Wall -pedantic}.
#' These tests are run by cran and are generally considered to be good practice.
#'
#' By default \code{\link{compile_dll}} is run with \code{compiler_flags(TRUE)},
#' and check with \code{compiler_flags(FALSE)}.  If you want to avoid the
#' possible performance penalty from the debug flags, install the package.
#'
#' @param debug If \code{TRUE} adds \code{-g -O0} to all flags
#'   (Adding \env{FFLAGS} and \env{FCFLAGS}
#' @family debugging flags
#' @export
#' @examples
#' compiler_flags()
#' compiler_flags(TRUE)
compiler_flags <- function(debug = FALSE) {
  if (Sys.info()[["sysname"]] == "SunOS") {
    c(
      CFLAGS   = "-g",
      CXXFLAGS = "-g"
    )
  } else if (debug) {
    c(
      CFLAGS   = "-UNDEBUG -Wall -pedantic -g -O0",
      CXXFLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
      FFLAGS   = "-g -O0",
      FCFLAGS  = "-g -O0"
    )
  } else {
    c(
      CFLAGS   = "-Wall -pedantic",
      CXXFLAGS = "-Wall -pedantic"
    )
  }
}
