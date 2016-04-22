# The checking code looks for the objects in the package namespace, so defining
# dll here removes the following NOTE
# Registration problem:
#   Evaluating 'dll$foo' during check gives error
# 'object 'dll' not found':
#    .C(dll$foo, 0L)
# See https://github.com/wch/r-source/blob/d4e8fc9832f35f3c63f2201e7a35fbded5b5e14c/src/library/tools/R/QC.R#L1950-L1980
# Setting the class is needed to avoid a note about returning the wrong class.
# The local object is found first in the actual call, so current behavior is
# unchanged.
dll <- list(foo = structure(list(), class = "NativeSymbolInfo"))

#' Check if you have a development environment installed.
#'
#' Thanks to the suggestion of Simon Urbanek.
#'
#' @return TRUE if your development environment is correctly set up, otherwise
#'   returns an error.
#' @export
#' @examples
#' has_devel()
has_devel <- function() {
  foo_path <- file.path(tempdir(), "foo.c")

  cat("void foo(int *bar) { *bar=1; }\n", file = foo_path)
  on.exit(unlink(foo_path))

  R("CMD SHLIB foo.c", tempdir())
  dylib <- file.path(tempdir(), paste("foo", .Platform$dynlib.ext, sep=''))
  on.exit(unlink(dylib), add = TRUE)

  dll <- dyn.load(dylib)
  on.exit(dyn.unload(dylib), add = TRUE)

  stopifnot(.C(dll$foo, 0L)[[1]] == 1L)
  TRUE
}
