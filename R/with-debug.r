#' Temporarily set debugging compilation flags.
#'
#' @param code to execute.
#' @param PKG_CFLAGS flags for compiling C code
#' @param PKG_CXXFLAGS flags for compiling C++ code
#' @param PKG_FFLAGS flags for compiling Fortran code.
#' @param PKG_FCFLAGS flags for Fortran 9x code.
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
with_debug <- function(code, PKG_CFLAGS = NULL, PKG_CXXFLAGS = NULL,
                       PKG_FFLAGS = NULL, PKG_FCFLAGS = NULL, debug = TRUE,
                       action = "replace") {

  defaults <- compiler_flags(debug = debug)
  flags <- c(
    PKG_CFLAGS = PKG_CFLAGS, PKG_CXXFLAGS = PKG_CXXFLAGS,
    PKG_FFLAGS = PKG_FFLAGS, PKG_FCFLAGS = PKG_FCFLAGS)

  flags <- unlist(modifyList(as.list(defaults), as.list(flags)))

  with_envvar(flags, code, action = action)
}

#' Default compiler flags used by devtools.
#'
#' These default flags enforce good coding practice by ensuring that
#' \env{PKG_CFLAGS} and \env{PKG_CXXFLAGS} are set to \code{-Wall -pedantic}.
#' These tests are run by cran and are generally considered to be good practice.
#'
#' By default \code{\link{compile_dll}} is run with \code{compiler_flags(TRUE)},
#' and check with \code{compiler_flags(FALSE)}.  If you want to avoid the
#' possible performance penalty from the debug flags, install the package.
#'
#' @param debug If \code{TRUE} adds \code{-g -O0} to all flags
#'   (Adding \env{PKG_FFLAGS} and \env{PKG_FCFLAGS}
#' @family debugging flags
#' @export
#' @examples
#' compiler_flags()
#' compiler_flags(TRUE)
compiler_flags <- function(debug = FALSE) {
  if (debug) {
    c(
      PKG_CFLAGS   = "-UNDEBUG -Wall -pedantic -g -O0",
      PKG_CXXFLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
      PKG_FFLAGS   = "-g -O0",
      PKG_FCFLAGS  = "-g -O0"
    )
  } else {
    c(
      PKG_CFLAGS   = "-Wall -pedantic",
      PKG_CXXFLAGS = "-Wall -pedantic"
    )
  }
}
