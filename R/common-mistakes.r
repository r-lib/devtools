# Trace multiple functions with same tracer.
#
# @keywords programming
# @examples
# \dontrun{
# trace_all(
#   functions_with_arg("na.rm", "package:base"),
#   quote(if (!na.rm) warning("na.rm = FALSE"))
# )
# trace_all(
#   functions_with_arg("drop", "package:base"),
#   quote(if (drop) warning("drop = TRUE"))
# )
# }
trace_all <- function(fs, tracer) {
  lapply(fs, trace, exit = tracer, print = FALSE)
  invisible()
}

# Find all functions with specified argument.
#
# @keywords programming
# @examples
# \dontrun{
# functions_with_arg("drop", "package:base")
# functions_with_arg("na.rm", "package:base")
# }
functions_with_arg <- function(arg, pos) {
  fs <- ls(pos=pos)

  has_arg <- function(f) {
    (is.function(f) || is.primitive(f)) && !is.null(formals(f)[[arg]])
  }

  Filter(function(x) has_arg(get(x)), fs)
}


# Force full specification of logicals
# makeActiveBinding("T", function(value) stop("Use TRUE!", call. = FALSE), globalenv())
# makeActiveBinding("F", function(value) stop("Use FALSE!", call. = FALSE), globalenv())
