#' Temporarily set debugging compilation flags.
#'
#' @param code to execute.
#' @param PKG_CFLAGS flags for compiling C code
#' @param PKG_CXXFLAGS flags for compiling C++ code
#' @param PKG_FFLAGS flags for compiling Fortran code.
#' @param PKG_FCFLAGS flags for Fortran 9x code.
#' @export
#' @examples
#' \dontrun{
#' install("mypkg")
#' with_debug(install("mypkg"))
#' }
with_debug <- function(code,
                       PKG_CFLAGS   = "-UNDEBUG -Wall -pedantic -g -O0",
                       PKG_CXXFLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
                       PKG_FFLAGS   = "-g -O0",
                       PKG_FCFLAGS  = "-g -O0") {
  flags <- c(
    PKG_CFLAGS = PKG_CFLAGS, PKG_CXXFLAGS = PKG_CXXFLAGS,
    PKG_FFLAGS = PKG_FFLAGS, PKG_FCFLAGS = PKG_FCFLAGS)

  with_envvar(flags, code)
}

