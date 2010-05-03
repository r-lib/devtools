trace_all <- function(fs, tracer) {
  lapply(fs, trace, exit = tracer, print=FALSE)
  invisible()
}

functions_with_arg <- function(arg, pos) {
  fs <- ls(pos=pos)
  present <- unlist(lapply(fs, function(x) 
    (is.function(get(x)) || is.primitive(get(x))) &&  !is.null(formals(x)[[arg]])))

  fs[present]
}

trace_all(
  functions_with_arg("drop", "package:base"), 
  quote(if (drop) warning("na.rm = FALSE"))
)


#trace_all(list("sum"), quote(if (!na.rm) warning("na.rm = FALSE")))

trace_all(
  functions_with_arg("drop", "package:base"), 
  quote(if (drop) warning("drop = TRUE"))
)


#T <- function() {}
#F <- function() {}